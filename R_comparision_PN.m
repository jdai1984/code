clear;
close all;
clc;
load('mycmap.mat')
load('color_value.mat')
color_value=[0.7 0.7 0.7;0.5 0.5 0.5;0 0 0];
load('color_line.mat')


load('R_Loco_PN_Hab.mat')
M10=M1;
clear M1
load('R_Loco_PN_Naive.mat')
M11=M1;
clear M1
load('R_Loco_PN_Expert.mat')
M12=M1;
clear M1

load('R_EMG_PN_Hab.mat')
M20=M2;
clear M2
load('R_EMG_PN_Naive.mat')
M21=M2;
clear M2
load('R_EMG_PN_Expert.mat')
M22=M2;
clear M2



M1={M10 M11 M12};
M2={M20 M21 M22};

p = ranksum(M1{1},M1{2})
p = ranksum(M1{2},M1{3})

p = ranksum(M2{1},M2{2})
p = ranksum(M2{2},M2{3})


stages = {'Hab','Naive','Exp'};
figure; set(gcf,'position',[200,200,200,200]); hold on;
for ii=1:length(M1)
    temp=M1{ii};
    temp_var=temp;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',color_value(3,:),'LineWidth',2);
 for ii = 1:length(M1)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(3,:),'LineWidth',2);
 end   
 
 for ii=1:length(M2)
    temp=M2{ii};
    temp_var=temp;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',color_value(2,:),'LineWidth',2);
 for ii = 1:length(M2)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',2);
 end   
xlim([0.5,length(M1)+0.5]); ylim([0,0.2]); xticks([1:4]); xticklabels(stages); ylabel('Correlation');