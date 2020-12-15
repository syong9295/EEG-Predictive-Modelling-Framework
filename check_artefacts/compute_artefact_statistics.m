% this script invokes all related function to compute all the artefact
% statistics as txt files in check_artefacts\artefact-statistics

% mark all EEG files containing artefacts
artefacts_marker();

% make a copy of filtered EEG files and delete further artefacts contained
% in the EEG files
remove_files();

% below functions will compute relevant statistics stored in
% artefact-statistics as txt files

% compute the class distribution of remaining EEG files
class_distribution();

% compute how many remaining files are left for each product
remaining_file_per_product();

% compute how many remaining files are left for each subject
remaining_file_per_subject();