clear all
close all
clc

%Define Image (IM) Paths
path_IM='C:\Users\aytekin\Desktop\HWI_RESULTS\';

%Define Output Folder (OUT) Path 
path_OUT='C:\Users\aytekin\Desktop\HWI_RESULTS\';

mkdir(write_path); %In case it doesn't exist

%Change the .jpg extension accordingly if needed
contents=dir([path_IM '*.jpg']);


for i=1:length(contents)
    name=contents(i).name;
    name=name(1:end-4);
    imname=strcat(path_IM,name,'.jpg');
    image_now=(imread(imname));
    
    %if image is gray-level convert it to RGB by repeating the gray level
    %image for each channel
    if length(size(image_now))==2;
        image_now=repmat(image_now,[1 1 3]);
    end
    
    %Check if the image contains any frames and exclude them
    [image_now,w]=removeframe(image_now);
    
    %Run PSE for several resolutions (Expected number of superpixels:
    % 300,600,1200 and regularizer 20 is kept) 
    [SalMapRes1]=PSE(image_now,round(sqrt(numel(image_now(:,:,1))/300)),20);
    [SalMapRes2]=PSE(image_now,round(sqrt(numel(image_now(:,:,1))/600)),20);
    [SalMapRes3]=PSE(image_now,round(sqrt(numel(image_now(:,:,1))/1200)),20);
    
    %Average Over Resolutions
    SalMap=mat2gray(SalMapRes1)+mat2gray(SalMapRes2)+mat2gray(SalMapRes3);
    
    %Map Back to the Original Image (if frames were excluded)
    SalMapOrig=zeros(w(1),w(2));
    SalMapOrig(w(3):w(4),w(5):w(6))=SalMap;
    
    %Discretize the Saliency Map to uint8 format
    SalMapFinal=uint8(mat2gray(SalMapOrig)*255);
    
    %Save the result
    imwrite(SalMapFinal,[path_OUT name '_PSE.png']);
    
end
