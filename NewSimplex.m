clc
c=[-1 3 -2];
info=[3 -1 2;-2 4 0;-4 3 8];
b=[7;12;10];
s=eye(size(info,1));
A=[info s b];

Noofvariables=3;
cost= [c zeros(1,size(s,2)+1)];
BV=Noofvariables+1:size(A,2)-1;

ZjCj=cost(BV)*A-cost;

Table=array2table([ZjCj; A]);
Table.Properties.VariableNames(1:size(Table,2))={'x1','x2','x3','s1','s2','s3','Sol'}

RUN=true;
while RUN
   if any(ZjCj<0)
    [min_value, Pivot_Column]=min(ZjCj);
    sol=A(:,end);
    column=A(:,Pivot_Column);
    if all (column<=0)
        error('Lpp is unbounded. All entries are negative in %d', Pivot_Column);
    else
    for i=1:size(column,1)
        if column(i)>0
            ratio(i)=sol(i)./column(i)
    else
        ratio(i)=inf;
        end
    end
    
    [Min_Ratio,Pivot_Row]=min(ratio);
    fprintf('Minimum ratio is %d \n',Min_Ratio);
    fprintf('Leaving variable is %d \n', BV(Pivot_Row));
    end
    BV(Pivot_Row)=Pivot_Column;
    disp('New Basic Variables = ');
    disp(BV);
    Key=A(Pivot_Row,Pivot_Column);
    A(Pivot_Row,:)=A(Pivot_Row,:)./Key;
    for i=1:size(A,1)
        if i~=Pivot_Row
            A(i,:)=A(i,:)-A(i,Pivot_Column).*A(Pivot_Row,:);
        end
        ZjCj=ZjCj-ZjCj(Pivot_Column).*A(Pivot_Row,:);
       
    end

        Table=array2table([ZjCj; A]);
Table.Properties.VariableNames(1:size(Table,2))={'x1','x2','x3','s1','s2','s3','Sol'}
   


   else
       RUN=false
    disp('Optimal Solution Reached')
   end
end