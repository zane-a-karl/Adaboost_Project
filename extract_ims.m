function [ M ] = extract_ims( path, image_dimensions )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

filePattern = strcat(path, '*', '.pgm'); 
fileList = dir(filePattern);
fileLength = length(fileList);

M = zeros(image_dimensions(1), image_dimensions(2), fileLength);

for i = 1 : fileLength
    thisFileName = fileList(i).name;
    currentFilePath = strcat(path, thisFileName);
    M(:,:,i) = imread(currentFilePath);
end

end

