function y=overlap(Xn,Hn,L)
NXn=length(Xn);
M=length(Hn);
M1=M-1;
N=L+M1;
X=zeros(1,L);
X(1:length(Xn))=Xn;
H=zeros(1,L);
H(1:length(Hn))=Hn;
K=floor(NXn/L);
y=zeros(K+1,N);
z=zeros(1,M1);
for k=0:K
Xnp=X(L*k+1:L*k+L);
Xnk=[Xnp z];
y(k+1,:)=mycirconv(Xnk,H); %Call the mycirconv function.
end
p=L+M1;
for i=1:K
y(i+1,1:M-1)=y(i,p-M1+1:p)+y(i+1,1:M-1);
end
z1=y(:,1:L)';
y=(z1(:))';
end