close all; clc; clear all;
addpath("Dark-Channel-Haze-Removal-master\");
hazy_img= im2double(imread("TURBID_Dataset\Milk\a10.jpg"));

%% DCP Dehazing
dehazed_img = dehaze_fast(hazy_img, 0.95, 15);
figure;imshow(dehazed_img);

%% Base-Detail Layer Decomposition
detail_layer = hazy_img - dehazed_img;
base_layer   = dehazed_img;
figure;imshow(detail_layer);
%% MEAN CURVATURE FILTER
iters = 3;   
dt    = 0.03; 
enhanced_baselayer = mean_curvature_filter(base_layer, iters, dt);
imwrite(enhanced_baselayer, 'BaseLayer_MCF.png');
%% Fusion
f = enhanced_baselayer+detail_layer;
%% GUIDED FILTER
r  = 6;        
eps = 0.02^2;  
f_final = imguidedfilter(f, f, ...
                         'NeighborhoodSize',[r r], ...
                         'DegreeOfSmoothing', eps);

figure; imshow(f_final);
ref = im2double(imread("TURBID_Dataset\Milk\ref.jpg"));
metricsr = main_calculate_metrics(ref, f_final);

