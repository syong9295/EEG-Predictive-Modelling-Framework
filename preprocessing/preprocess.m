function signalFilt=preprocess(data,fs) 

%parameters
fs=fs;
HighPassFc=0.5;
LowPassFc=45;
[r c]=size(data); % find number of channels in the input data

%Filters
signalFilt=[];
for i=1:c %apply for all channels
    % Chebyshev filters
    feeg2=filter_high_EEG(data(:,i),fs,HighPassFc);
    feeg=filter_low_EEG(feeg2,fs,LowPassFc);
    signalFilt=[signalFilt feeg];
end 





