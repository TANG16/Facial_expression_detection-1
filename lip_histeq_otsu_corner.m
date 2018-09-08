a=imread('A_02_0.jpg');
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
figure,imshow(lip);
g=histeq(lip,256);
[t,sm]=graythresh(g);
g=im2bw(g,t);
figure,imshow(g)
hold on;
c=corner(g);
x=c(:,1);
y=c(:,2);
plot(x,y,'r*')
