%%Ask for input and Read in an image
prompt = 'enter an image: ';
str = input(prompt,'s');

if isempty(str) == false
    image = imread(str);
end 
imshow(image);
%Show the initial image in a figure
figure(1);
imshow(image);
%%
%Start Processing the image.
red = image(:,:,1); 
green = image(:,:,2);
blue =image(:,:,3);

%Removes all red and blue from the image
processed = (green - (red + blue)/2);

figure(2);
imshow(processed);
%%
%Noise reduction on current processed image
processed = imgaussfilt(processed, 0.5);

figure(3);
imshow(processed);

%%
%Thresholding. Finds an adaptive local threshold for the image then
%generates a binary image with it. Generates a lot of noise.

threshold = adaptthresh(processed, 0.7);
processed = imbinarize(processed, threshold);
figure(4);
imshow(processed)

%%
%Binary image processing

SE= strel('sphere',2);
processed = imopen(processed, SE);
figure(5);
imshow(processed);

%Number of nuclei in the processed image.
nuclei = bwconncomp(processed);
fprintf("Number of Nuclei = %d\n", nuclei.NumObjects);
%%
edges = edge(processed, 'canny');
%edges1 = bwconncomp(edges);
figure(6);
imshow(edges);

