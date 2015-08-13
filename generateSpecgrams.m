function [S,Stime,Sfreq, Serror] = generateSpecgrams(acquisition, params)
% Function that will accept 'acquisition' structure from gather windows of
% data and from it compute either a spectrogram per set of data in
% acquision or some combination of spectrograms.

%% Define Chronux params
% -------------------------------------------
movingwin = [100 10]/1000; %movingwin = [100 10]/1000;                
params.Fs = 1500;
params.fpass = [0 40]; % params.fpass = [0 400];
params.tapers = [3 5];
params.err = [2 0.05];

%% Analysis Input Parameters
d = params.days;      % for now we're passing in single day, and not list
e = params.epochs;
t = params.tetrodes;

%% Setup/Preallocate Ouputs

%% For-loooping over acquisitions
for trial = 1:size(acquisition.data{d,e,t},1)
    
    indices = find(acquisition.data{d,e,t}(trial,:) ~= 0);
    specgram_data = acquisition.data{d,e,t}(trial,:);
    [S, Stime, Sfreq, Serror] = mtspecgramc(specgram_data(indices(1):indices(end)), movingwin,params);
    
end


end 