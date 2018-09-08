a=imread('A_10_0.jpg');
detector = vision.CascadeObjectDetector;
bbox=step(detector,a);
bbox(1,2)=bbox(1,2)+bbox(1,4)/2;
bbox(1,4)=bbox(1,4)/2;
tx=bbox(1,1);
ty=bbox(1,2);
out=imcrop(a,bbox);
detector = vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=100;
bbox=step(detector,out);
tx=tx+bbox(1,1);
ty=ty+bbox(1,2);
gonion_line=bbox(4)*0.70;
lip=imcrop(out,bbox);
c=corner(lip);
g=histeq(lip,256);
[t,sm]=graythresh(g);
g=im2bw(g,t);
figure,imshow(a);
%figure,imshow(a);
hold on;
h=imhist(g);
xy=zeros(h(1),2);
z=1;
for i=1:numel(g(:,1))
    for j=1:numel(g(1,:))
        if(g(i,j)==0)
            xy(z,1)=j;
            xy(z,2)=i;
            z=z+1;
        end
    end
end
%plot(xy(:,1),xy(:,2),'y.')
gonup=0;
gondown=0;
for i=1:numel(xy(:,1))
    if(xy(i,2)<gonion_line)
        gonup=gonup+1;
    else
        gondown=gondown+1;
    end
end
gonupxy=zeros(gonup,2);
count=1;
for i=1:numel(xy(:,1))
    if(xy(i,2)<gonion_line)
        gonupxy(count,1)=xy(i,1);
        gonupxy(count,2)=xy(i,2);
        count=count+1;
    end
end
gonratio=gonup/gondown;

if(gonratio<=2.3)
   e=fit_ellipse(gonupxy(:,1),gonupxy(:,2));
else
   e=fit_ellipse(xy(:,1),xy(:,2));
end

%e=fit_ellipse(xy(:,1),xy(:,2));
t=-pi:0.01:pi;
x1=e.X0+e.a*cos(t);
y1=e.Y0+e.b*sin(t);
%plot(x1,y1,'w.');
plot(e.X0+tx,e.Y0+ty+e.b,'y*');
plot(e.X0+tx,e.Y0+ty-e.b,'y*');
brech=2*e.b;
%plot(e.X0+tx+e.a,e.Y0+ty,'r*');
%plot(e.X0+tx-e.a,e.Y0+ty,'r*');
%plot(c(:,1),c(:,2),'w.');
cc=zeros(numel(c(:,1)),2);
count=1;
sr=12;
for i=1:numel(c(:,1))
    if(((c(i,2)<e.Y0)&&(c(i,2)>(e.Y0-sr)))&&((((c(i,1))<(e.X0-e.a+sr))&&((c(i,1))>(e.X0-e.a-sr)))||(((c(i,1))<(e.X0+e.a+sr))&&((c(i,1))>(e.X0+e.a-sr)))))
        cc(count,1)=c(i,1);
        cc(count,2)=c(i,2);
        count=count+1;
    else
        cc(count,1)=e.X0;
        cc(count,2)=e.Y0;
        count=count+1;
    end
end
%plot(cc(:,1)+tx,cc(:,2)+ty,'y.');
[mx,i]=max(cc(:,1))
plot(mx+tx,cc(i,2)+ty,'y*');
p1=cc(i,2);
[mn,i]=min(cc(:,1))
plot(mn+tx,cc(i,2)+ty,'y*');
p2=cc(i,2);
lench=sqrt((mx-mn)^2+(p1-p2)^2);
disp(lench);
disp(brech);
