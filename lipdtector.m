a=imread('A_01_0.jpg');
imresize(a,0.09);
detector = vision.CascadeObjectDetector;
bbox=step(detector,a)
out=insertObjectAnnotation(a,'rectangle',bbox,'Face Detected');
imshow(out)