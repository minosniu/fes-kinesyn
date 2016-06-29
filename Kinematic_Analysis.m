%% Initialize
clear all;
clc;
close all;
%%
[NAME,SUBN,TYPE,TIME,SIDE,TASK] = initialization;

root = 'D://FES2015//Kinematics_Analysis';
for SN_name = 11
    for SN_subn = SN_name
        for SN_type = 1
            for SN_time = 1:2
                for SN_side = 1
                    for SN_task = 2
                        name = NAME{SN_name};
                        subn = SUBN{SN_subn};
                        type = TYPE{SN_type};
                        time = TIME{SN_time};
                        side = SIDE{SN_side};
                        task = TASK{SN_task};
                        Dir = [root '//Kinematics_Data//' subn '_' type '_' time '_' side '_' task];
                        Axisfile = [root '//Kinematics_Data//Axis_num_' subn '_' task '.mat'];
                        KinematicAnalysis(Dir,Axisfile);
                    end
                end
            end
        end
    end
end
