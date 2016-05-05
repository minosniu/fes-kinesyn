function [Name,Subn,Type,Time,Side,Task,Trial,Var,Peak] = PeakValueCatching(Dir,name,subn,type,time,side,task)
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
%% Find peak value
Trial = cell(4*N,1);
Name = cell(4*N,1);
Subn = cell(4*N,1);
Type = cell(4*N,1);
Time = cell(4*N,1);
Side = cell(4*N,1);
Task = cell(4*N,1);
Var= cell(4*N,1);
Peak(1:4*N,1) = 0;
for j = 1:N
    L = length(Period{j}.Vel_filt_hand_x);
    for flag = 1:L
        Vel_filt_hand_xy = ((Period{j}.Vel_filt_hand_x).^2+(Period{j}.Vel_filt_hand_y).^2 ).^0.5;
    end
    Peak(j) = max(Vel_filt_hand_xy);
    Peak(j+1*N) = max(abs(Period{j}.Vel_filt_elbow));
    Peak(j+2*N) = max(Period{j}.Vel_filt_sh_flex);
    Peak(j+3*N) = max(Period{j}.Vel_filt_sh_abduct);
    Var{j} = 'handxy';
    Var{1*N+j} = 'elbow';
    Var{2*N+j} = 'shflex';
    Var{3*N+j} = 'shabduct';    
    Trial{j} = filename{j}(end-6:end-4);
    Trial{N+j} = filename{j}(end-6:end-4);
    Trial{2*N+j} = filename{j}(end-6:end-4);
    Trial{3*N+j} = filename{j}(end-6:end-4);
end
for k = 1:4*N    
    Name{k} = name;
    Subn{k} = subn;
    Type{k} = type;
    Time{k} = time;
    Side{k} = side;
    Task{k} = task;
end