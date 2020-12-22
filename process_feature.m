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