a=imread('A_02_0.jpg');
detector = vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=350;
bbox=step(detector,a);
point=bbox2points(bbox)
out=insertObjectAnnotation(a,'rectangle',bbox,'detection');
%imshow(out)
lb(1,1)=point(2,1)-point(1,1)
lb(1,2)=point(3,2)-point(2,2)
%rtog=rgb2gray(a);
%rtog=a;
%imshow(rtog);
%hold on;
b=imcrop(a,bbox);
imshow(b);
hold on;
c=corner(b);
[m,i]=max(c(:,1));
plot(c(i,1),c(i,2),'r*');
[m,i]=min(c(:,1));
plot(c(i,1),c(i,2),'r*');