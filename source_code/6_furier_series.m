% furier series
t=0:0.01:2*pi*2;  %한주기 2사이클 정도를 0.01 간격으로 t축 넣음
y=sin(3*t)/3;
figure(1); plot(t,y);

y=sin(t)+sin(3*t)/3;
hold on;  plot(t,y)

%홀수 주파수 계속 추가
y=sin(t)+sin(3*t)/3+sin(5*t)/5;
hold on;  plot(t,y);

figure(1); clf; %clf: clear current figure, hold on 없애는 것
y=zeros(size(t));
for i=1:2:19 % 주파수를 계속 증가 시키면서 확인하는 부분
    y=y+sin(i*t)/i;
    plot(t,y);
    pause(3);
end
