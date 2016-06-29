function Period = FindInterPeriodNoSide(Data)
fs_kine = 120;
Data.Time = Data.Frame/fs_kine;
%% filter design
[b,a] = butter(3,5/(fs_kine/2),'low');
%% get velocity
l_period = length(Data.Frame);
% vel of hand x
Data.Vel_hand_x(1:l_period-1) = diff(Data.Hand_x)*fs_kine;
Data.Vel_hand_x(l_period) = Data.Vel_hand_x(l_period-1);
Data.Vel_filt_hand_x = filtfilt(b,a,Data.Vel_hand_x);
% vel of hand y
Data.Vel_hand_y(1:l_period-1) = diff(Data.Hand_y)*fs_kine;
Data.Vel_hand_y(l_period) = Data.Vel_hand_y(l_period-1);
Data.Vel_filt_hand_y = filtfilt(b,a,Data.Vel_hand_y);
% vel of hand xy
Data.Vel_hand_xy = ((Data.Vel_hand_x).^2+(Data.Vel_hand_y).^2 ).^0.5;
Data.Vel_filt_hand_xy = filtfilt(b,a,Data.Vel_hand_xy);
% vel of elbow flexion
Data.Vel_elbow(1:l_period-1) = diff(Data.ElbowFlex)*fs_kine;
Data.Vel_elbow(l_period) = Data.Vel_elbow(l_period-1);
Data.Vel_filt_elbow = filtfilt(b,a,Data.Vel_elbow);
% vel of shoulder flexion
Data.Vel_sh_flex(1:l_period-1) = diff(Data.ShoulderFlex)*fs_kine;
Data.Vel_sh_flex(l_period) = Data.Vel_sh_flex(l_period-1);
Data.Vel_filt_sh_flex = filtfilt(b,a,Data.Vel_sh_flex);
% vel of shoulder abduction
Data.Vel_sh_abduct(1:l_period-1) = diff(Data.ShoulderAbduction)*fs_kine;
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
Period.ShoulderFlex = Data.ShoulderFlex(onset:offset);
Period.ShoulderRotation = Data.ShoulderRotation(onset:offset);
Period.ShoulderAbduction = Data.ShoulderAbduction(onset:offset);
Period.ElbowFlex = Data.ElbowFlex(onset:offset);
Period.WristFlex = Data.WristFlex(onset:offset);
Period.Acro_x = Data.Acro_x(onset:offset);
Period.Acro_y = Data.Acro_y(onset:offset);
Period.Acro_z = Data.Acro_z(onset:offset);
Period.Olec_x = Data.Olec_x(onset:offset);
Period.Olec_y = Data.Olec_y(onset:offset);
Period.Olec_z = Data.Olec_z(onset:offset);
Period.Hand_x = Data.Hand_x(onset:offset);
Period.Hand_y = Data.Hand_y(onset:offset);
Period.Hand_z = Data.Hand_z(onset:offset);
Period.Trigger = Data.Trigger(onset:offset);
Period.Vel_filt_hand_x = Data.Vel_filt_hand_x(onset:offset);
Period.Vel_filt_hand_y = Data.Vel_filt_hand_y(onset:offset);
Period.Vel_filt_hand_xy = Data.Vel_filt_hand_xy(onset:offset);
Period.Vel_filt_elbow = Data.Vel_filt_elbow(onset:offset);
Period.Vel_filt_sh_flex = Data.Vel_filt_sh_flex(onset:offset);
Period.Vel_filt_sh_abduct = Data.Vel_filt_sh_abduct(onset:offset);
end