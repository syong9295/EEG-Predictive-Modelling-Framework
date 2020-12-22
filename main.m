% first script to run for this FYP
% (current) this script takes raw EEG files and outputs filtered EEG files  

% constants
FS = 128;
CHANNEL_NO = 14;

% initializations
folder_content = dir("ori_data/*.txt");
data_no = numel(folder_content);

% generate a folder to contain filtered EEG txt files
if not(isfolder('filtered_data'))
    mkdir('filtered_data');
end

% preprocess all 1025 EEG data files
for i = 1 : data_no 
    data = load(fullfile("ori_data/",folder_content(i).name));
    data_filtered = preprocess(data, FS);
    writematrix(data_filtered, "filtered_data/" + folder_content(i).name, 'Delimiter', 'space');
   
end
    
% remove files containing artefacts and compute statistics
compute_artefact_statistics();
    
% feature extraction
extract_features(FS, CHANNEL_NO);











