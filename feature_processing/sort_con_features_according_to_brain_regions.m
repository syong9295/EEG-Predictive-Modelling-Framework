function[] = sort_con_features_according_to_brain_regions()

% constants
CHANNEL_NO = 14;

% initializations
frontal = [];
parietal = [];
occipital = [];
temporal = [];

% get all information on feature files
% folder_content = dir("individual_features\*.csv");
folder_content = dir("feature_processing\individual_features\*.csv");

% remove hemispheric assymetry feature (because it used all brain parts)
folder_content(11) = [];
data_no = numel(folder_content);

% sort features according to brain regions
% for each feature file (i.e avg_pw_a, avg_pw_b, avg_pw_d ...)
for i = 1 : data_no
    % read the csv file
    temp_container = csvread(fullfile("feature_processing\individual_features\",folder_content(i).name));
    
    % for each channel in that particular feature file
    for j = 1 : CHANNEL_NO
        % if this channel belongs to frontal AF3,AF4,F3,F4,F7,F8 (1,2,3,4,11,14)
        if ismember(j, [1, 2, 3, 4, 11, 14])
            frontal = [frontal, temp_container(:, j)];
       
        % if this channel belongs to parietal - P7,P8 (6,9)
        elseif ismember(j, [6, 9])
            parietal = [parietal, temp_container(:, j)];
        
        % if this channel belongs to occipital - O1,O2 (7,8)
        elseif ismember(j, [7, 8])
            occipital = [occipital, temp_container(:, j)];
        
        % if this channel belongs to temporal - T7,T8 (5,10)
        elseif ismember(j, [5, 10])
            temporal = [temporal, temp_container(:, j)];
            
        % note that labels are ignored for NOW
        end
    end 
    
    % append labels at the end for each brain region matrix
    if i == data_no
%         labels = csvread(fullfile("features/",folder_content(i).name));
        labels = csvread(fullfile("feature_processing\individual_features\",folder_content(i).name));
        labels = labels(:, end);
        frontal = [frontal, labels];
        parietal = [parietal, labels];
        occipital = [occipital, labels];
        temporal = [temporal, labels];
    end
    
end

% write results to csv files
% generate a folder to store concatenated feature file
% if not(isfolder('features_by_brain_regions\'))
%     mkdir('features_by_brain_regions\');
% end

if not(isfolder('feature_processing\features_by_brain_regions\'))
    mkdir('feature_processing\features_by_brain_regions\');
end

writematrix(frontal, 'feature_processing\features_by_brain_regions\frontal.csv');
writematrix(parietal, 'feature_processing\features_by_brain_regions\parietal.csv');
writematrix(occipital, 'feature_processing\features_by_brain_regions\occipital.csv');
writematrix(temporal, 'feature_processing\features_by_brain_regions\temporal.csv');



