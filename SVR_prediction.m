function Fr = SVR_prediction(SV,alpha,b,Cos,Sin,R,Eo)
x=[Cos Sin R Eo];
[m,~]=size(SV);
aux=zeros(1,m);
for i=1:m
    aux(i)=exp(-1/length(x)*(norm(SV(i,:)-x)).^2);
end
Fr=b+sum(alpha.*aux');
end