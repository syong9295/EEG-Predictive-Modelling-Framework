function [feeg]=FilterHighEEG(a,fs,fc)

       % By Hafeez Ullah Amin, March 2018
       % remove mean for stability of filter
       % Input eeg time series (a) for a given channel
       % fs is data sampling rate in Hz. fc is chose cutoff
       
         a=a-mean(a);
         
        %create a Chebyshev filter - highpass 
        %fc=1 % 1 Hz for artefact removal
        n = 2; 
        Wn = 2*fc/fs;
        [b,ar] = cheby1(n,2,Wn,'high');

        %apply the filter
         feeg = filtfilt(b,ar,a);
        
        