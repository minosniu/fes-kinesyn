function Period = FindInterPeriod(Data)
fs_kine = 120;
Data.Time = Data.Frame/fs_kine;
%% filter design
[b,a] = butter(3,5/(fs_kine/2),'low');
%% get velocity
l_period = length(Data.Frame);
% vel of hand x
Data.Vel_hand_x(1:l_period-1) = diff(Data.L_hand_x)*fs_kine;
Data.Vel_hand_x(l_period) = Data.Vel_hand_x(l_period-1);
Data.Vel_filt_hand_x = filtfilt(b,a,Data.Vel_hand_x);
% vel of hand y
Data.Vel_hand_y(1:l_period-1) = diff(Data.L_hand_y)*fs_kine;
Data.Vel_hand_y(l_period) = Data.Vel_hand_y(l_period-1);
Data.Vel_filt_hand_y = filtfilt(b,a,Data.Vel_hand_y);
% vel of hand xy
Data.Vel_hand_xy = ((Data.Vel_hand_x).^2+(Data.Vel_hand_y).^2 ).^0.5;
Data.Vel_filt_hand_xy = filtfilt(b,a,Data.Vel_hand_xy);
% vel of elbow flexion
Data.Vel_elbow(1:l_period-1) = diff(Data.LeftElbowFlex)*fs_kine;
Data.Vel_elbow(l_period) = Data.Vel_elbow(l_period-1);
Data.Vel_filt_elbow = filtfilt(b,a,Data.Vel_elbow);
% vel of shoulder flexion
Data.Vel_sh_flex(1:l_period-1) = diff(Data.LeftShoulderFlex)*fs_kine;
Data.Vel_sh_flex(l_period) = Data.Vel_sh_flex(l_period-1);
Data.Vel_filt_sh_flex = filtfilt(b,a,Data.Vel_sh_flex);
% vel of shoulder abduction
Data.Vel_sh_abduct(1:l_period-1) = diff(Data.LeftShoulderAbduction)*fs_kine;
Data.Vel_sh_abduct(l_period) = Data.Vel_sh_abduct(l_period-1);
Data.Vel_filt_sh_abduct = filtfilt(b,a,Data.Vel_sh_abduct);
%% get onset & offset
vel = Data.Vel_filt_hand_xy;
np = find(vel == max(vel));
pre_list = find(vel(1:np) <= 0.1 * max(vel));
aft_list = find(vel((np+1):end) <= 0.1 * max(vel));
time_ini = max(1,pre_list(end));
time_ter = min(np+aft_list(1),l_period);
onset = time_ini-30;
offset = time_ter+80;
%% get Period
Period.Frame = Data.Frame(onset:offset);
Period.Time = Data.Time(onset:offset) - Data.Time(onset);
Period.LeftShoulderFlex = Data.LeftShoulderFlex(onset:offset);
Period.LeftShoulderRotation = Data.LeftShoulderRotation(onset:offset);
Period.LeftShoulderAbduction = Data.LeftShoulderAbduction(onset:offset);
Period.LeftElbowFlex = Data.LeftElbowFlex(onset:offset);
Period.LeftWristFlex = Data.LeftWristFlex(onset:offset);
Period.L_acro_x = Data.L_acro_x(onset:offset);
Period.L_acro_y = Data.L_acro_y(onset:offset);
Period.L_acro_z = Data.L_acro_z(onset:offset);
Period.L_olec_x = Data.L_olec_x(onset:offset);
Period.L_olec_y = Data.L_olec_y(onset:offset);
Period.L_olec_z = Data.L_olec_z(onset:offset);
Period.L_hand_x = Data.L_hand_x(onset:offset);
Period.L_hand_y = Data.L_hand_y(onset:offset);
Period.L_hand_z = Data.L_hand_z(onset:offset);
Period.Trigger = Data.Trigger(onset:offset);
Period.Vel_filt_hand_x = Data.Vel_filt_hand_x(onset:offset);
Period.Vel_filt_hand_y = Data.Vel_filt_hand_y(onset:offset);
Period.Vel_filt_hand_xy = Data.Vel_filt_hand_xy(onset:offset);
Period.Vel_filt_elbow = Data.Vel_filt_elbow(onset:offset);
Period.Vel_filt_sh_flex = Data.Vel_filt_sh_flex(onset:offset);
Period.Vel_filt_sh_abduct = Data.Vel_filt_sh_abduct(onset:offset);
end