%% Initialize
clear all;
clc;
close all;

NAME = {'无'; '无'; '无'; '无'; '刘海方'; '赵增起'; '王旭峰'; '李昌'; '毛建华'; '杨鸿伟'};
SUBN = {'S01'; 'S02'; 'S03'; 'S04'; 'S05'; 'S06'; 'S07'; 'S08'; 'S09'; 'S10'};
TYPE = {'NMES'; 'SHAM'};
TIME = {'AFT'; 'PRE'; 'IME'};
SIDE = {'L'; 'R'};
TASK = {'LR'; 'FR'};

root = 'D://FES2015//Kinematics_Analysis';
Name_temp = cell(1);
Subn_temp = cell(1);
Type_temp = cell(1);
Time_temp = cell(1);
Side_temp = cell(1);
Task_temp = cell(1);
Trial_temp = cell(1);
Var_temp = cell(1);
Peak_temp = zeros(1);
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
                        [Name,Subn,Type,Time,Side,Task,Trial,Var,Peak] = PeakValueCatching(Dir,name,subn,type,time,side,task);
                        Name_temp = [Name_temp;Name];
                        Subn_temp = [Subn_temp;Subn];
                        Type_temp = [Type_temp;Type];
                        Time_temp = [Time_temp;Time];
                        Side_temp = [Side_temp;Side];
                        Task_temp = [Task_temp;Task];
                        Trial_temp = [Trial_temp;Trial];
                        Var_temp = [Var_temp;Var];
                        Peak_temp = [Peak_temp;Peak];
                    end
                end
            end
        end
    end
end
T = table(Name_temp,Subn_temp,Type_temp,Time_temp,Side_temp,Task_temp,Trial_temp,Var_temp,Peak_temp);
csvname = [root '//PeakValue//Vel_Peak.csv'];
writetable(T(2:end,:),csvname)
