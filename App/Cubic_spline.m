function output=Cubic_spline(time1, time2, y1, y2)

% clc 
% close all 
% clear all 
% x=[-2 0 2 3 4 5];
% y=[4 0 -4 -30 -40 -50];
% time1=[1,2,3];time2=[7,9,10];
% y1=[223,355,644]; y2=[1204,1490,1684];

x=[time1,time2];
y=[y1,y2];
n=6;
A=zeros((n-1)*4);
B=zeros((n-1)*4,1);

B(1)=y(1);
for i=2:n-1
    temp=2*i-2;
    B(temp)=y(i);
    B(temp+1)=y(i);
end
B(n*2-2)=y(6);

%(n-1) splines for two consecutive data points = (n-1)*2 equations
for i=1:n-1
    temp=2*i-1;
    temp2=4*i-3;
    A(temp,temp2)=x(i)^3;A(temp,temp2+1)=x(i)^2;A(temp,temp2+2)=x(i);A(temp,temp2+3)=1;
    A(temp+1,temp2)=x(i+1)^3;A(temp+1,temp2+1)=x(i+1)^2;A(temp+1,temp2+2)=x(i+1);A(temp+1,temp2+3)=1;
end

%(n-2) derivative of interior data points
for i=2:n-1
   temp=i+9;temp2=(i-1)*4-3;
   A(temp,temp2)=3*x(i)^2;A(temp,temp2+1)=2*x(i);A(temp,temp2+2)=1;
   A(temp,temp2+4)=-3*x(i)^2;A(temp,temp2+5)=-2*x(i);A(temp,temp2+6)=-1;
end
 
%2nd derivative
for i=2:n-1
   temp=i+13;temp2=(i-1)*4-3;
   A(temp,temp2)=6*x(i);A(temp,temp2+1)=2;
   A(temp,temp2+4)=-6*x(i);A(temp,temp2+5)=-2;
end

%boundary conditions
A(end-1,1)=6*x(1);A(end-1,2)=2;
A(end,end-3)=6*x(end);A(end,end-2)=2;

Ans=linsolve(A,B);

%  for i = 1:n-1
%    fprintf('(%.4f)x^3+(%.4f)x^2+(%.4f)x+(%.4f),\t\t %d<=x<=%d \n',Ans(4*i-3),Ans(4*i-2),Ans(4*i-1),Ans(4*i),x(i),x(i+1));
%  end


X=[time1(end)+1:time2(1)-1];
Y=zeros(1,size(X,2));
for i=1:size(X,2)
    input=X(i);
    if input>=x(1)&&input<=x(2)
        out=Ans(1)*input^3+Ans(2)*input^2+Ans(3)*input+Ans(4);
    elseif input>x(2)&&input<=x(3)
        out=Ans(5)*input^3+Ans(6)*input^2+Ans(7)*input+Ans(8);
    elseif input>x(3)&&input<=x(4)
        out=Ans(9)*input^3+Ans(10)*input^2+Ans(11)*input+Ans(12);
    elseif input>x(4)&&input<=x(5)
        out=Ans(13)*input^3+Ans(14)*input^2+Ans(15)*input+Ans(16);
    else
        out=Ans(17)*input^3+Ans(18)*input^2+Ans(19)*input+Ans(20);
    end
    Y(i)=out;
end
    
output=Y;




end
