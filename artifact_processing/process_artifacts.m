function[] = process_artifacts()
% this script invokes all related functions to compute all the artefact
% statistics as txt files in check_artefacts\artefact-statistics

% mark all EEG files containing artefacts
mark_artifacts();

% make a copy of filtered EEG data and delete further artefacts contained
% in the EEG files
remove_artifacts();

% functions below will compute relevant statistics stored in
% artefact-statistics as txt files

% compute the class distribution of remaining EEG files
compute_class_distribution();

% compute how many remaining files are left for each product
compute_product_statistics();

% compute how many remaining files are left for each subject
compute_subject_statistics();

% separate remaining files according to labels
separate_artifact_free_data();

