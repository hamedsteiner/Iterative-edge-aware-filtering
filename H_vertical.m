function y = H_vertical(image_filter,W)

Size=size(image_filter);

Height=Size(1);
Width=Size(2);
y=zeros(Height,Width,2*W+1);
sigma=0.5;

pi_hat=zeros(Height,Width);
pi_vertical=zeros(Height,Width,2*W+1);


for i=1:Height-1
    for j=1:Width
        rgb1=zeros(3);
        rgb2=zeros(3);
        for c=1:3
            rgb1(c)=image_filter(i,j,c);
            rgb2(c)=image_filter(i+1,j,c);
        end
        
        pi_hat(i,j)=inv(1+ power(norm( ( rgb1 - rgb2 )/sigma),2) );
    end
end

pi_hat(Height,j)=0.001;

for j=1:Width
    for i=1:Height
        for m=max(1,i-2*W-1):min(Height,i+2*W+1)
            if i==m
                pi_vertical(i,j,W+1)=1;      
            elseif(  abs(i-m) <= W ) %in a row
                temp=1;
                for k=i:m
                    temp=temp*pi_hat(k,j);
                end                    
                pi_vertical(i,j, W + (m-i) + 1 )=temp;
            end
        end
    end
end
for i=1:Height
    for j=1:Width
        for k=1:2*W+1
        y(i,j,k)=pi_vertical(i,j,k)/sum(pi_vertical(i,j,:));
        end
    end
end