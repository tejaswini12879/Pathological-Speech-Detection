function p=final(file)
%file='4BE1A.wav';
[y,fs]=audioread(file);
n=length(y);
x=transpose(0:n-1).*y;
win = window(@hamming,2048);
f = transpose(fs/1*linspace(0,1,length(y)+40*(2048-round(n*0.025))));
i=1;
p=zeros(40,15);
for k=0:39
    y1=y(round(k*n*0.025)+1:round((k+1)*(n*0.025)));
    x1=x(round(k*(n*0.025))+1:round((k+1)*(n*0.025)));
    F=transpose(fftshift(fft(overlap(y1,win),2048)));
    %F=fftshift(fft(y1,512)).*win;
    F1=transpose(fftshift(fft(overlap(x1,win),2048)));
    %F1=fftshift(fft(x1,512)).*win;
    X_r=real(F);
    X_i=-1i*(F-X_r);
    Y_r=real(F1);
    Y_i=-1i*(F1-Y_r);
    N=(X_r.*Y_r)+(X_i.*Y_i);
    fk=f(round(k*(n*0.025))+1:round((k+1)*(n*0.025))+2048-round(n*0.025));
    [pks,loc]=findpeaks(N);
    [~,indices]=sort(pks,'descend');
    locs=loc(indices);
    if(length(indices)>15)
        p(i,1:15)=fk(locs(1:15));
    else
        p(i,1:length(locs))=fk(locs);
        p(i,length(locs)+1:15)=zeros(1,15-length(locs));
    end
    i=i+1;
end
end

