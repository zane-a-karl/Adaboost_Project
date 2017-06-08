function [ edges ] = nice_hists_compare( Y_F_i, Y_NF_i, M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    min1 = min(min(Y_F_i), min(Y_NF_i));
    max1 = max(max(Y_F_i), max(Y_NF_i));
    edges = linspace(min1, max1, M+1);


end

