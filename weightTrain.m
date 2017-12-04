clc;
clear;
% data loading
M = csvread('mnist_train.csv');
T = csvread('mnist_test.csv');




% T digits limitation
digit = 1;
counter = 0; % count maximum 1's of every row 
for i = 1:10000
    count_per_cycle = 0;
    for j = 1:784
        if(T(i,j+1) >= 128)
            T(i,j+1) = 1;
            count_per_cycle = count_per_cycle + 1;
        else
            T(i,j+1) = 0;
        end
    end
    if(count_per_cycle > counter)
        counter = count_per_cycle;
    end
end
TrainImage = T(:,2:785);



DVec = zeros(10,60000);
IVec = zeros(785,60000);

% Training
k=0;
for i=1:60000
   DVec(:,i) = num2TempratureVec(M(i,1));
   IVec(:,i) = [ M(i,2:end)'; 1]; 
end 
IVecInv = pinv(IVec);
WVec = DVec*IVecInv;


Weight = WVec(:,1:784);
bias = WVec(:,785);

newVec = [Weight,bias./255];
%maximum = max(max(newVec));

%WVec = round(WVec / max(max(WVec)) * (2^weight_precision-1));
old_max = max(max(newVec));
old_min = min(min(newVec));
newVec = newVec - (min(min(newVec)));
weight_precision = 12;
newVec = round(newVec / max(max(newVec)) * (2^weight_precision-1));
new_max = max(max(newVec));
new_min = min(min(newVec));

%WVec = vpa(WVec,5);
%}

maximum_image = 0;

% Testing
k = 0;j=0;
 for i=1:10000
   TestImage = [T(i,2:end)';1];% provision for the BIAS in testing as well
   %TestResult = Hardware(newVec,TestImage);
   Te = newVec*TestImage;
   local_maximum = max(Te);
   if(local_maximum > maximum_image)
       maximum_image = local_maximum;
   end
   Te = Te == max(Te);
   TestResult = find(Te) - 1;
   ActualNumber = T(i,1);
    if  TestResult == ActualNumber
       k = k+1;
    else
      j = j+1;
    end
 end 
% fprintf('Success Rate %d %% \n',100 - round(100*j/(j+k)));
fprintf('Success Rate %d \n', 100 * k/(j+k));

% newVec_bit = de2bi(newVec);

fid = fopen('weight.txt','wt');
for ii = 1:size(newVec,1)
    fprintf(fid,'%g\n',newVec(ii,:));
    %fprintf(fid,'\n');
end
fclose(fid);

