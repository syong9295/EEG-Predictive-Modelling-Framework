% This file serves as the starting script to run. 
% Done by Loh Sheng Yong, for FYP in University of Nottingham Malaysia.

% define constants
FS = 128; % 128Hz sampling rate
CHANNEL_NO = 14; % total number of channels

% initializations
folder_content = dir("datasets\original_data\*.txt");
data_no = numel(folder_content);

% generate a folder to contain filtered EEG data
if not(isfolder('datasets\filtered_data'))
    mkdir('datasets\filtered_data');
end

% preprocess (noise filtering) all 1025 EEG data
for i = 1 : data_no 
    data = load(fullfile("datasets\original_data\",folder_content(i).name));
    data_filtered = preprocess(data, FS);
    writematrix(data_filtered, "datasets\filtered_data\" + folder_content(i).name, 'Delimiter', 'space');
end

% drop artifact-data and compute their statistics
process_artifacts();

% feature extraction
extract_features(FS, CHANNEL_NO);

% feature concatenation
concatenate_features();

% functions below are performed to generate different feature files that
% are seperated according to different conditions (brain regions, subjects etc.)

% separate data according to brain regions
sort_con_features_according_to_brain_regions();

% separate data according to subjects and products
sort_con_features_according_to_subjects_and_products();

% separate data according to ind. sub. and prod. using only KNN
sort_ind_features_according_to_subjects_and_products()

