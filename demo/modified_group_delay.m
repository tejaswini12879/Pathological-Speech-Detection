function G1=modified_group_delay(k)
[y,fs]=audioread('one.wav');
y=y(:,1);
n=length(y);
x=transpose(1:n).*(y);
%taking one frame
y1=y(k*58*22+1:(k+1)*58*22);
x1=x(k*58*22+1:(k+1)*58*22);
F=fftshift(fft(y1,2048));
F1=fftshift(fft(x1,2048));
X_r=real(F);
X_i=-1i*(F-X_r);
Y_r=real(F1);
Y_i=-1i*(F1-Y_r);
N=(X_r.*Y_r)+(X_i.*Y_i);
D=(abs(F)).^2;
C=log(abs(F)).^2;
G1=N./C;
f=fs*(0:2048*41-1)/(2048*41);
fk=f(k*58*22+1:(k+1)*58*22+2048-1276);
plot(fk,G1);
%[pks,loc]=findpeaks(G1);
%j=1;
%for i=1:length(pks)
%    if(pks(i)>(50))
%        location(j)=loc(i);
%        j=j+1;
%    end
%end
end