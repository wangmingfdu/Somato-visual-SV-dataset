%%% Convert dense BSV model into sparse BSV model

%Load dense BSV model (dense_net)
mynet=dense_net;

%Set hyperparameter
delta=1.2;

W1=mynet.IW{1};
W2=mynet.LW{2,1};
W3=mynet.LW{3,2};
W4=mynet.LW{4,3};

for i=1:size(W1,1)
    for j=1:size(W1,2)
		wtemp = W1(i,j);
        W1(i,j) = 0;
        if cond(W1*W1','fro')/cond(mynet.IW{1}*mynet.IW{1}','fro') > delta
            W1(i,j)=wtemp;
        end
    end
end

for i=1:size(W2,1)
    for j=1:size(W2,2)
		wtemp = W2(i,j);
        W2(i,j) = 0;
        if cond(W2*W2','fro')/cond(mynet.LW{2,1}*mynet.LW{2,1}','fro')> delta
            W2(i,j)=wtemp;
        end
    end
end

for i=1:size(W3,1)
    for j=1:size(W3,2)
		wtemp = W3(i,j);
        W3(i,j) = 0;
        if cond(W3*W3','fro')/cond(mynet.LW{3,2}*mynet.LW{3,2}','fro') > delta
            W3(i,j)=wtemp;
        end
    end
end

for i=1:size(W4,1)
    for j=1:size(W4,2)
		wtemp = W4(i,j);
        W4(i,j) = 0;
        if cond(W4*W4','fro')/cond(mynet.LW{4,3}*mynet.LW{4,3}','fro') > delta
            W4(i,j)=wtemp;
        end
    end
end


for k=0:0.02:0.2
    for i=1:size(W1,1)
        for j=1:size(W1,2)
            if abs(W1(i,j)) < k
                W1(i,j)=0;
            end
        end
    end
    if cond(W1*W1','fro')/cond(mynet.IW{1}*mynet.IW{1}','fro')>1.2
        break
    end
end

for k=0:0.02:0.2
    for i=1:size(W2,1)
        for j=1:size(W2,2)
            if abs(W2(i,j)) < k
                W2(i,j)=0;
            end
        end
    end
    if cond(W2*W2','fro')/cond(mynet.LW{2,1}*mynet.LW{2,1}','fro')>1.2
        break
    end
end

%Sparse BSV model (Sparse)
mynet.IW{1}=W1;
mynet.LW{2,1}=W2;
mynet.LW{3,2}=W3;
mynet.LW{4,3}=W4;


