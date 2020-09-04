
clc
clear

L_img = im2double(imread('Me.png'));
H_img = im2double(imread('Clock.png'));

image_filter=L_img;
Image=L_img;

W=10;
Lambda=1;


%PART1_1
%{
h_horizon=H_horizon(image_filter,W);
h_vertical=H_vertical(image_filter,W);
J=Image;
J_next=Image;
Size=size(Image);
Height=Size(1);
Width=Size(2);
for iter=1:5
    for i=1:Height
        for j=1:Width
            temp=[0,0,0];
            for k=-W:W
                if(j+k<=Width && j+k>=1)  
                    temp(1)=temp(1)+J(i,j+k,1)*h_horizon(i,j,k+W+1);
                    temp(2)=temp(2)+J(i,j+k,2)*h_horizon(i,j,k+W+1);
                    temp(3)=temp(3)+J(i,j+k,3)*h_horizon(i,j,k+W+1);
                end
            end
            J_next(i,j,1)=temp(1) + Lambda*h_horizon(i,j,W)*(Image(i,j,1)-J(i,j,1));
            J_next(i,j,2)=temp(2) + Lambda*h_horizon(i,j,W)*(Image(i,j,2)-J(i,j,2));
            J_next(i,j,3)=temp(3) + Lambda*h_horizon(i,j,W)*(Image(i,j,3)-J(i,j,3));
        end
    end
    J=J_next;
    if(iter==1)
        F_H=J;
    end
    % Vertical
    for j=1:Width
        for i=1:Height
            temp=[0,0,0];
            for k=-W:W
                if(i+k<=Height && i+k>=1)   
                    temp(1)=temp(1)+J(i+k,j,1)*h_vertical(i,j,k+W+1);
                    temp(2)=temp(2)+J(i+k,j,2)*h_vertical(i,j,k+W+1);
                    temp(3)=temp(3)+J(i+k,j,3)*h_vertical(i,j,k+W+1);
                end
            end
            J_next(i,j,1)=temp(1) + Lambda*h_vertical(i,j,W)*(Image(i,j,1)-J(i,j,1));
            J_next(i,j,2)=temp(2) + Lambda*h_vertical(i,j,W)*(Image(i,j,2)-J(i,j,2));
            J_next(i,j,3)=temp(3) + Lambda*h_vertical(i,j,W)*(Image(i,j,3)-J(i,j,3));
        end
    end
    J=J_next;
    if(iter==1)
        F_V=J;
        %figure, imshow(J),title("first vertical");
    
    elseif(iter==2 )
        S_I=J;
        %figure, imshow(J),title("second iteration"); 

    end
end 

    
figure,imshowpair(F_H,F_V, 'montage'),title("First horizontal                    First vertical");    
figure,imshowpair(S_I, Image, 'montage'),title("Second Iteration                    Original Image");

%}    

%Part1_2
%{
h_horizon=H_horizon(image_filter,W);
h_vertical=H_vertical(image_filter,W);
J1=Filter_HV(Image,W,0.1,h_horizon,h_vertical);
J2=Filter_HV(Image,W,1,h_horizon,h_vertical);
J3=Filter_HV(Image,W,10,h_horizon,h_vertical);
figure,imshowpair(J1,J2, 'montage'),title("Lambda 0.1                    Lambda 1");    
figure,imshow(J3),title("Lambda 10");
%}

%Part1_3

W1=5;
W2=10;
W3=20;
h_horizon1=H_horizon(image_filter,W1);
h_vertical1=H_vertical(image_filter,W1);
h_horizon2=H_horizon(image_filter,W2);
h_vertical2=H_vertical(image_filter,W2);
h_horizon3=H_horizon(image_filter,W3);
h_vertical3=H_vertical(image_filter,W3);

J1=Filter_HV(Image,W1,Lambda,h_horizon1,h_vertical1);
J2=Filter_HV(Image,W2,Lambda,h_horizon2,h_vertical2);
J3=Filter_HV(Image,W3,Lambda,h_horizon3,h_vertical3);

figure,imshowpair(J1,J2, 'montage'),title("W = 5                    W = 10");    
figure,imshow(J3),title("W = 20");
    
    
  



