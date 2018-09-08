a=imread('A_02_0.jpg');
%a=imresize(a,0.1);
%a=rgb2gray(a);
%hold on;
detector = vision.CascadeObjectDetector;
bbox=step(detector,a);
point=bbox2points(bbox);
bbox(1,2)=bbox(1,2)+bbox(1,4)/2;
bbox(1,4)=bbox(1,4)/2;
%{
dl=bbox(1,3)/4;
db=bbox(1,4)/4;
bbox(1,1)=bbox(1,1)+dl;
bbox(1,2)=bbox(1,2)+db;
bbox(1,3)=bbox(1,3)-dl-dl;
bbox(1,4)=bbox(1,4)-db-db;
%}
out=imcrop(a,bbox);
detector = vision.CascadeObjectDetector('Mouth');
detector.MergeThreshold=100;
bbox=step(detector,out);
out=insertObjectAnnotation(out,'rectangle',bbox,'detection');
%bw=edge(out,'canny');
lip=imcrop(out,bbox)
lip=rgb2gray(lip);
%lip=imresize(lip,4)
lip=imadjust(lip,[.294117 .392156],[1 0]);
%lip=edge(lip);
imshow(lip);
%{
h=imhist(lip,10)
bsp=linspace(0,255,10);
bar(bsp,h);
%}



