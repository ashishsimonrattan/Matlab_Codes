clc
variables={'x1','x2','s2','s3','A1','A2','Sol'};
M=1000;
cost=[-2 -1 0 0 -M -M 0];
A=[3 1 0 0 1 0 3; 4 3 -1 0 0 1 6; 1 2 0 1 0 0 3];

s=eye(size(A,1));

BV=[5 6 4];

 
ZjCj=cost(BV)*A-cost;
Table=array2table([ZjCj; A]);
Table.Properties.VariableNames(1:size(Table,2))=variables

ZC =ZjCj(:,1:end-1);
Run=true;
while Run
if any (ZC<0)
    fprintf('The current BFS is not Optimal \n');
    [Min_Value,Pivot_Column]=min(ZC);
    sol=(A(:,end));
    Column=A(:,Pivot_Column);
    if all (Column)<=0
        fprintf('The solution is unbounded');
    else
        
        for i=1:size(Column,1)
        if Column(i)>0
            ratio(i)=sol(i)./Column(i);
        else
            ratio(i)=inf;
        end
        end
    end
    [Leaving_variable, Pivot_Row]=min(ratio);
    BV(Pivot_Row)=Pivot_Column;
    key=A(Pivot_Row, Pivot_Column);
    A(Pivot_Row,:)=A(Pivot_Row,:)./key;
    for i=1:size(A,1)
        if i~=Pivot_Row
            A(i,:)=A(i,:)-A(i,Pivot_Column)*A(Pivot_Row,:)
       
        end
    end
    ZjCj=cost(BV)*A-cost;
    ZC=ZjCj(:,1:end-1);
    Table=array2table([ZjCj; A]);
    Table.Properties.VariableNames(1:size(Table,2))=variables
    

else
    Run=false;
    fprintf('The current BFS is Optimal \n ');
end
end

