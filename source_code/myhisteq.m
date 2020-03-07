function [histresult] = myhisteq(Img)

[ M, N ] = size(Img);
L=256; % 8bit
temp=Img; % Img 대신 사용할 Img형태의 temp선언, 
            % 나중에 built-in hist사용할 때 Img data가 겹쳐서 안나오게 방지

hst = zeros(L,1); % 초기화
for i=1:M % Input image의 최대밝기 조사
    for j=1:N
        hst(temp(i,j)+1) = hst(temp(i,j)+1) + 1; % 명암값을 히스토그램에 누적
    end    % (0~255까지의 크기의 histogram 칸에 밝기에 따른 개수 넣기)
end
 
accumul = 0;
n = zeros(length(hst),1); % 밝기에 따른 개수
for i=1:length(hst)
    accumul = accumul + hst(i); % 누적, 시그마 ni계산
    n(i) = accumul;
end
 
Nnm = zeros(length(n),1); % 초기화
MN = M*N;
for i=1:length(n) % calculate histogram 
    Sk = n(i) * (L-1) / MN; % ni/MN = Pr
    Nnm(i) = round(Sk); % Nearest neighbor matching
end
 
histresult = Img; % 형태 할당
for i=1:M
    for j=1:N
        histresult(i,j) = Nnm(temp(i,j)+1);
    end
end
 
histresult = uint8(histresult);
end