function[] = sort_ind_features_according_to_subjects_and_products()

% this KNN classifier will compute an accuracy table (in .csv format) for
% subject category and product catagory corresponding to Avg EEG power bands, 
% Spectral energy, peak alpha and hemispheric assymetry features.

% constants
FEATURE_NO = 4;

% empty container for final results
final_result_sub = [];
final_result_prod = [];

% loading subject dataset
% fc_sub = dir("features_by_subjects/*.csv");
% sub_data_no = numel(fc_sub);

fc_sub = dir("feature_processing\concatenated_features_by_subjects\*.csv");
sub_data_no = numel(fc_sub);

% loading product dataset
% fc_prod = dir("features_by_product_no/*.csv");
% prod_data_no = numel(fc_prod);

fc_prod = dir("feature_processing\concatenated_features_by_products\*.csv");
prod_data_no = numel(fc_prod);

% for each subject
for i = 1 : sub_data_no
    
%     data = load(fullfile("features_by_subjects/",fc_sub(i).name));
    data = load(fullfile("feature_processing\concatenated_features_by_subjects\",fc_sub(i).name));
    % s is a struct container for holding feature arrays.
    s(1).data = data(:, 1:70); % average EEG power bands
    s(2).data = data(:, 71:140); % spectral energy
    s(3).data = data(:, 141:154); % peak alpha
    s(4).data = data(:, 155); % hemispheric asymmetry
    labels = data(:, 156); % labels (0 or 1)
    rng(10); % 10-folds for cross validation and all features use the same seed.
    
    % empty container for row results
    row_results = zeros(1, 4);
    
    for j = 1 : FEATURE_NO
        Mdl = fitcknn(s(j).data, labels, 'NumNeighbors', 4); % construct knn classifier
        CVMdl = crossval(Mdl); % construct cross validation classifier from model
        % kloss = cross validation loss (avg loss of each cross-validation model when 
        % predicting on data that is not used for training)
        kloss = kfoldLoss(CVMdl); 
        row_results(j) = (1 - kloss)*100; % convert to percentage
    end
    
    sub_no = strcat("s",int2str(i));
    % concatenate results and adding subject no to the start of each row
    final_result_sub = [final_result_sub; sub_no, row_results];
    
end

% for each product
for i = 1 : prod_data_no
    
%     data = load(fullfile("features_by_product_no/",fc_prod(i).name));
    data = load(fullfile("feature_processing\concatenated_features_by_products\",fc_prod(i).name));
    % s is a struct container for holding feature arrays.
    s(1).data = data(:, 1:70); % average EEG power bands
    s(2).data = data(:, 71:140); % spectral energy
    s(3).data = data(:, 141:154); % peak alpha
    s(4).data = data(:, 155); % hemispheric asymmetry
    labels = data(:, 156); % labels (0 or 1)
    rng(10); % 10-folds for cross validation and all features use the same seed.
    
    % empty container for row results
    row_results = zeros(1, 4);
    
    for j = 1 : FEATURE_NO
        Mdl = fitcknn(s(j).data, labels, 'NumNeighbors', 4); % construct knn classifier
        CVMdl = crossval(Mdl); % construct cross validation classifier from model
        % kloss = cross validation loss (avg loss of each cross-validation model when 
        % predicting on data that is not used for training)
        kloss = kfoldLoss(CVMdl); 
        row_results(j) = (1 - kloss)*100; % convert to percentage
    end
    
    prod_no = strcat("p",int2str(i));
    % concatenate results and adding subject no to the start of each row
    final_result_prod = [final_result_prod; prod_no, row_results];
    
end

% adding headers to result matrix / table
final_result_sub = ["", "avg power band", "spectral energy", "peak alpha", "hemispheric asymmetry"; final_result_sub];
final_result_prod = ["", "avg power band", "spectral energy", "peak alpha", "hemispheric asymmetry"; final_result_prod];

% write csv files
% writematrix(final_result_sub, 'accuracy_table_ind_features_and_subjects/accuracy_table_subjects.csv');
% writematrix(final_result_prod, 'accuracy_table_ind_features_and_products/accuracy_table_products.csv');

if not(isfolder('feature_processing\individual_features_by_subjects\'))
    mkdir('feature_processing\individual_features_by_subjects\');
end

if not(isfolder('feature_processing\individual_features_by_products\'))
    mkdir('feature_processing\individual_features_by_products\');
end

writematrix(final_result_sub, 'feature_processing\individual_features_by_subjects\accuracy_table_subjects.csv');
writematrix(final_result_prod, 'feature_processing\individual_features_by_products\accuracy_table_products.csv');
