function[] = extract_features(FS, CHANNEL_NO)

% initializations
% folder_content_like = dir("check_artefacts/data-reduced-like/*.txt");
% folder_content_dislike = dir("check_artefacts/data-reduced-dislike/*.txt");
folder_content_like = dir("datasets\artifact_free_like_data\*.txt");
folder_content_dislike = dir("datasets\artifact_free_dislike_data\*.txt");
like_data_no = numel(folder_content_like);
dislike_data_no = numel(folder_content_dislike);
total_data_no = like_data_no + dislike_data_no;
window=256;
nover_lap=128;
nfft=2^nextpow2(window);

% empty containers
% for feature 1 : avg power
P_d_arr = zeros(total_data_no, CHANNEL_NO + 1);
P_t_arr = zeros(total_data_no, CHANNEL_NO + 1);
P_a_arr = zeros(total_data_no, CHANNEL_NO + 1);
P_b_arr = zeros(total_data_no, CHANNEL_NO + 1);
P_g_arr = zeros(total_data_no, CHANNEL_NO + 1);

% for feature 2 : spectral energy / total power
tP_d_arr = zeros(total_data_no, CHANNEL_NO + 1);
tP_t_arr = zeros(total_data_no, CHANNEL_NO + 1);
tP_a_arr = zeros(total_data_no, CHANNEL_NO + 1);
tP_b_arr = zeros(total_data_no, CHANNEL_NO + 1);
tP_g_arr = zeros(total_data_no, CHANNEL_NO + 1);

% for feature 3 : peak alpha
pA_arr = zeros(total_data_no, CHANNEL_NO + 1);

% for feature 4 : hemispheric asymmetry
left_hem_pw = zeros(1,7);
right_hem_pw = zeros(1,7);
hem_pw_arr = zeros(total_data_no, 2);

for i = 1 : total_data_no % for each EEG file
    
    if i <= like_data_no
%         data = load(fullfile("check_artefacts\data-reduced-like\",folder_content_like(i).name));
        data = load(fullfile("datasets\artifact_free_like_data\",folder_content_like(i).name));
        isLike = 1;
    else
        new_index = i - like_data_no;
%         data = load(fullfile("check_artefacts\data-reduced-dislike\",folder_content_dislike(new_index).name));
        data = load(fullfile("datasets\artifact_free_dislike_data\",folder_content_dislike(new_index).name));
        isLike = 0;
    end
    
    for j = 1 : CHANNEL_NO
       
        data_per_channel = data(:, j);
        % transform EEG data into frequency domain
        [Pw,Fw]=pwelch(data_per_channel,window,(100*nover_lap/window),nfft,FS);
        ind_delta = find(Fw > 1 & Fw < 4); 
        ind_theta = find(Fw > 4 & Fw < 8);
        ind_alpha = find(Fw > 8 & Fw < 13);
        ind_beta = find(Fw > 13 & Fw < 30);
        ind_gamma = find(Fw > 30 & Fw < 45);
        
        % feature 1 - avg power of each frequency band
        P_d_arr(i, j) = mean(Pw(ind_delta));
        P_t_arr(i, j) = mean(Pw(ind_theta));
        P_a_arr(i, j) = mean(Pw(ind_alpha));
        P_b_arr(i, j) = mean(Pw(ind_beta));
        P_g_arr(i, j) = mean(Pw(ind_gamma));
        
        % feature 2 - spectral energy/total absolute power of freq. bands
        tP_d_arr(i, j) = sum(Pw(ind_delta));
        tP_t_arr(i, j) = sum(Pw(ind_theta));
        tP_a_arr(i, j) = sum(Pw(ind_alpha));
        tP_b_arr(i, j) = sum(Pw(ind_beta));
        tP_g_arr(i, j) = sum(Pw(ind_gamma));
        
        
        % feature 3 - peak alpha
        pA_arr(i, j) = max(Pw(ind_alpha));
        
        % feature 4 - hemispheric asymmetry
        if j <= 7
            left_hem_pw(1,j) = sum(Pw);
        elseif j <= 14
            right_hem_pw(1,j) = sum(Pw);
        end
        
        % append label to the last column of each feature
        if j == CHANNEL_NO 
            % feature 1
            P_d_arr(i, j + 1) = isLike;
            P_t_arr(i, j + 1) = isLike;
            P_a_arr(i, j + 1) = isLike;
            P_b_arr(i, j + 1) = isLike;
            P_g_arr(i, j + 1) = isLike;
            
            % feature 2
            tP_d_arr(i, j + 1) = isLike;
            tP_t_arr(i, j + 1) = isLike;
            tP_a_arr(i, j + 1) = isLike;
            tP_b_arr(i, j + 1) = isLike;
            tP_g_arr(i, j + 1) = isLike;
            
            % feature 3
            pA_arr(i, j + 1) = isLike;
            
            % feature 4
            hem_pw_arr(i, 2) = isLike;
        end
        
    end
    
    % feature 4 hemispheric asymmetry
    sum_left = sum(left_hem_pw);
    sum_right = sum(right_hem_pw);
    hem_pw_arr(i) = (sum_left - sum_right)/(sum_left + sum_right);
    
end

% generate a folder to store feature files
% if not(isfolder('individual_features\'))
%     mkdir('individual_features\');
% end

if not(isfolder('feature_processing\individual_features\'))
    mkdir('feature_processing\individual_features\');
end

% feature 1 files
writematrix(P_d_arr, 'feature_processing\individual_features\Avg_pw_d.csv');
writematrix(P_t_arr, 'feature_processing\individual_features\Avg_pw_t.csv');
writematrix(P_a_arr, 'feature_processing\individual_features\Avg_pw_a.csv');
writematrix(P_b_arr, 'feature_processing\individual_features\Avg_pw_b.csv');
writematrix(P_g_arr, 'feature_processing\individual_features\Avg_pw_g.csv');

% feature 2 files
writematrix(tP_d_arr, 'feature_processing\individual_features\Spec_Energy_d.csv');
writematrix(tP_t_arr, 'feature_processing\individual_features\Spec_Energy_t.csv');
writematrix(tP_a_arr, 'feature_processing\individual_features\Spec_Energy_a.csv');
writematrix(tP_b_arr, 'feature_processing\individual_features\Spec_Energy_b.csv');
writematrix(tP_g_arr, 'feature_processing\individual_features\Spec_Energy_g.csv');

% feature 3 files
writematrix(pA_arr, 'feature_processing\individual_features\peak_alpha.csv');

% feature 4 files
writematrix(hem_pw_arr, 'feature_processing\individual_features\hemis_asymmetry.csv');



