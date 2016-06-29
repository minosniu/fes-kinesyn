%% Initialize
clear all;
clc;
close all;

NAME = 'C01';
TYPE = 'CONTROL';
SIDE = 'R';
TASK = ['FR'; 'LR'];

root = 'D://FES2015//Kinematics_Analysis';
 
for SN_task = 2
    name = NAME;
    type = TYPE;
    side = SIDE;
    task = TASK(SN_task,:);
    Dir = [root '//FES_Control_01//' name '_' type '_' side '_' task];
    Axisfile = [root '//FES_Control_01//Axis_num_' name '_' task '.mat'];
    KinematicAnalysis(Dir,Axisfile);
end
