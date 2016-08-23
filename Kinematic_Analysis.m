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
for SN_name = [6,11] % 6,11,14
    for SN_subn = SN_name
        for SN_type = 2
            for SN_time = 1:2
                for SN_side = 1
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
%% plot pre/aft data
                        PlotPreAftTogether(SN_time,subn,task,root,Dir,Axisfile); % PRE:BLUE; AFT:RED;  plot together
                        PlotPreAftSeparate(SN_time,subn,task,time,root,Dir,Axisfile); % PRE:BLUE; AFT:RED;  plot separate
%% plot on/off data
%                         PlotOnOffTogether(SN_type,subn,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED;  plot onoff together
%                         PlotOnOffSeparate(SN_type,subn,type,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED;  plot onoff separate
% %                         PlotOnOffShadow(SN_type,subn,task,root,Dir,Axisfile); % SHAM:BLUE; NMES:RED; plot onoff using shadowerrorbar
                    end
                end
            end
        end
    end
end
