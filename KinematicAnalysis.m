function KinematicAnalysis(root,Dir,Axisfile)
VelColor        =   [   0.08	0.17	0.55;   % dark blue
                        0.6     0.2     0;      % dark red
                        0       0.4     0;      % dark green
                        0.04	0.52	0.78;   % dark cyan
                        0.75	0       0.75;	% dark magenta
                        0.68	0.47	0;      % dark yellow
                        0.33    0.11    0.55;   % dark pruple
                        0.37    0.15    0.07];  % dark brown

TraColor        =   [   0.08	0.07	0.95;   % blue
                        0.9     0.1     0;      % red
                        0       0.8     0;      % green
                        0.04	0.82	0.88;   % cyan
                        0.95	0       0.95;	% magenta
                        0.78	0.77	0;      % yellow
                        0.63    0.13    0.94;   % purple
                        0.5     0.12    0.12];  % brown

c_grey = [0.7 0.7 0.7];
ExpList = GetExpList(Dir);
N = length(ExpList);
Figname = [root '//Figures//' Dir(end-16:end) '_'];
load(Axisfile);
%% Load file and find the moving period
filename = cell(N,1);
Legend = cell(N,1);
Data = cell(N,1);
Period = cell(N,1);
L = zeros(N,1);
for i = 1:N
    filename{i} = [Dir '//' ExpList{i}];
    Legend{i} = ExpList{i}(end-6:end-4);
    Data{i} = ImportExpData(filename{i});
    Period{i} = FindInterPeriodNoSide(Data{i});
    L(i) = length(Period{i}.Time);
end
L_max = max(L);
N_longest = (L == L_max);
Vel_hand_temp = zeros(N,L_max);
for i = 1:N
    Vel_hand_temp(i,1:L(i)) = Period{i}.Vel_filt_hand_xy;
    Vel_hand_temp(i,L(i):L_max) = Vel_hand_temp(i,L(i));
end
Vel_hand_ave = mean(Vel_hand_temp);
%% plot Vel_hand_x and Vel_hand_y
hfig1           =   figure;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 6; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig1, 'Units', 'inches');  %  'centimeters'
set(hfig1, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig1, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig1, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);

subplot(2,1,1)
hold on;
for i = 1:N
    plot(Period{i}.Time,0-Period{i}.Vel_filt_hand_x,'Color',c_grey,'LineWidth',2);
end
axis([0 Tmax Ymin_handx Ymax_handx])

subplot(2,1,2)
hold on;
for i = 1:N
    plot(Period{i}.Time,Period{i}.Vel_filt_hand_y,'Color',c_grey,'LineWidth',2);
end
axis([0 Tmax Ymin_handy Ymax_handy])

print(hfig1,'-depsc',[Figname 'hand_velo.eps']);
print(hfig1,'-dbmp',[Figname 'hand_velo.bmp']);
%% plot elbow flexion
hfig2           =   figure;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 6; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig2, 'Units', 'inches');  %  'centimeters'
set(hfig2, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig2, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig2, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);

hold on;
for i = 1:N
    plot(Period{i}.Time,0-Period{i}.Vel_filt_elbow,'Color',c_grey,'LineWidth',2);
end
axis([0 Tmax Ymin_elbow Ymax_elbow])

print(hfig2,'-depsc',[Figname 'elbow_velo.eps']);
print(hfig2,'-dbmp',[Figname 'elbow_velo.bmp']);
%% plot Vel_sh_flex and Vel_sh_abduct
hfig3           =   figure;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 6; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig3, 'Units', 'inches');  %  'centimeters'
set(hfig3, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig3, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig3, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);

subplot(2,1,1)
hold on;
for i = 1:N
    plot(Period{i}.Time,Period{i}.Vel_filt_sh_flex,'Color',c_grey,'LineWidth',2);
end
axis([0 Tmax Ymin_shf Ymax_shf])

subplot(2,1,2)
hold on;
for i = 1:N
    plot(Period{i}.Time,Period{i}.Vel_filt_sh_abduct,'Color',c_grey,'LineWidth',2);
end
axis([0 Tmax Ymin_shab Ymax_shab])

print(hfig3,'-depsc',[Figname 'shoulder_velo.eps']);
print(hfig3,'-dbmp',[Figname 'shoulder_velo.bmp']);
%% plot trajec
hfig4           =   figure;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 3; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig4, 'Units', 'inches');  %  'centimeters'
set(hfig4, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig4, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig4, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
hold on;
for i = 1:N
    plot(Period{i}.Hand_x,Period{i}.Hand_y,'Color',c_grey,'LineWidth',2);
end
ylim([0.1 0.60]);
xlim([0.2 1.4]);

print(hfig4,'-depsc',[Figname 'arm_traj.eps']);
print(hfig4,'-dbmp',[Figname 'arm_traj.bmp']);
%% plot hand xy
hfig5           =   figure;

Ymax_handxy = ((max(Ymax_handx,abs(Ymin_handx))).^2+(max(Ymax_handy,abs(Ymin_handy))).^2).^0.5;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 6; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig5, 'Units', 'inches');  %  'centimeters'
set(hfig5, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig5, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig5, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);

hold on;
for i = 1:N
    plot(Period{i}.Time,Period{i}.Vel_filt_hand_xy,'Color',c_grey,'LineWidth',2);
end
hold on;
plot(Period{N_longest}.Time,Vel_hand_ave,'Color','k','LineWidth',3);
axis([0 Tmax -0.1 Ymax_handxy])

print(hfig5,'-depsc',[Figname 'handxy_velo.eps']);
print(hfig5,'-dbmp',[Figname 'handxy_velo.bmp']);
%%
% close all;

end