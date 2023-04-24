clc
c=[-2 0 -1];
info=[-1 -1 1;-1 2 -4];
b=[-5;-8];
s=eye(size(info,1));
A=[info s b];

Noofvariables=3;
cost= [c zeros(1,size(s,2)+1)];
BV=Noofvariables+1:size(A,2)-1;

ZjCj=cost(BV)*A-cost;

Table=array2table([ZjCj; A]);
Table.Properties.VariableNames(1:size(Table,2))={'x1','x2','x3','s1','s2','Sol'}
run = true;
while run
    sol=A(:,end);
    if any (sol<0)
        fprintf('The current BFS if not feasible');
         [min_sol,Pivot_Row]=min(sol);
         Row=A(Pivot_Row,1:end-1);
         ZJ=ZjCj(:,1:end-1);
         for i=1:size(Row,2)
             if Row(i)<0
                 ratio(i)=abs(ZJ(i)./Row(i));
             else
                 ratio(i)=inf;
             end
         end
         [min_value,Pivot_Column]=min(ratio);
         fprintf('The entering variable is %d \n',Pivot_Column);
         BV(Pivot_Row)=Pivot_Column;
         disp('New Basic Variables = ');
         disp(BV);
         key=A(Pivot_Row,Pivot_Column);
         A(Pivot_Row,:)=A(Pivot_Row,:)/key;

         for i=1:size(A,1)
             if(i~=Pivot_Row)
                 A(i,:)=A(i,:)-A(i,Pivot_Column).*A(Pivot_Row,:);
             end
         end
         ZjCj=cost(BV)*A-cost;

        Table=array2table([ZjCj; A]);
        Table.Properties.VariableNames(1:size(Table,2))={'x1','x2','x3','s1','s2','Sol'}



    else
        run = false;
        fprintf('The current BFS is feasible and optimal');

    end

end 

