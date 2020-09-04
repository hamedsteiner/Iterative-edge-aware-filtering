function y = H_horizon(image_filter,W)

Size=size(image_filter);

Height=Size(1);
Width=Size(2);
y=zeros(Height,Width,2*W+1);
sigma=0.5;

pi_hat=zeros(Height,Width);
pi_horizon=zeros(Height,Width,2*W+1);

for j=1:Width-1
    for i=1:Height
        rgb1=zeros(3);
        rgb2=zeros(3);
        for c=1:3
            rgb1(c)=image_filter(i,j,c);
            rgb2(c)=image_filter(i,j+1,c);
        end
        
        pi_hat(i,j)=inv(1+ power(norm( ( rgb1 - rgb2 )/sigma),2) );
    end
end
pi_hat(i,Width)=0.001;

for i=1:Height
    for j=1:Width
        for n=max(1,j-2*W-1):min(Width,j+2*W+1)
            if(  j==n )
                pi_horizon(i,j,W+1)=1;      
            elseif(  abs(j-n) <= W ) %in a row
                temp=1;
                for k=j:n
                    temp=temp*pi_hat(i,k);
                end                    
                pi_horizon(i,j, W + (n-j) + 1 )=temp;
            end
        end
    end
end
for i=1:Height
    for j=1:Width
        for k=1:2*W+1
            y(i,j,k)=pi_horizon(i,j,k)/sum(pi_horizon(i,j,:));
        end
    end
end
