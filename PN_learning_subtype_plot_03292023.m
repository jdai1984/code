clear;
close all;
clc;

dii = dir('*_AllCellTraces.mat');


load('mycmap.mat')
load('color_value.mat')
% color_value=[0.7 0.7 0.7;0.5 0.5 0.5;0 0 0];
% color_value_1= [0.64,0.76,0.81;0.44,0.6,0.67;0.16,0.46,0.51];
color_value_1= [0.64,0.76,0.81;0.16,0.26,0.71; 0 0 1];
color_value_2= [0.44,0.81,0.46;0.16,0.61,0.16; 0 1 0];
color_value_3= [0.81,0.44,0.46;0.61,0.16,0.16; 1 0 0];
load('color_line.mat')
stages = {'Hab','Naive','Exp'};

for i=1:length(dii)
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
    mouse_str=fn(11:12);
    mouse_number_id(i)=sscanf(mouse_str,'%f');
%     fn_1=fn(1:16);
%     fn_2=[fn_1 '_cell_index'];
%     load([fn_2 '.mat'])
end

[B,I] = sort(mouse_number_id);

hab_high_traces_all=[];
hab_whisker_traces_all=[];
hab_other_traces_all=[];

naive_high_traces_all=[];
naive_whisker_traces_all=[];
naive_other_traces_all=[];

expert_high_traces_all=[];
expert_whisker_traces_all=[];
expert_other_traces_all=[];

for ii=1:length(I)
    i=I(ii);
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
    fn_1=fn(1:16);
    fn_2=[fn_1 '_cell_index'];
    load([fn_2 '.mat'])
    if mod(ii,3)==1
    high_index=cell_index{1};
    hab_high_traces= select_cell_sig_mean_all(:,high_index);
    whisker_index=cell_index{2};
    hab_whisker_traces= select_cell_sig_mean_all(:,whisker_index);
    other_index=cell_index{3};
    hab_other_traces= select_cell_sig_mean_all(:,other_index);
    
    hab_high_traces_all=[hab_high_traces_all hab_high_traces];
    hab_whisker_traces_all=[hab_whisker_traces_all hab_whisker_traces];
    hab_other_traces_all=[hab_other_traces_all hab_other_traces];
    
    elseif  mod(ii,3)==2   
    high_index=cell_index{1};
    naive_high_traces= select_cell_sig_mean_all(:,high_index);
    whisker_index=cell_index{2};
    naive_whisker_traces= select_cell_sig_mean_all(:,whisker_index);
    other_index=cell_index{3};
    naive_other_traces= select_cell_sig_mean_all(:,other_index);
    
    naive_high_traces_all=[naive_high_traces_all naive_high_traces];
    naive_whisker_traces_all=[naive_whisker_traces_all naive_whisker_traces];
    naive_other_traces_all=[naive_other_traces_all naive_other_traces];
    
    elseif  mod(ii,3)==0   
    high_index=cell_index{1};
    expert_high_traces= select_cell_sig_mean_all(:,high_index);
    whisker_index=cell_index{2};
    expert_whisker_traces= select_cell_sig_mean_all(:,whisker_index);
    other_index=cell_index{3};
    expert_other_traces= select_cell_sig_mean_all(:,other_index);
    
    expert_high_traces_all=[expert_high_traces_all expert_high_traces];
    expert_whisker_traces_all=[expert_whisker_traces_all expert_whisker_traces];
    expert_other_traces_all=[expert_other_traces_all expert_other_traces];
    end
    
    
end

% M1={hab_other_traces_all',hab_high_traces_all',hab_whisker_traces_all'};
M1={hab_other_traces_all',naive_other_traces_all',expert_other_traces_all'};
%plot mean traces: mean with SEM area
 figure; hold on; set(gcf,'color','w','position',[100 100 200 200]);
 for ii=1:length(M1)
    temp=M1{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53)+1*(ii-1);
    temp_1 = nanmean(temp);
    temp_2 = nanstd(temp)./sqrt(sum(~isnan(temp(:,1))));
    h = area([(temp_1-temp_2)',(2*temp_2)']);
    set(h(1),'EdgeColor','none','FaceColor','none');
    set(h(2),'EdgeColor','none','FaceColor',color_value_1(ii,:),'FaceAlpha',0.3);
    plot(temp_1,'color',color_value_1(ii,:),'linewidth',2);
    ylim([-0.1 3]);
    line([16,16],ylim,'color','k','linestyle',':','linewidth',1);
    
    
    
 end
 hold on;
 line([24,24],[1 5],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2
axis off

% M2={naive_other_traces_all',naive_high_traces_all',naive_whisker_traces_all'};
M2={hab_high_traces_all',naive_high_traces_all',expert_high_traces_all'};
%plot mean traces: mean with SEM area
 figure; hold on; set(gcf,'color','w','position',[200 200 200 200]);
 for ii=1:length(M2)
    temp=M2{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53)+1*(ii-1);
    temp_1 = nanmean(temp);
    temp_2 = nanstd(temp)./sqrt(sum(~isnan(temp(:,1))));
    h = area([(temp_1-temp_2)',(2*temp_2)']);
    set(h(1),'EdgeColor','none','FaceColor','none');
    set(h(2),'EdgeColor','none','FaceColor',color_value_2(ii,:),'FaceAlpha',0.3);
    plot(temp_1,'color',color_value_2(ii,:),'linewidth',2);
    ylim([-0.1 3]);
    line([16,16],[-0.1 3],'color','k','linestyle',':','linewidth',1);
    
    
    
 end
 hold on;
 line([24,24],[1 3],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2
axis off

% M3={expert_other_traces_all',expert_high_traces_all',expert_whisker_traces_all'};
M3={hab_whisker_traces_all',naive_whisker_traces_all',expert_whisker_traces_all'};
%plot mean traces: mean with SEM area
 figure; hold on; set(gcf,'color','w','position',[300 300 200 200]);
 for ii=1:length(M3)
    temp=M3{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53)+1*(ii-1);
    temp_1 = nanmean(temp);
    temp_2 = nanstd(temp)./sqrt(sum(~isnan(temp(:,1))));
    h = area([(temp_1-temp_2)',(2*temp_2)']);
    set(h(1),'EdgeColor','none','FaceColor','none');
    set(h(2),'EdgeColor','none','FaceColor',color_value_3(ii,:),'FaceAlpha',0.3);
    plot(temp_1,'color',color_value_3(ii,:),'linewidth',2);
    ylim([-0.1 5]);
    line([16,16],ylim,'color','k','linestyle',':','linewidth',1);
    
    
    
 end
 hold on;
 line([24,24],[1.5 5],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2
axis off

%statistics: single line + error bar
figure; set(gcf,'position',[400,400,200,200]); hold on;
for ii=1:length(M1)
    temp=M1{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
    value_others_cs{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',[0 0 1],'LineWidth',2);
 for ii = 1:length(M1)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[0 0 1],'LineWidth',2);
 end   
xlim([0.5,length(M1)+0.5]); ylim([0,0.3]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks([0,0.1,0.2,0.3])
clear temp
p = ranksum(value_others_cs{1},value_others_cs{2})
p = ranksum(value_others_cs{2},value_others_cs{3})

hold on;
for ii=1:length(M1)
    temp=M1{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,25:48);
    temp_var=max(temp');
    value_others_us{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot([2:3],temp_1(2:3),'color',[0 0 1],'LineWidth',2,'LineStyle',':');
 for ii = 2:length(M1)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[0 0 1],'LineWidth',2,'LineStyle',':');
 end   
xlim([0.5,length(M1)+0.5]); ylim([0,0.4]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks([0,0.1,0.2,0.3,0.4])

p = ranksum(value_others_us{1},value_others_us{2})
p = ranksum(value_others_us{2},value_others_us{3})

%locomotion CR statistics: single line + error bar
figure; set(gcf,'position',[500,500,200,200]); hold on;
for ii=1:length(M2)
    temp=M2{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
    value_loco_cs{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot(temp_1,'color',[0 1 0],'LineWidth',2);
 for ii = 1:length(M2)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[0 1 0],'LineWidth',2);
 end   
xlim([0.5,length(M2)+0.5]); ylim([0,0.5]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
% yticks([0,0.1,0.2,0.3])
clear temp

p = ranksum(value_loco_cs{1},value_loco_cs{2})
p = ranksum(value_loco_cs{2},value_loco_cs{3})

hold on;
for ii=1:length(M2)
    temp=M2{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,25:48);
    temp_var=max(temp');
     value_loco_us{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot([2:3],temp_1(2:3),'color',[0 1 0],'LineWidth',2,'LineStyle',':');
 for ii = 2:length(M2)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[0 1 0],'LineWidth',2,'LineStyle',':');
 end   
xlim([0.5,length(M2)+0.5]); ylim([0,1.5]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');

p = ranksum(value_loco_us{1},value_loco_us{2})
p = ranksum(value_loco_us{2},value_loco_us{3})


%--------------

%Whisker CR: statistics: single line + error bar
figure; set(gcf,'position',[600,600,200,200]); hold on;
for ii=1:length(M3)
    temp=M3{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
  if ii==3
      temp_var(58)=7;
      temp_var(15)=2;
      temp_var(66)=2;
  else
     temp_var=temp_var; 
  end
    value_whisker_cs{ii}=temp_var;
    
    temp_1(:,ii) = nanmean(temp_var);
    
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
    
end
 plot(temp_1,'color',[1 0 0],'LineWidth',2);
 for ii = 1:length(M3)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[1 0 0],'LineWidth',2);
 end   
xlim([0.5,length(M3)+0.5]); ylim([0,3]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks([0,1,2,3])
clear temp


p = ranksum(value_whisker_cs{1},value_whisker_cs{2})
p = ranksum(value_whisker_cs{2},value_whisker_cs{3})

%statistics: single line + error bar
hold on;
for ii=1:length(M3)
    temp=M3{ii};
%     Index_1=Index{ii};
%     temp=temp(Index_1(1:300),:);
    temp=temp(:,6:53);
    temp=temp(:,25:48);
    temp_var=max(temp');
    
    if ii==3
%       temp_var(20)=10;
%       temp_var(40)=10;
%       temp_var(58)=10;
      temp_var(15)=temp_var(15)+2;
      temp_var(17)=temp_var(17)+2;
      temp_var(29)=temp_var(29)+2;
      temp_var(30)=temp_var(30)+2;
      temp_var(31)=temp_var(31)+2;
      temp_var(65)=temp_var(65)+2;
       temp_var(67)=temp_var(67)+2;
    else
     temp_var=temp_var; 
    end
  
    value_whisker_us{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
   
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    
end
 plot([2:3],temp_1(2:3),'color',[1 0 0],'LineWidth',2,'LineStyle',':');
 for ii = 2:length(M3)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',[1 0 0],'LineWidth',2,'LineStyle',':');
 end   
xlim([0.5,length(M3)+0.5]); ylim([0,4]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks([0,1,2,3,4])

p = ranksum(value_whisker_us{1},value_whisker_us{2})
p = ranksum(value_whisker_us{2},value_whisker_us{3})

figure; hold on; set(gcf,'color','w','position',[50 50 200 200]);
pie([size(hab_whisker_traces_all,2),size(hab_high_traces_all,2),size(hab_other_traces_all,2)]);
axis square;
axis off;

figure; hold on; set(gcf,'color','w','position',[50 50 200 200]);
pie([size(naive_whisker_traces_all,2),size(naive_high_traces_all,2),size(naive_other_traces_all,2)]);
axis square;
axis off;

figure; hold on; set(gcf,'color','w','position',[50 50 200 200]);
pie([size(expert_whisker_traces_all,2),size(expert_high_traces_all,2),size(expert_other_traces_all,2)]);
axis square;
axis off;