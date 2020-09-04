function y = Filter_HV(Image,W,Lambda,h_horizon,h_vertical)

J=Image;
J_next=Image;
Size=size(Image);
Height=Size(1);
Width=Size(2);

for iter=1:5
    % Horizon
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
end 
y=J;