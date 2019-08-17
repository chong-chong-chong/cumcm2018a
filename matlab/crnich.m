function U=crnich (f,c1,c2,a,b,c,n,m)
    %
    h=a/(n-1);
    k=b/(m-1);
    r=c^2*k/h^2;
    s1=2+2/r;
    s2=2/r-2;
    U=zeros(m,n);
    % boundry conditions
    U=(1,1:m)=c1;
    U=(n,1:m)=c2;
    %
    U(2:n-1,1)=feval(f,h:h:(n-2)*h)';
    %
    Vd(1,1:n)=s1*ones(1,n);
    Vd(1)=1;
    Vd(n)=1;
    Va=-ones(1,n-1);
    Va(n-1)=0;
    Vc=-ones(1,n-1);
    Vc(1)=0;
    Vb(1)=c1;
    Vb(n)=c2;
    for j=2:m
        for i=2:n-1
            Vb(i)=U(i-1,j-1)+U(i+1,j-1)+s2*U(i,j-1);
        end
        X=trisys(Va,Vd,Vc,Vb);
        U(1:n,j)=X';
    end
U=U'