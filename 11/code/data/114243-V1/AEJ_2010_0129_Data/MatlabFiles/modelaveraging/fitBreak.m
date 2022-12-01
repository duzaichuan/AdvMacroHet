% fit.m

% this file takes univariate regression and delivers fit.

function z = fitBreak(Y,X,periods,shockpos,levelindex);

startbreak=1979+9/12;                % date at which we start cutting sample
endbreak=1984+0/12;                  % date at which sample starts up again
zeroshockend=1982+8/12;              % last date of zero monetary shocks (1982+8/12)

Xtemp=[X(1:(startbreak-1/12-1969-11/12)*12,:) ; X((endbreak-1969-11/12)*12:length(X),:)];
Ytemp=[Y(1:(startbreak-1/12-1969-11/12)*12,:) ; Y((endbreak-1969-11/12)*12:length(X),:)];

[T,K]=size(X);
beta=inv(Xtemp'*Xtemp)*(Xtemp'*Ytemp);
%res=Y-X*beta;

Xa=X(1,:);
Y1=Xa*beta;

for j=2:T
    Xa(j,1)=1;
    Xa(j,2)=Y1(j-1,1);
    for i=3:length(beta)
        Xa(j,i)=Xa(j-1,i-1);
    end
    Xa(j,shockpos)=X(j,shockpos);
    Y1(j,1)=Xa(j,:)*beta;
end

if levelindex==0
    z(1)=Y(1);
    for j=2:length(Y1)
        z(j)=z(j-1)+Y1(j);
    end
else
    z=Y1;
end

return

