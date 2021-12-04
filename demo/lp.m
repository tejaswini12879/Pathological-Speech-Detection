function formant=lp(k)
[y,fs]=audioread('one.wav');
y=y(:,1);
y=y./(1.01*abs(max(y)));
n=length(y);
y1=y(k*58*5+1:(k+1)*58*5);
N=length(y1);
w=hamming(N);
y1 = y1.*w;
P=10; 
ycorr=xcorr(y1);
ycorr=ycorr./(1.01*abs(max(ycorr)));
A=ycorr(1:P);
r=ycorr(2:P+1);
A=toeplitz(A);
L=-inv(A).*transpose(r);
L=transpose(L);
LPcoeff(1,1:length([1,L(1),L(2),L(3),L(4),L(5),L(6),L(7),L(8),L(9),L(10)]))=[1,L(1),L(2),L(3),L(4),L(5),L(6),L(7),L(8),L(9),L(10)];
y2=abs(fft(LPcoeff,2^9));
y2=y2.^(-1);
y2=20*log10(y2);
%y3=y2(1:2^8);
k=1;
for i=2:length(y2)-1
    if((y2(i-1)<y2(i))&&(y2(i+1)<y2(i)))
        formant(k)=i;
        k=k+1;
    else
        continue
    end
end
