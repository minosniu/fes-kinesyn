%% Initialize
clear all;
clc;
close all;

NAME = ['S01'; 'S02'; 'S03'; 'S04'; 'S05'; 'S06'; 'S07'; 'S08'; 'S09'; 'S10'];
TYPE = ['NMES'; 'SHAM'];
TIME = ['AFT'; 'PRE'; 'IME'];
SIDE = ['L'; 'R'];
TASK = ['LR'; 'FR'];

root = 'D://FES2015//Kinematics_Analysis';
root = '//Users//minosniu//Code//Kinematics_Analysis';
for SN_name = 5
    for SN_type = 1
        for SN_time = 1:2
            for SN_side = 1:1
                for SN_task = 1:2
                    name = NAME(SN_name,:);
                    type = TYPE(SN_type,:);
                    time = TIME(SN_time,:);
                    side = SIDE(SN_side,:);
                    task = TASK(SN_task,:);
                    Dir = [root '//Kinematics_Data//' name '_' type '_' time '_' side '_' task];
                    Axisfile = [root '//Kinematics_Data//Axis_num_' name '_' task '.mat'];
                    KinematicAnalysis(Dir,Axisfile);
                end
            end
        end
    end
end
