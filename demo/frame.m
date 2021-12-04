function p=frame(file,k)
[y,fs]=audioread(file);
%[y,fs]=audioread('4bj1e.wav');
y=y(:,1);
n=length(y);
%k=20;
x=transpose(1:n).*(y);
%taking one frame
win = window(@hamming,2^(nextpow2(round(n*0.005))));
y1=y(k*round(n*0.005)+1:(k+1)*round(n*0.005));
x1=x(k*round(n*0.005)+1:(k+1)*round(n*0.005));
F=transpose(fftshift(fft(overlap(y1,win,2^(nextpow2(round(n*0.005)))),2^(nextpow2(round(n*0.005))))));
F1=transpose(fftshift(fft(overlap(x1,win,2^(nextpow2(round(n*0.005)))),2^(nextpow2(round(n*0.005))))));
X_r=real(F);
X_i=-1i*(F-X_r);
Y_r=real(F1);
Y_i=-1i*(F1-Y_r);
N=(X_r.*Y_r)+(X_i.*Y_i);
M=abs(F).^2;
G=N./M;
f=fs*(0:2^(nextpow2(round(n*0.005)))*(round(n/(n*0.005)))-1)/(2^(nextpow2(round(n*0.005)))*(round(n/(n*0.005))));
fk=f(k*round(n*0.005)+1:2^(nextpow2(round(n*0.005)))+k*round(n*0.005));
figure(1);
plot(fk,G);
title('Group Delay of a frame');
figure(2);
plot(fk,N);
title('Numerator Group Delay of a frame');
[pks,loc]=findpeaks(N);
[~,indices]=sort(pks,'descend');
locs=loc(indices);
p=zeros(1,15);
if(length(indices)>15)
    p(1,1:15)=fk(locs(1:15));
else
    p(1,1:length(locs))=fk(locs);
    p(1,length(locs)+1:15)=zeros(1,15-length(locs));
end
end