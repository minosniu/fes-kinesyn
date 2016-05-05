name = 'S10';

Tmax = 1.5;
% hand
Ymin_handx = -0.4;
Ymax_handx = 1.3;
Ymin_handy = -0.4;
Ymax_handy = 0.8;
% elbow
Ymin_elbow = -100;
Ymax_elbow = 180;
% shoulder
Ymin_shf = -80;
Ymax_shf = 80;
Ymin_shab = -50;
Ymax_shab = 300;

save(['D://FES2015//Kinematics_Analysis//Kinematics_Data//Axis_num_' name '_LR.mat'], 'Tmax', 'Ymin_handx','Ymax_handx', 'Ymin_handy', 'Ymax_handy', 'Ymin_elbow','Ymax_elbow','Ymin_shf','Ymax_shf','Ymin_shab','Ymax_shab');
clear Tmax Ymin_handx Ymax_handx Ymin_handy Ymax_handy Ymin_elbow Ymax_elbow Ymin_shf Ymax_shf Ymin_shab Ymax_shab;
Tmax = 1.5;
% hand
Ymin_handx = -0.4;
Ymax_handx = 0.4;
Ymin_handy = -0.5;
Ymax_handy = 1.4;
% elbow
Ymin_elbow = -50;
Ymax_elbow = 250;
% shoulder
Ymin_shf = -60;
Ymax_shf = 70;
Ymin_shab = -50;
Ymax_shab = 50;
save(['D://FES2015//Kinematics_Analysis//Kinematics_Data//Axis_num_' name '_FR.mat'], 'Tmax', 'Ymin_handx','Ymax_handx', 'Ymin_handy', 'Ymax_handy', 'Ymin_elbow','Ymax_elbow','Ymin_shf','Ymax_shf','Ymin_shab','Ymax_shab');