%% Initialize
clear all;
clc;
close all;

%%
[NAME,SUBN,TYPE,TIME,SIDE,TASK] = initialization;
%%
root = 'D://FES2015//Kinematics_Analysis';
csvname = [root '//Variability//Variability.csv'];
Name_all = cell(1);
Subn_all = cell(1);
Type_all = cell(1);
Time_all = cell(1);
Side_all = cell(1);
Task_all = cell(1);
Var_all = cell(1);
Std_all = zeros(1);
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
                            [Name,Subn,Type,Time,Side,Task,Var,Std] = VariabilityAnalysis(Dir,name,subn,type,time,side,task);
                            Name_all = [Name_all;Name];
                            Subn_all = [Subn_all;Subn];
                            Type_all = [Type_all;Type];
                            Time_all = [Time_all;Time];
                            Side_all = [Side_all;Side];
                            Task_all = [Task_all;Task];
                            Var_all = [Var_all;Var];
                            Std_all = [Std_all;Std];                            
                        end
                    end
                end
            end
        end
    end
end
T = table(Name_all,Subn_all,Type_all,Time_all,Side_all,Task_all,Var_all,Std_all);
writetable(T(2:end,:),csvname)
