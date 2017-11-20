clc;
clear;
% data loading
M = csvread('mnist_train.csv');
T = csvread('mnist_test.csv');

%{
% T digits limitation
digit = 1;
for i = 1:10000
    for j = 1:784
        if(T(i,j+1) > 0)
            T(i,j+1) = 1;
            break;
        end
        T(i,j+1) = 0; 
    end
end
%}


train_input = M(1:60000,2:785);
train_output = M(1:60000,1);

test_input = T(1:10000,2:785);
test_output = T(1:10000,1);

train_output(train_output == 0) = 10; % use '10' to present '0'
train_output = dummyvar(train_output); 

%{
load 10kTrain.mat; %load 10,000 training samles
fea = fea/255;     %10,100*784 sparse matrix normalize nu dividing with 255

for i = 1:10       %creating a 10*784 weight matrix initialize with random value
    for j = 1:784
        W(i,j) = randn;
    end
    W(i,j) = randn;
end
%loop runs for 10,000 times to tarin

for n = 1:10000
    trn = fea(n,:); %extracting one sample at a time from sparse matrix
    y = W * trn;    %multiply weight with one sample on each iteration b = 0
    [maxval, ind] = max(y(:)) %find the max value in output vector y correspond
                          %to each digit 0 to 9.
    r = gnd(n,:); %get true value from true value vector (10000x1)
    e = r - indl; %calculate the error

    if abs(e) ~= 0 %update weights
        W(ind,:) = W(ind,:) - trn; %decrease weights of max value found in output y
        W(r+1,:) = W(r+1,:) + trn; %increase weights of true value
    else
    end
end
%}

%W1 = zeros(10, 28*28);                  % pre-allocation
%W1(:, x1_step1.keep) = IW1_1;           % reconstruct the full matrix
%WVec = [W1,b1];


%WVec= importdata('weight.mat');


%weight_precision = 12;
%WVec = round(WVec / max(max(WVec)) * (2^weight_precision-1));


%{
% Testing
k = 0;j=0;
 for i=1:10000
   TestImage = [T(i,2:end)';1];% provision for the BIAS in testing as well
   TestResult = Hardware(WVec,TestImage);
   ActualNumber = T(i,1);
    if  TestResult == ActualNumber
       k = k+1;
    else
      j = j+1;
    end
 end 
% fprintf('Success Rate %d %% \n',100 - round(100*j/(j+k)));
fprintf('Success Rate %d \n', 100 * k/(j+k));

%}
