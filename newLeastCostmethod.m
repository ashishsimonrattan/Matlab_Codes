%Also called Matrix Minima
clc
cost=[11 20 7 8;21 16 10 12;8 12 18 9];
A=[50 40 70];
B=[30 25 35 40];
if sum(A)==sum(B)
    fprintf('The given transportation problem is balanced \n');
else
    fprintf('The given transportation problem is unbalanced \n');
    if sum(A)<sum(B)
        cost(end+1,:)=zeros(1,size(B,2));
        A(end+1)=sum(B)-sum(A);
    elseif sum(A)>sum(B)

        cost(:,end+1)=zeros(1,size(A,2));
        B(end+1)=sum(A)-sum(B);
    end
    end
    InitialCost=cost;
    x=zeros(size(cost));
    [m,n]=size(cost);
    BFS=m+n-1;
    for i=1:size(Cost,1)
        for j=1:size(Cost,2)
            hh=min(cost(:));
            [rowindex,columnindex]=find(hh==cost);
            x11=min(A(rowindex),B(columnindex));
            [val,ind]=max(x11);
            ii=rowindex(ind);
            jj=columnindex(ind);
            y11=min(A(ii),B(jj));
            x(ii,jj)=y11;
            A(ii)=A(ii)-y11;
            B(jj)=B(jj)-y11;
            cost(ii,jj)=inf;
        end
    end
fprintf('Initial Bfs= \n');
IB=array2table(x);
disp(IB);
TotalBFS=length(nonzeros(x));
if TotalBFS==BFS
    fprintf('Initial BFS is non-degenerate \n');
else
    fprintf('Initial BFS is degenerate \n');
end

InitialCost=sum(sum(InitialCost.*x));
fprintf('Initial BFS cost = %d\n', InitialCost);



    