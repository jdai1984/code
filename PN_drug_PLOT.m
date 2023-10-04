clear;
close all;
clc;
load('mycmap.mat')
load('color_value.mat')
color_value=[0.7 0.7 0.7;0.5 0.5 0.5;0 0 0];
load('color_line.mat')
%Saline
load('12032019_021_001_AllCellTraces')
M11=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('12032019_021_002_AllCellTraces')
M12=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11142019_022_014_AllCellTraces')
M13=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11142019_022_015_AllCellTraces')
M14=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11132019_023_010_AllCellTraces')
M15=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11132019_023_011_AllCellTraces')
M16=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('09302020_035_004_AllCellTraces')
M17=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_001_AllCellTraces')
M18=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_002_AllCellTraces')
M19=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_003_AllCellTraces')
M110=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_004_AllCellTraces')
M111=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_005_AllCellTraces')
M112=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03032021_045_006_AllCellTraces')
M113=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_004_AllCellTraces')
M114=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_005_AllCellTraces')
M115=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_006_AllCellTraces')
M116=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_007_AllCellTraces')
M117=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_008_AllCellTraces')
M118=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('03252021_049_009_AllCellTraces')
M119=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_057_000_AllCellTraces')
M120=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_057_001_AllCellTraces')
M121=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_057_002_AllCellTraces')
M122=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_057_003_AllCellTraces')
M123=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

% M1=[M11   M11 M12 M13 M14 M15 M16 M17 M18 M19 M110 M111 M112 M113 M114 ...
%     M115 M116 M117 M118 M119 M120 M121 M122 M123];
% M1=[M11 M12 M13 M14 M15 M16 M17];
M1=[M11 M12 M13 M14 M15 M16 M17 M114 M115 M116 M117 M118 M119 M120 M121 M122 M123];
% Drug
load('02092021_044_008_AllCellTraces.mat')
M21=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('02092021_044_009_AllCellTraces.mat')
M22=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('02092021_044_010_AllCellTraces.mat')
M23=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('02092021_044_011_AllCellTraces.mat')
M24=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('02092021_044_012_AllCellTraces.mat')
M25=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('02092021_044_013_AllCellTraces.mat')
M26=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_063_000_AllCellTraces.mat')
M27=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_063_001_AllCellTraces.mat')
M28=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_063_002_AllCellTraces.mat')
M29=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('06162021_063_003_AllCellTraces.mat')
M210=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('08102021_067_000_AllCellTraces.mat')
M211=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('08102021_067_001_AllCellTraces.mat')
M212=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('08102021_067_002_AllCellTraces.mat')
M213=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('08102021_067_003_AllCellTraces.mat')
M214=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11092021_084_000_AllCellTraces.mat')
M215=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

load('11092021_084_001_AllCellTraces.mat')
M216=select_cell_sig_mean_all;
clear select_cell_sig_mean_all

M2=[ M21 M22 M23 M24 M25 M26 M27 M28 M29 M210 M211 M212 M213 M214 M215 M216];
% M2=[M21 M27 M28 M29 M210 M211 M212 M213 M215 M216];
% M2=[ M21 M22 M23 M24 M25 M211 M212 M213 M215 M216];


M={M1',M2'};

%plot heatmap all cell traces
figure; hold on; set(gcf,'color','w','position',[100 50 500 300]);
stages = {'Saline','Drug'};

for ii=1:length(M)
subplot(1,4,ii)
temp=M{ii};
temp=temp(:,6:53);
[~,I] = sort(sum(temp(:,16:32),2),'descend');
Index{ii}=I;
    temp = temp(I,:);
    imagesc(temp,[-2,10]); 
colormap(mycmap);
line([16,16],ylim,'color','k','linestyle',':');
if ii>=1
line([24,24],ylim,'color','k','linestyle',':');
end
if ii==1
 ylabel('# of cells');
end
 xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
yticks([50,100,150,200,250,300,350,400,450,500]);
 if ii>1
     yticklabels({})
 end
     
 
 
 title(stages{ii});
end
 
 %plot mean traces: mean with SEM area
 figure; hold on; set(gcf,'color','w','position',[200 200 200 200]);
 for ii=1:length(M)
    temp=M{ii};
    Index_1=Index{ii};
    temp=temp(Index_1(1:end),:);
    temp=temp(:,6:53);
    temp_1 = nanmean(temp);
    temp_2 = nanstd(temp)./sqrt(sum(~isnan(temp(:,1))));
    h = area([(temp_1-temp_2)',(2*temp_2)']);
    set(h(1),'EdgeColor','none','FaceColor','none');
    set(h(2),'EdgeColor','none','FaceColor',color_value(ii,:),'FaceAlpha',0.3);
    plot(temp_1,'color',color_value(ii+1,:),'linewidth',2);
    ylim([-0.1 2]);
    line([16,16],ylim,'color','k','linestyle',':','linewidth',1);
    line([24,24],ylim,'color','k','linestyle',':','linewidth',1);
 end
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2

%statistics: single line + error bar
figure; set(gcf,'position',[300,300,200,200]); hold on;
for ii=1:length(M)
    temp=M{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:400),:);
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',color_value(2,:),'LineWidth',2);
 for ii = 1:length(M)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',2);
 end   
xlim([0.5,length(M)+0.5]); ylim([0,2]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');

% calculate US
clear temp
for ii=1:length(M)
    temp=M{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,29:32);
    temp_var=max(temp');
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',color_value(3,:),'LineWidth',2);

 for ii = 1:length(M)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(3,:),'LineWidth',2);
 end   
xlim([0.5,length(M)+0.5]); ylim([0,2]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');