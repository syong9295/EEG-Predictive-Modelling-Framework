function[] = process_features()

% feature selection based on manual removal - skipped first

% concatenate all feature files (csv)
folder_content = dir("features/*.csv");
data_no = numel(folder_content);
concatenated_features = [];

for i = 1 : data_no
    % read the csv file
    temp_container = csvread(fullfile("features/",folder_content(i).name));
    
    % remove labels
    temp_container = temp_container(:, 1:end-1);
    
    % concatenation
    concatenated_features = [concatenated_features, temp_container];
    
    % append labels when we reach the last file
    if i == data_no
        labels = csvread(fullfile("features/",folder_content(i).name));
        labels = labels(:, end);
        concatenated_features = [concatenated_features, labels];
    end
    
end

% generate a folder to store concatenated feature file
if not(isfolder('concatenated_features\'))
    mkdir('concatenated_features\');
end

% generate a csv file based on concatenated features matrix
writematrix(concatenated_features, 'concatenated_features\concatenated_features.csv');

