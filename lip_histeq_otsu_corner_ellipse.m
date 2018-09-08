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
figure,imshow(lip);
g=histeq(lip,256);
[t,sm]=graythresh(g);
g=im2bw(g,t);
figure,imshow(g)
hold on;
c=corner(g);
plot(c(:,1),c(:,2),'r.')
e=fit_ellipse(c(:,1),c(:,2));
t=-pi:0.01:pi;
x1=e.X0+e.a*cos(t);
y1=e.Y0+e.b*sin(t);
plot(x1,y1,'r.');
