a=imread('A_07_0.jpg');
detector = vision.CascadeObjectDetector;
bbox=step(detector,a);
point=bbox2points(bbox);
bbox(1,2)=bbox(1,2)+bbox(1,4)/2;
bbox(1,4)=bbox(1,4)/2;
out=imcrop(a,bbox);
detector = vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=100;
bbox=step(detector,out);
lip=imcrop(out,bbox);
figure,imshow(lip)
%c=corner(lip);
g=histeq(lip,256);
[t,sm]=graythresh(g);
g=im2bw(g,t);
figure,imshow(g);
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
%plot(xy(:,2),xy(:,1),'y.')
e=fit_ellipse(xy(:,1),xy(:,2));
t=-pi:0.01:pi;
x1=e.X0+e.a*cos(t);
y1=e.Y0+e.b*sin(t);
plot(x1,y1,'r.');
%plot(c(:,1),c(:,2),'y.')
