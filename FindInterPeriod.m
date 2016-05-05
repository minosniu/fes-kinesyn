function Period = FindInterPeriod(Data)
fs_kine = 120;
Data.Time = Data.Frame/fs_kine;
%% get onset & offset
l = length(Data.LeftElbowFlex);
vel(1:l-1) = diff(Data.LeftElbowFlex)*fs_kine;
vel(l) = vel(l-1);

[b,a] = butter(3,5/(fs_kine/2),'low');
vel = filtfilt(b,a,vel);

% acc(1:l-1) = diff(vel)*fs_kine;
% acc(l) = acc(l-1);

np = find(vel == min(vel));
z1 = find(vel(1:np) >= 0);
z2 = find(vel((np+1):end) >= 0);
list = z1(end):min(l,(z2(1)+np));

list1 = find(vel(list) <= 0.1 * min(vel));
period = (list1(1)+list(1)-1):(list1(end)+list(1)-1);
onset = period(1)-30;
offset = period(end)+80;
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
%% get velocity
l_period = length(Period.Frame);
% vel of hand x
Period.Vel_hand_x(1:l_period-1) = diff(Period.L_hand_x)*fs_kine;
Period.Vel_hand_x(l_period) = Period.Vel_hand_x(l_period-1);
Period.Vel_filt_hand_x = filtfilt(b,a,Period.Vel_hand_x);
% vel of hand y
Period.Vel_hand_y(1:l_period-1) = diff(Period.L_hand_y)*fs_kine;
Period.Vel_hand_y(l_period) = Period.Vel_hand_y(l_period-1);
Period.Vel_filt_hand_y = filtfilt(b,a,Period.Vel_hand_y);
% vel of hand xy
Period.Vel_filt_hand_xy = ((Period.Vel_filt_hand_x).^2+(Period.Vel_filt_hand_y).^2 ).^0.5;
% vel of elbow flexion
Period.Vel_elbow(1:l_period-1) = diff(Period.LeftElbowFlex)*fs_kine;
Period.Vel_elbow(l_period) = Period.Vel_elbow(l_period-1);
Period.Vel_filt_elbow = filtfilt(b,a,Period.Vel_elbow);
% vel of shoulder flexion
Period.Vel_sh_flex(1:l_period-1) = diff(Period.LeftShoulderFlex)*fs_kine;
Period.Vel_sh_flex(l_period) = Period.Vel_sh_flex(l_period-1);
Period.Vel_filt_sh_flex = filtfilt(b,a,Period.Vel_sh_flex);
% vel of shoulder abduction
Period.Vel_sh_abduct(1:l_period-1) = diff(Period.LeftShoulderAbduction)*fs_kine;
Period.Vel_sh_abduct(l_period) = Period.Vel_sh_abduct(l_period-1);
Period.Vel_filt_sh_abduct = filtfilt(b,a,Period.Vel_sh_abduct);
end