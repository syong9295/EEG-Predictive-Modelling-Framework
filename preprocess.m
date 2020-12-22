function signalFilt=preprocess(data,fs) 

% Copyright@ CISIR
%Inputs:
%data: eeg data matrix............fs: sampling frequency
%output: 
%signalFilt: channels*samples matrix (filtered signal) 

%parameters
fs=fs;
HighPassFc=0.5;
LowPassFc=45;
[r c]=size(data); % find number of channels in the input data

%Filters
signalFilt=[];
for i=1:c %apply for all channels
    % Chebyshev filters
    feeg2=FilterHighEEG(data(:,i),fs,HighPassFc);
    feeg=FilterLowEEG(feeg2,fs,LowPassFc);
    
    % Butterworth 4th order filters
%     feeg2=highPassFilter(data(:,i),fs,HighPassFc);
%     feeg=lowPassFilter(feeg2,fs,LowPassFc);
    
    signalFilt=[signalFilt feeg];
end 


% window=fs*2;
% nover_lap=fs;
% nfft=2^nextpow2(window);
% [Pw,Fw]=pwelch(feeg,window,(100*nover_lap/window),nfft,fs);
% plot(Pw);





