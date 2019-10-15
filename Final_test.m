clear;
clc;

%load the strain data
strainData1=csvread('strain_data_train.csv');

%load the imagedata
allImages = imageDatastore('HandPostures3', 'IncludeSubfolders', true,...
    'LabelSource', 'foldernames');
[trainingImages, testImages] = splitEachLabel(allImages, 0.8);

%resize images
trainingImages.ReadFcn = @readFunctionTrain;
testImages.ReadFcn = @readFunctionTrain;

%load pretrained cnn
load feature_extract_9183.mat;

featureLayer='fc_1';
Ximtrain=activations(feNet,trainingImages,featureLayer);
Ximtest=activations(feNet,testImages,featureLayer);

%strain data
Xsttrain=[];
Xsttest=[];
ytrain=[];
ytest=[];
for i=1:10
    for j=300*(i-1)+1:300*(i-1)+240
        Xsttrain=[Xsttrain;strainData1(j,1:5)];
        ytrain=[ytrain;strainData1(j,6)];
    end
    for j=300*(i-1)+241 :300*(i-1)+300
        Xsttest=[Xsttest;strainData1(j,1:5)];
        ytest=[ytest;strainData1(j,6)];
    end 
end

%labels
Ytrain=zeros(2400,10);
Ytest=zeros(600,10);
for i=1:2400
    Ytrain(i,ytrain(i))=1;
end
for i=1:600
    Ytest(i,ytest(i))=1;
end

%Load MLP models, 3 hidden layers, nodes number [25 15 10]
 load net1c.mat 
 load net2c.mat 
 load sparsenet2.mat

yp1=net1(Ximtest');
Yp1=zeros(size(yp1,2),1);
for i=1:size(yp1,2)
    tmp=yp1(:,i);
    Yp1(i)=find(tmp==max(tmp));
end
r1=sum(Yp1==ytest)/numel(ytest);


yp2=net2(Xsttest');
Yp2=zeros(size(yp2,2),1);
for i=1:size(yp2,2)
    tmp=yp2(:,i);
    Yp2(i)=find(tmp==max(tmp));
end
r2=sum(Yp2==ytest)/numel(ytest);
% 
%Recognition rate of images + strain
Xtrain=[Ximtrain Xsttrain];
Xtest=[Ximtest Xsttest];
[mynet,tr] = train(mynet,Xtrain',Ytrain');

yp3=mynet(Xtest');
Yp3=zeros(size(yp3,2),1);
for i=1:size(yp3,2)
    tmp=yp3(:,i);
    Yp3(i)=find(tmp==max(tmp));
end
r3=sum(Yp3==ytest)/numel(ytest);
% 

%{
%%y=0.5image+0.5strain
yp4=(yp1+yp2)./2;
Yp4=zeros(size(yp4,2),1);
for i=1:size(yp4,2)
    tmp=yp4(:,i);
    Yp4(i)=find(tmp==max(tmp));
end
r4=sum(Yp4==ytest)/numel(ytest);

%%attention model y=w1*image+w2*strain
t1=net1(Ximtrain');
t2=net2(Xsttrain');
for k=1:10
    for i=1:size(ytrain,1)
         a(:,i)=[t1(k,i);t2(k,i)];
    end
    b=Ytrain(:,k);
    w(:,k)=lsqlin(a',b,[1 1],1);
end
yp5=zeros(10,size(ytest,1));
for i=1:size(ytest,1)
    yp5(:,i)=w(1,:)'.*yp1(:,i)+w(2,:)'.*yp2(:,i);
end
Yp5=zeros(size(yp5,2),1);
for i=1:size(yp5,2)
    tmp=yp5(:,i);
    Yp5(i)=find(tmp==max(tmp));
end
r5=sum(Yp5==ytest)/numel(ytest);

%}