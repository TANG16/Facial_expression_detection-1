a=imread('A_01_0.jpg');
detector = vision.CascadeObjectDetector;
bbox=step(detector,a);
bbox(1,2)=bbox(1,2)+bbox(1,4)/2;
bbox(1,4)=bbox(1,4)/2;
out=imcrop(a,bbox);
detector = vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=100;
bbox=step(detector,out);
lip=imcrop(out,bbox);
[h,bin]=imhist(lip,50);
%{
h=imhist(lip,15);
bsp=linspace(0,255,15);
k=1;
xy=zeros(h(k),2);
z=1;
imshow(lip);
hold on;
for i=1:numel(lip(:,1))
    for j=1:numel(lip(1,:))
        if(lip(i,j)<k*17&&lip(i,j)>(k-1)*17)
            xy(z,1)=i;
            xy(z,2)=j;
            z=z+1;
        end
    end
end
plot(xy(:,2),xy(:,1),'y.')
figure,bar(bsp,h)
%}
%{
e=fit_ellipse(c(:,1),c(:,2));
t=-pi:0.01:pi;
x1=e.X0+e.a*cos(t);
y1=e.Y0+e.b*sin(t);
plot(x1,y1,'r.');
%}