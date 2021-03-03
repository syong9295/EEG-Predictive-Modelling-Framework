function[] = concatenate_features()

% a function that can concatenate all the feature files (in csv) in a chosen folder

% folder_content = dir("features_combination_subjects/*.csv");
folder_content = dir("features_combination_products/*.csv");
data_no = numel(folder_content);

% empty container
container = [];

for i = 1 : data_no
%    data = load(fullfile("features_combination_subjects/",folder_content(i).name));
   data = load(fullfile("features_combination_products/",folder_content(i).name));
   container = [container; data];
end

if not(isfolder('features_combination_results/'))
    mkdir('features_combination_results/');
end

% writematrix(container, 'features_combination_results/subjects.csv');
writematrix(container, 'features_combination_results/products.csv');
