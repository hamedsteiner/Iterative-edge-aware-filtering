clc
clear
L_img = im2double(imread('Me.png'));
H_img = im2double(imread('Clock.png'));

carpet_flash=im2double(imread('carpet_00_flash.jpg'));
carpet_noflash=im2double(imread('carpet_01_noflash.jpg'));
carpet_result=im2double(imread('carpet_03_our_result.jpg'));

cave_flash=im2double(imread('cave01_00_flash.jpg'));
cave_noflash=im2double(imread('cave01_01_noflash.jpg'));
cave_result=im2double(imread('cave01_03_our_result.jpg'));

lamp_flash=im2double(imread('lamp_00_flash.jpg'));
lamp_noflash=im2double(imread('lamp_01_noflash.jpg'));
lamp_result=im2double(imread('lamp_03_our_result.jpg'));

postdetail_flash=im2double(imread('potsdetail_00_flash.jpg'));
postdetail_noflash=im2double(imread('potsdetail_01_noflash.jpg'));
postdetail_result=im2double(imread('potsdetail_03_our_result.jpg'));

puppets_flash=im2double(imread('puppets_00_flash.jpg'));
puppets_noflash=im2double(imread('puppets_01_noflash.jpg'));
puppets_result=im2double(imread('puppets_03_our_result.jpg'));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
image_filter=H_img;
Image=L_img;
result=L_img;

image_filter = imresize((image_filter), [1068 1080]);
Image= imresize((Image), [1068 1080]);


W=20;
Lambda=1;

h_horizon=H_horizon(image_filter,W);
h_vertical=H_vertical(image_filter,W);
%h_horizon_no=H_horizon(Image,W);
%h_vertical_no=H_vertical(Image,W);

J=Filter_HV(Image,W,Lambda,h_horizon,h_vertical);

%J_no=Filter_HV(Image,W,Lambda,h_horizon_no,h_vertical_no);

%figure, imshowpair(result, J, 'montage'),title("Result vs Filterd, Flash-based filtering, W=7 Lambda =5");
%figure, imshowpair(result, J_no, 'montage'),title("Result vs Filterd, No-Flash-based filtering, W=7 Lambda =5");
%figure, imshowpair(image_filter, Image, 'montage'),title("Flash image                           No-flash image");    



figure, imshowpair(Image, J, 'montage'),title("Low Freq Image filterd by High Freq Image , W=20, Lambda =1");





