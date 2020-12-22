function[] = extract_features(FS, CHANNEL_NO)

% initializations
folder_content_like = dir("check_artefacts/data-reduced-like/*.txt");
folder_content_dislike = dir("check_artefacts/data-reduced-dislike/*.txt");
like_data_no = numel(folder_content_like);
dislike_data_no = numel(folder_content_dislike);
window=256;
nover_lap=128;
nfft=2^nextpow2(window);

% empty containers
% for feature 1 : avg power
P_d_arr_like = zeros(like_data_no, CHANNEL_NO);
P_t_arr_like = zeros(like_data_no, CHANNEL_NO);
P_a_arr_like = zeros(like_data_no, CHANNEL_NO);
P_b_arr_like = zeros(like_data_no, CHANNEL_NO);
P_g_arr_like = zeros(like_data_no, CHANNEL_NO);
P_d_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
P_t_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
P_a_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
P_b_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
P_g_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);

% for feature 2 : spectral energy
tP_d_arr_like = zeros(like_data_no, CHANNEL_NO);
tP_t_arr_like = zeros(like_data_no, CHANNEL_NO);
tP_a_arr_like = zeros(like_data_no, CHANNEL_NO);
tP_b_arr_like = zeros(like_data_no, CHANNEL_NO);
tP_g_arr_like = zeros(like_data_no, CHANNEL_NO);
tP_d_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
tP_t_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
tP_a_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
tP_b_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);
tP_g_arr_dislike = zeros(dislike_data_no, CHANNEL_NO);

% for feature 3 : peak alpha
p_a_array_like = zeros(like_data_no, CHANNEL_NO);
p_a_array_dislike = zeros(dislike_data_no, CHANNEL_NO);

% for feature 4 : hemispheric asymmetry
hem_pw_array_like = zeros(like_data_no, 1);
hem_pw_array_dislike = zeros(dislike_data_no,1);
left_hem_pw = zeros(1,7);
right_hem_pw = zeros(1,7);

for i = 1 : like_data_no % for each EEG file with 'like' label
    
    data = load(fullfile("check_artefacts\data-reduced-like\",folder_content_like(i).name));
    
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
        P_d_arr_like(i, j) = mean(Pw(ind_delta));
        P_t_arr_like(i, j) = mean(Pw(ind_theta));
        P_a_arr_like(i, j) = mean(Pw(ind_alpha));
        P_b_arr_like(i, j) = mean(Pw(ind_beta));
        P_g_arr_like(i, j) = mean(Pw(ind_gamma));
        
        % feature 2 - spectral energy/total absolute power of freq. bands
        tP_d_arr_like(i, j) = sum(Pw(ind_delta));
        tP_t_arr_like(i, j) = sum(Pw(ind_theta));
        tP_a_arr_like(i, j) = sum(Pw(ind_alpha));
        tP_b_arr_like(i, j) = sum(Pw(ind_beta));
        tP_g_arr_like(i, j) = sum(Pw(ind_gamma));
        
        % feature 3 - peak alpha
        p_a_array_like(i, j) = max(Pw(ind_alpha));
        
        % feature 4 - hemispheric asymmetry
        if j <= 7
            left_hem_pw(1,j) = sum(Pw);
        elseif j <= 14
            right_hem_pw(1,j) = sum(Pw);
        end
        
    end
    
    % feature 4 hemispheric asymmetry
    sum_left = sum(left_hem_pw);
    sum_right = sum(right_hem_pw);
    hem_pw_array_like(i) = (sum_left - sum_right)/(sum_left + sum_right);
    
end

for i = 1 : dislike_data_no % for each EEG file with 'dislike' label
   
    data = load(fullfile("check_artefacts\data-reduced-dislike\",folder_content_dislike(i).name));
    
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
        P_d_arr_dislike(i, j) = mean(Pw(ind_delta));
        P_t_arr_dislike(i, j) = mean(Pw(ind_theta));
        P_a_arr_dislike(i, j) = mean(Pw(ind_alpha));
        P_b_arr_dislike(i, j) = mean(Pw(ind_beta));
        P_g_arr_dislike(i, j) = mean(Pw(ind_gamma));
        
        % feature 2 - spectral energy/total absolute power of freq. bands
        tP_d_arr_dislike(i, j) = sum(Pw(ind_delta));
        tP_t_arr_dislike(i, j) = sum(Pw(ind_theta));
        tP_a_arr_dislike(i, j) = sum(Pw(ind_alpha));
        tP_b_arr_dislike(i, j) = sum(Pw(ind_beta));
        tP_g_arr_dislike(i, j) = sum(Pw(ind_gamma));
        
        % feature 3 - peak alpha
        p_a_array_dislike(i, j) = max(Pw(ind_alpha));
        
        % feature 4 - hemispheric asymmetry
        if j <= 7
            left_hem_pw(1,j) = sum(Pw);
        elseif j <= 14
            right_hem_pw(1,j) = sum(Pw);
        end
        
    end
    
    % feature 4 hemispheric asymmetry
    sum_left = sum(left_hem_pw);
    sum_right = sum(right_hem_pw);
    hem_pw_array_dislike(i) = (sum_left - sum_right)/(sum_left + sum_right);
    
end

% generate a folder to store feature files
if not(isfolder('features\'))
    mkdir('features\');
end

% feature 1 files
writematrix(P_d_arr_like, 'features\Avg_pw_d_like.txt', 'Delimiter', 'space');
writematrix(P_t_arr_like, 'features\Avg_pw_t_like.txt', 'Delimiter', 'space');
writematrix(P_a_arr_like, 'features\Avg_pw_a_like.txt', 'Delimiter', 'space');
writematrix(P_b_arr_like, 'features\Avg_pw_b_like.txt', 'Delimiter', 'space');
writematrix(P_g_arr_like, 'features\Avg_pw_g_like.txt', 'Delimiter', 'space');
writematrix(P_d_arr_dislike, 'features\Avg_pw_d_dislike.txt', 'Delimiter', 'space');
writematrix(P_t_arr_dislike, 'features\Avg_pw_t_dislike.txt', 'Delimiter', 'space');
writematrix(P_a_arr_dislike, 'features\Avg_pw_a_dislike.txt', 'Delimiter', 'space');
writematrix(P_b_arr_dislike, 'features\Avg_pw_b_dislike.txt', 'Delimiter', 'space');
writematrix(P_g_arr_dislike, 'features\Avg_pw_g_dislike.txt', 'Delimiter', 'space');

% feature 2 files
writematrix(tP_d_arr_like, 'features\Spec_Energy_d_like.txt', 'Delimiter', 'space');
writematrix(tP_t_arr_like, 'features\Spec_Energy_t_like.txt', 'Delimiter', 'space');
writematrix(tP_a_arr_like, 'features\Spec_Energy_a_like.txt', 'Delimiter', 'space');
writematrix(tP_b_arr_like, 'features\Spec_Energy_b_like.txt', 'Delimiter', 'space');
writematrix(tP_g_arr_like, 'features\Spec_Energy_g_like.txt', 'Delimiter', 'space');
writematrix(tP_d_arr_dislike, 'features\Spec_Energy_d_dislike.txt', 'Delimiter', 'space');
writematrix(tP_t_arr_dislike, 'features\Spec_Energy_t_dislike.txt', 'Delimiter', 'space');
writematrix(tP_a_arr_dislike, 'features\Spec_Energy_a_dislike.txt', 'Delimiter', 'space');
writematrix(tP_b_arr_dislike, 'features\Spec_Energy_b_dislike.txt', 'Delimiter', 'space');
writematrix(tP_g_arr_dislike, 'features\Spec_Energy_g_dislike.txt', 'Delimiter', 'space');

% feature 3 files
writematrix(p_a_array_like, 'features\peak_alpha_like.txt', 'Delimiter', 'space');
writematrix(p_a_array_dislike, 'features\peak_alpha_dislike.txt', 'Delimiter', 'space');

% feature 4 files
writematrix(hem_pw_array_like, 'features\hemis_asymmetry_like.txt', 'Delimiter', 'space');
writematrix(hem_pw_array_dislike, 'features\hemis_asymmetry_dislike.txt', 'Delimiter', 'space');



