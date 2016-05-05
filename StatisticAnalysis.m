function StatisticAnalysis(N,Period)
temp1(1:N) = 0;
temp2(1:N) = 0;
temp3(1:N) = 0;
temp4(1:N) = 0;
temp5(1:N) = 0;
for flag = 1:N
    temp1(flag) = max(abs(Period{flag}.Vel_filt_hand_x));
    temp2(flag) = max(abs(Period{flag}.Vel_filt_hand_y));
    temp3(flag) = max(abs(Period{flag}.Vel_filt_elbow));
    temp4(flag) = max(Period{flag}.Vel_filt_sh_flex);
    temp5(flag) = max(Period{flag}.Vel_filt_sh_abduct);
end
AVEP1 = mean(temp1);
STDP1 = std(temp1);
display(AVEP1);
display(STDP1);
AVEP2 = mean(temp2);
STDP2 = std(temp2);
display(AVEP2);
display(STDP2);
AVEP3 = mean(temp3);
STDP3 = std(temp3);
display(AVEP3);
display(STDP3);
AVEP4 = mean(temp4);
STDP4 = std(temp4);
display(AVEP4);
display(STDP4);
AVEP5 = mean(temp5);
STDP5 = std(temp5);
display(AVEP5);
display(STDP5);

end