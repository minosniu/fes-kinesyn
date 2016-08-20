%% Initialize
clear all;
clc;
close all;
%%
[NAME,SUBN,TYPE,TIME,SIDE,TASK] = initialization;
% TYPE = {'SHAM'; 'NMES'};
% TIME = {'PRE'; 'AFT'; 'IME'};
% SIDE = {'L'; 'R'};
% TASK = {'FR'; 'LR'};

root = 'D://FES2015//Kinematics_Analysis';
for SN_name = 14 % 6,11,14
    for SN_subn = SN_name
        for SN_type = 1:2
            for SN_time = 3
                for SN_side = 2
                    for SN_task = 1:2
                        name = NAME{SN_name};
                        subn = SUBN{SN_subn};
                        type = TYPE{SN_type};
                        time = TIME{SN_time};
                        side = SIDE{SN_side};
                        task = TASK{SN_task};
                        Dir = [root '//Kinematics_Data//' subn '_' type '_' time '_' side '_' task];
                        Axisfile = [root '//Kinematics_Data//Axis_num_' subn '_' task '.mat'];
%                         KinematicAnalysis(root,Dir,Axisfile);
                        PlotOnOffTogether(SN_type,subn,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED
                        PlotOnOffSeparate(SN_type,subn,type,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED
%                         PlotOnOffShadow(SN_type,subn,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED
                    end
                end
            end
        end
    end
end
