function PlotPreAftTogether(SN_time,subn,task,root,Dir,Axisfile)
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
Figname = [root '//Figures//PreAftTogether//' subn '_' task '_'];
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
Vel_elbow_temp = zeros(N,L_max);
Vel_hand_temp = zeros(N,L_max);
for i = 1:N
    Vel_elbow_temp(i,1:L(i)) = Period{i}.Vel_filt_elbow;
    Vel_elbow_temp(i,L(i):L_max) = Vel_elbow_temp(i,L(i));
    Vel_hand_temp(i,1:L(i)) = Period{i}.Vel_filt_hand_xy;
    Vel_hand_temp(i,L(i):L_max) = Vel_hand_temp(i,L(i));
end
Vel_elbow_ave = mean(Vel_elbow_temp);
Vel_hand_ave = mean(Vel_hand_temp);
%% plot elbow flexion
if exist([Figname 'elbow_velo.fig'],'file') == 2
    hfig1 = open([Figname 'elbow_velo.fig']);
else
    hfig1           =   figure;
    xSize_i  = 8;   % Í¼Æ¬³¤8Ó¢´ç
    ySize_i  = 6;   % ¸ß6Ó¢´ç
    xLeft_i  = 0;
    yTop_i   = 0;
    set(hfig1, 'Units', 'inches');  %  'centimeters'
    set(hfig1, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
    set(hfig1, 'PaperUnits', 'inches');  %  'centimeters'
    set(hfig1, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
end
hold on;
for i = 1:N
    plot(Period{i}.Time,0-Period{i}.Vel_filt_elbow,'Color',TraColor(SN_time,:),'LineWidth',1);
end
hold on;
plot(Period{N_longest}.Time,0-Vel_elbow_ave,'Color',VelColor(SN_time,:),'LineWidth',3);
axis([0 Tmax Ymin_elbow Ymax_elbow])
saveas(hfig1,[Figname 'elbow_velo.fig']);
print(hfig1,'-depsc',[Figname 'elbow_velo.eps']);
print(hfig1,'-dbmp',[Figname 'elbow_velo.bmp']);
close;
%% plot hand xy
Ymax_handxy = ((max(Ymax_handx,abs(Ymin_handx))).^2+(max(Ymax_handy,abs(Ymin_handy))).^2).^0.5;
if exist([Figname 'handxy_velo.fig'],'file') == 2
    hfig2 = open([Figname 'handxy_velo.fig']);
else
    hfig2           =   figure;
    xSize_i  = 8;   % Í¼Æ¬³¤8Ó¢´ç
    ySize_i  = 6;   % ¸ß6Ó¢´ç
    xLeft_i  = 0;
    yTop_i   = 0;
    set(hfig2, 'Units', 'inches');  %  'centimeters'
    set(hfig2, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
    set(hfig2, 'PaperUnits', 'inches');  %  'centimeters'
    set(hfig2, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
end
hold on;
for i = 1:N
    plot(Period{i}.Time,Period{i}.Vel_filt_hand_xy,'Color',TraColor(SN_time,:),'LineWidth',1);
end
hold on;
plot(Period{N_longest}.Time,Vel_hand_ave,'Color',VelColor(SN_time,:),'LineWidth',3);
axis([0 Tmax -0.1 Ymax_handxy])
saveas(hfig1,[Figname 'handxy_velo.fig']);
print(hfig2,'-depsc',[Figname 'handxy_velo.eps']);
print(hfig2,'-dbmp',[Figname 'handxy_velo.bmp']);
close;
%%
% close all;

end