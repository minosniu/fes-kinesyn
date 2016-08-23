function PlotOnOffShadow(SN_type,subn,task,root,Dir,Axisfile)
VelColor        =   [   0	    0	   0.5;   % dark blue (navy)
                        0.5      0      0];   % dark red (maroon)

TraColor        =   [   0.53    0.81    0.98; % light blue (lightskyblue)
                        0.94	0.5	    0.5]; % light red (lightcoral)  

c_grey = [0.7 0.7 0.7];
ExpList = GetExpList(Dir);
N = length(ExpList);
Figname = [root '//Figures//' subn '_' task '_'];
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
Vel_hand_std = std(Vel_hand_temp);
%% plot hand xy
% hfig           =   figure(1);
% 
% Ymin_handxy = 0-((Ymin_handx).^2+(Ymin_handy).^2).^0.5;
% Ymax_handxy = ((Ymax_handx).^2+(Ymax_handy).^2).^0.5;
% xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
% ySize_i  = 6; % ¸ß11Ó¢´ç
% xLeft_i  = 0;
% yTop_i   = 0;
% set(hfig, 'Units', 'inches');  %  'centimeters'
% set(hfig, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
% set(hfig, 'PaperUnits', 'inches');  %  'centimeters'
% set(hfig, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
% 
% hold on;
% for i = 1:N
%     plot(Period{i}.Time,Period{i}.Vel_filt_hand_xy,'Color',TraColor(SN_type,:),'LineWidth',2);
% end
% hold on;
% plot(Period{N_longest}.Time,Vel_hand_ave,'Color',VelColor(SN_type,:),'LineWidth',4);
% axis([0 Tmax Ymin_handxy Ymax_handxy])
% 
% print(hfig,'-depsc',[Figname 'on_off_handxy_velo.eps']);
% print(hfig,'-dbmp',[Figname 'on_off_handxy_velo.bmp']);
%% ShadedErrorBar
hfig           =   figure(1);

Ymax_handxy = ((max(Ymax_handx,abs(Ymin_handx))).^2+(max(Ymax_handy,abs(Ymin_handy))).^2).^0.5;
xSize_i  = 4;   % Í¼Æ¬³¤8Ó¢´ç
ySize_i  = 6; % ¸ß11Ó¢´ç
xLeft_i  = 0;
yTop_i   = 0;
set(hfig, 'Units', 'inches');  %  'centimeters'
set(hfig, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
lineProps = {'Color',VelColor(SN_type,:),'LineWidth',3};

hold on;
shadedErrorBar(Period{N_longest}.Time,Vel_hand_ave,Vel_hand_std,lineProps,1);
axis([0 Tmax -0.1 Ymax_handxy])

print(hfig,'-depsc',[Figname 'on_off_handxy_velo.eps']);
print(hfig,'-dbmp',[Figname 'on_off_handxy_velo.bmp']);
%%
% close all;

end