%% Initialize
clear all;
clc;
close all;

%%
[NAME,SUBN,TYPE,TIME,SIDE,TASK] = initialization;
%%
root = 'D://FES2015//Kinematics_Analysis';
csvname = [root '//PeakValue//Peak_Std.csv'];
Name_temp = cell(1);
Subn_temp = cell(1);
Type_temp = cell(1);
Time_temp = cell(1);
Side_temp = cell(1);
Task_temp = cell(1);
Var_temp = cell(1);
AVEP_temp = zeros(1);
STDP_temp = zeros(1);
for SN_name = 5:10
    for SN_subn = SN_name
        for SN_type = 1:2
            for SN_time = 1:2
                for SN_side = 1:1
                    for SN_task = 1:2
                        name = NAME{SN_name};
                        subn = SUBN{SN_subn};
                        type = TYPE{SN_type};
                        time = TIME{SN_time};
                        side = SIDE{SN_side};
                        task = TASK{SN_task};
                        Dir = [root '//Kinematics_Data//' subn '_' type '_' time '_' side '_' task];
                        if isempty(ls(Dir))
                            display([subn '_' type '_' time '_' side '_' task ' does not exist']);
                        else
                            [Name,Subn,Type,Time,Side,Task,Var,AVEP,STDP] = StatisticAnalysis(Dir,name,subn,type,time,side,task);
                            Name_temp = [Name_temp;Name];
                            Subn_temp = [Subn_temp;Subn];
                            Type_temp = [Type_temp;Type];
                            Time_temp = [Time_temp;Time];
                            Side_temp = [Side_temp;Side];
                            Task_temp = [Task_temp;Task];
                            Var_temp = [Var_temp;Var];
                            AVEP_temp = [AVEP_temp;AVEP];
                            STDP_temp = [STDP_temp;STDP];                            
                        end
                    end
                end
            end
        end
    end
end
T = table(Name_temp,Subn_temp,Type_temp,Time_temp,Side_temp,Task_temp,Var_temp,AVEP_temp,STDP_temp);
writetable(T(2:end,:),csvname)
