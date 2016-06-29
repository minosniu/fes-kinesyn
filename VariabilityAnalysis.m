function [Name,Subn,Type,Time,Side,Task,Var,Std] = VariabilityAnalysis(Dir,name,subn,type,time,side,task)
ExpList = GetExpList(Dir);
N = length(ExpList);
%% Load file and find the moving period
filename = cell(N,1);
Legend = cell(N,1);
Data = cell(N,1);
Period = cell(N,1);
for i = 1:N
    filename{i} = [Dir '//' ExpList{i}];
    Legend{i} = ExpList{i}(end-6:end-4);
    Data{i} = ImportLeftData(filename{i});
    Period{i} = FindInterPeriod(Data{i});
end
%% Variability Analysis
Name = cell(4,1);
Subn = cell(4,1);
Type = cell(4,1);
Time = cell(4,1);
Side = cell(4,1);
Task = cell(4,1);
Var = cell(4,1);
L = zeros(N,1);
Std= zeros(4,1);
for j = 1:N
    L(j) = length(Period{j}.Vel_filt_hand_x(31:(end-80)));
    for flag = 1:L
        Period{j}.Vel_filt_hand_xy = ((Period{j}.Vel_filt_hand_x).^2+(Period{j}.Vel_filt_hand_y).^2 ).^0.5;
    end
end

% Build Matrix ------------------------------------------------------------
L_min = min(L);
L_max = max(L);
V_handxy = zeros(N,L_max);
V_elbow = zeros(N,L_max);
V_shflex = zeros(N,L_max);
V_shabduc = zeros(N,L_max);
for k = 1:N
    V_handxy(k,1:L(k)) = Period{k}.Vel_filt_hand_xy(31:(end-80));
    V_elbow(k,1:L(k)) = (0-Period{k}.Vel_filt_elbow(31:(end-80)));
    V_shflex(k,1:L(k)) = Period{k}.Vel_filt_sh_flex(31:(end-80));
    V_shabduc(k,1:L(k)) = Period{k}.Vel_filt_sh_abduct(31:(end-80));
end

% Statistic Analysis ------------------------------------------------------
for m = 1:L_min
    Std_handxy = std(V_handxy(:,m));
    Std_elbow = std(V_elbow(:,m));
    Std_shflex = std(V_shflex(:,m));
    Std_shabduc = std(V_shabduc(:,m));
end
Var{1} = 'handxy';
Var{2} = 'elbow';
Var{3} = 'shflex';
Var{4} = 'shabduct';
Std(1) = mean(Std_handxy);
Std(2) = mean(Std_elbow);
Std(3) = mean(Std_shflex);
Std(4) = mean(Std_shabduc);
for num = 1:4    
    Name{num} = name;
    Subn{num} = subn;
    Type{num} = type;
    Time{num} = time;
    Side{num} = side;
    Task{num} = task;
end