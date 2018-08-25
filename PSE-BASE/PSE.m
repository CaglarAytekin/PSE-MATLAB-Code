%   Extended Quantum Cuts
%   Implementation of the Pattern Recognition 2018 paper: 
%   Çaglar Aytekin, Alexandros Iosifidis and Moncef Gabbouj,
%    "Probabilistic saliency estimation", Pattern Recognition, vol. 74, pp. 359-372, 2018
%
%   Inputs: 
%   image_now: RGB, double, RGB image (range between 0,255)
%   suppix_size: expected squareroot of a superpixel area
%   m: SLIC regularizer between spatial and color features
%   bkg: if 1, runs a robust background estimation algorithm, else takes the image boundaries as background. Results will be a little lower in precision, however, substantially higher in recall, run time may be increased a bit
%   smooth: if 1, instead of the original eigenvector square as saliency map, takes the absolute, which produces less sharper saliency masks
%
%   Output:
%   SalMap: Saliency map

function [SalMap]=PSE(image_now,suppix_size,m,smooth)

%Find Superpixels, LAB Mean values and superpixel indices on image boundary
[LMean, AMean, BMean, suppixel, boundaries,PixNum, LabelLine,width, height]=SolveSlic(image_now,suppix_size,m);

%Find Extended Neighbours
[neighbourhood,LF,max_label]=FindNeighbours(suppixel);

%Find Distance Between All Superpixels
ALL_DIST=DistFind(LMean,AMean,BMean,max_label);

%Assign Affinities
H=AffinityAssign(neighbourhood,LF,ALL_DIST,max_label);

%Estimate Possible Foreground 
H=UpdateDiagonal(H,boundaries);

%Calculate Saliency Map
SalMap=FindSal(H,PixNum, LabelLine,width, height);


