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

% CR_index_all={[17,31,21]};
% rename the files according the sequece of CR_index_all
%or re-sequence the CR_index_all
% CR_index_all={[2,16],[1,6],[4,10]...%44
%               [],[42,56,60],[51,53,54],...%45
%               [],[23,20,12,33,25,19,36],[19,24,44,29,38,39,35],... %num 49 mouse
%               [17,18,19,23,24,25,28,31,32],[1,17,28,30,4,31,21,16,24],[1,3,45,10,42,47,46,6,25],...%num57
%               [],[4,14,18,11,7,24,38,37,1],[6,22,24,11,5,16,10,17,3],...%num 63 mouse
%               [11,12,13,14,17,18,21,30,32,64,75,8],[11,12,13,14,17,20,21,30,32,62,64,67],[11,120,121,23,125,123,124,30,57,50,69,126],...%num 35
%               [],[],[],...%num 23 no whisker cells
%               [],[44,53],[6,66],...%num 22 mouse
%               [31,97],[94,98],[83,91],... %num 21
%               };
          
CR_index_all={[17,31,21],[12,25,33],[44,38,29],... %num 49 mouse
              [17,18,19,23,24,25,28,31,32],[1,17,28,30,4,31,21,16,24],[1,3,45,10,42,47,46,6,25],...%num57
              [],[4,14,18,11,7,24,38,37,1],[6,22,24,11,5,16,10,17,3],...%num 63 mouse
              [11,12,13,14,17,18,21,30,32,64,75,8],[11,12,13,14,17,20,21,30,32,62,64,67],[11,120,121,23,125,123,124,30,57,50,69,126],...%num 35
              [],[],[],...%num 23 no whisker cells
              [],[44,53],[6,66],...%num 22 mouse
              [41,92,31,97,98,93,94],[54,93,94,98,100,111,121],[78,96,83,91,100,93,58],... %num 21
              };
% UR_index_all={[7,45,30,23,44,27,25,49,48,47,46]};

for i=1:length(dii)
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
    mouse_str=fn(11:12);
    mouse_number_id(i)=sscanf(mouse_str,'%f');

end

[B,I] = sort(mouse_number_id);

% hab_high_traces_all=[];
hab_whisker_traces_all=[];
hab_whisker_CR_traces_all=[];
hab_whisker_CR_max_all=[];
hab_whisker_UR_traces_all=[];
% hab_other_traces_all=[];

% naive_high_traces_all=[];
naive_whisker_traces_all=[];
naive_whisker_CR_traces_all=[];
naive_whisker_UR_traces_all=[];
% naive_other_traces_all=[];

% expert_high_traces_all=[];
expert_whisker_traces_all=[];
expert_whisker_CR_traces_all=[];
expert_whisker_UR_traces_all=[];
% expert_other_traces_all=[];

for ii=1:length(I)
    i=I(ii);
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
    fn_1=fn(1:16);
    fn_2=[fn_1 '_cell_index'];
    load([fn_2 '.mat'])
    if mod(ii,3)==1
   %all whisker cells in hab is the CR neurons
   if isempty(CR_index_all{i}) 
    hab_whisker_index=cell_index{2};
   else
    hab_whisker_index=CR_index_all{i};
   end
    hab_whisker_traces= select_cell_sig_mean_all(:,hab_whisker_index);
    hab_whisker_CR_traces_1=hab_whisker_traces;
    
    hab_whisker_CR_traces_2=hab_whisker_CR_traces_1';
    hab_whisker_CR_traces_3=hab_whisker_CR_traces_2(:,6:53);
    hab_whisker_CR_max_1=max((hab_whisker_CR_traces_3(:,16:24))');

    
    hab_whisker_CR_traces_all=[hab_whisker_CR_traces_all hab_whisker_CR_traces_1];
    
     % get UR cells:random select 15 non-whisker cells
   All_cell_index=1:1:size(select_cell_sig_mean_all,2);
  
   UR_index_hab_1=setdiff(All_cell_index,hab_whisker_index);
   UR_index_hab=randsample(UR_index_hab_1,15);
   
   
   hab_whisker_UR_traces_1=select_cell_sig_mean_all(:,UR_index_hab);
   hab_whisker_UR_traces_all=[hab_whisker_UR_traces_all hab_whisker_UR_traces_1];
    
    elseif  mod(ii,3)==2   
    
   naive_whisker_index=cell_index{2};
   naive_whisker_traces= select_cell_sig_mean_all(:,naive_whisker_index);
   naive_whisker_all_traces_2=naive_whisker_traces';
   naive_whisker_all_traces_3=naive_whisker_all_traces_2(:,6:53);
   naive_whisker_all_max=max((naive_whisker_all_traces_3(:,16:24))');
   
   CR_index_naive_2=CR_index_all{i};
   
   naive_whisker_CR_traces_1=select_cell_sig_mean_all(:,CR_index_naive_2);
   naive_whisker_CR_traces_2=naive_whisker_CR_traces_1';
   naive_whisker_CR_traces_3=naive_whisker_CR_traces_2(:,6:53);
   naive_whisker_CR_max=max((naive_whisker_CR_traces_3(:,16:24))');
    
   naive_whisker_CR_traces_all=[naive_whisker_CR_traces_all naive_whisker_CR_traces_1];
% get UR cells
   naive_same_index=intersect(CR_index_naive_2,naive_whisker_index);
   UR_index_naive=setdiff(naive_whisker_index,naive_same_index);
   naive_whisker_UR_traces_1=select_cell_sig_mean_all(:,UR_index_naive);
   naive_whisker_UR_traces_all=[naive_whisker_UR_traces_all naive_whisker_UR_traces_1];
    
    elseif  mod(ii,3)==0   
   
   expert_whisker_index=cell_index{2};
   expert_whisker_traces= select_cell_sig_mean_all(:,expert_whisker_index);
   expert_whisker_all_traces_2=expert_whisker_traces';
   expert_whisker_all_traces_3=expert_whisker_all_traces_2(:,6:53);
   expert_whisker_all_max=max((expert_whisker_all_traces_3(:,16:24))');
   
   
   CR_index_expert_2=CR_index_all{i};
   
   expert_whisker_CR_traces_1=select_cell_sig_mean_all(:,CR_index_expert_2);
   expert_whisker_CR_traces_2=expert_whisker_CR_traces_1';
   expert_whisker_CR_traces_3=expert_whisker_CR_traces_2(:,6:53);
   expert_whisker_CR_max=max((expert_whisker_CR_traces_3(:,16:24))');
   
   expert_whisker_CR_traces_all=[expert_whisker_CR_traces_all expert_whisker_CR_traces_1];
   
    % get UR cells
   expert_same_index=intersect(CR_index_expert_2,expert_whisker_index);
   UR_index_expert=setdiff(expert_whisker_index,expert_same_index);
   expert_whisker_UR_traces_1=select_cell_sig_mean_all(:,UR_index_expert);
   expert_whisker_UR_traces_all=[expert_whisker_UR_traces_all expert_whisker_UR_traces_1];
    
    
    end
    
    
end


M1={hab_whisker_CR_traces_all',naive_whisker_CR_traces_all',expert_whisker_CR_traces_all'};
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
    ylim([-0.1 4]);
    line([16,16],ylim,'color','k','linestyle',':','linewidth',1);
    
    
    
 end
 hold on;
 line([24,24],[1 4],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2


% M2={naive_other_traces_all',naive_high_traces_all',naive_whisker_traces_all'};
M2={hab_whisker_UR_traces_all',naive_whisker_UR_traces_all',expert_whisker_UR_traces_all'};
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
    ylim([-0.1 6]);
    line([16,16],ylim,'color','k','linestyle',':','linewidth',1);
    
    
    
 end
 hold on;
 line([24,24],[1 6],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
clear temp_1 temp_2
