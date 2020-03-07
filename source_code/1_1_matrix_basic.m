function [In]=myExercise(Ic) %return 값 In
% variables
a=5 %single(5)
b=5.5
c='a'
d='abc'

d(3)

A=[1 2 3;
   4 5 6]
A(2,2)
A(:,2) 

B=A(:)
size(B)

C=[7 8 9;
   10 11 12]
D=A.*C %A./C
D'

X=0:10
x=0:0.1:10

y=x.^2
plot(x,y);

F=ones(10,10,10);
F(5,5,10)

a='abc'
b='def'
c=[a b]

x=linspace(0,4*pi,100);
y=sin(x);
plot(x,y); 
drawnow
title('My sin graph');
xlabel('x'); ylabel('sin(x)');

a=3;
if(a<3)
    disp('hi');
else
    disp('dip');
end


for i=1:100
    y=sin(i)
    
end

Ic=imread('head.png');
Ig=rgb2gray(Ic);
figure(2); imshow(Ig);
[H W]=size(Ig); %high width
In=zeros(H,W);
tic
for i=1:H
    for j=1:W
        In(i,j)=uint8(Ig(i,j)*1.5); %1-256 ->0-255
    end
end
toc %돌아간 시간 측정

tic
%In=uint8(Ig(i,j)*1.5); %1-256 ->0-255 %행렬
In=uint8(Ig*1.5);
toc %돌아간 시간 측정
figure(3); imshow(In);

