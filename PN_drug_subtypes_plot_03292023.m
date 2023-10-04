clear;
close all;
clc;

load('mycmap.mat')
load('color_value.mat')
load('color_line.mat')

dii = dir('*_AllCellTraces.mat');
M1=[];
M2=[];
Signal_high=[];
% signal_whisker_max=[];
% R_whisker=[];
% R_other=[];
% R_high_EMG=[];
% R_whisker_EMG=[];
% R_other_EMG=[];
for i=1:length(dii)
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
%     M1=[M1 R_Loco_nostim];
    mouse_str=fn(11:12);
    mouse_number_id=sscanf(mouse_str,'%f');
    fn_1=fn(1:16);
    fn_2=[fn_1 '_cell_index'];
    load([fn_2 '.mat'])
%     
    fn_3=[fn_1 '_LocoTraces'];
    load([fn_3 '.mat'])
    
     fn_4=[fn_1 '_EMGTraces'];
    load([fn_4 '.mat'])
%     M2=[M2 R_EMG_nostim];
    Signal_high_1=select_cell_sig_mean_all(:,cell_index{1});
%     R_high=[R_high R_high_1];
%      temp=Signal_high_1';
    Signal_whisker_1=select_cell_sig_mean_all(:,cell_index{2});
%     R_whisker=[R_whisker R_whisker_1];
    temp=Signal_whisker_1';
    temp=temp(:,6:53);
%     temp=temp(:,16:24);
    temp_var_cr=max((temp(:,16:24))');
    temp_var_ur=max((temp(:,25:48))');
    
    %verify the CR or UR neurons according to response index
    for m=1:length(temp_var_cr)
    response_index_1=(temp_var_cr(m) -temp_var_ur(m))/(temp_var_cr(m) +temp_var_ur(m));
    response_index(m)=response_index_1;
    if response_index_1<=-0.16
        whikser_index_1(m)=2;%UR neurons
    else
        whikser_index_1(m)=1;%CR neurons
    end
    end
    
    UR_index_2=find(whikser_index_1==2);
    whikser_index_0=cell_index{2};
    UR_index=whikser_index_0(UR_index_2);
%     response_index_mean(i)=mean(response_index);
    
    Signal_UR_select=select_cell_sig_mean_all(:,UR_index);
    clear whikser_index_1
    
%     signal_whisker_max_all(i)={temp_var};
%     signal_whisker_max(i)=mean(temp_var);
%     Singal_other_1=select_cell_sig_mean_all(:,cell_index{3});
%     R_other=[R_other R_other_1];
set(gcf,'position',[100,100,300,100*length(dii)]);hold on
   subplot(length(dii),4,1+4*(i-1))
%    Signal_whisker_select=Signal_whisker_select(6:53,:);
%    plot(mean(Signal_whisker_select,2))

plot(mean(temp',2))
%     mean_sig_all=mean(select_cell_sig_mean_all,2);
%     plot(mean_sig_all(6:53,:));
   ylim([-0.5 6])
   axis off
   hold on
   line([16,16],ylim,'color','r','linestyle',':');
   line([24,24],ylim,'color','r','linestyle',':');
   hold on
  
   subplot(length(dii),4,2+4*(i-1))
   Signal_UR_select_mean=mean(Signal_UR_select,2);
   Signal_UR_select_mean=Signal_UR_select_mean(6:53);
   Signal_UR_CR_mean(i)=mean(abs(Signal_UR_select_mean(16:24)));
   
   plot(Signal_UR_select_mean)
   ylim([-0.5 6])
    axis off
   hold on
   line([16,16],ylim,'color','r','linestyle',':');
   line([24,24],ylim,'color','r','linestyle',':');
   
   hold on
   
   subplot(length(dii),4,3+4*(i-1))
%    plot(mean(temp))
locomotion_select_mean=locomotion_select_mean-mean(locomotion_select_mean(1:10));
loco_CR_1=locomotion_select_mean(6:53);
loco_CR_mean(i)=mean(abs(loco_CR_1(16:24)));
loco_ECR_mean(i)=mean(abs(loco_CR_1(16:20)));
loco_LCR_mean(i)=mean(abs(loco_CR_1(21:24)));
plot(locomotion_select_mean(6:53));


  axis off
   hold on
   line([16,16],ylim,'color','r','linestyle',':');
   line([24,24],ylim,'color','r','linestyle',':');
%    ylim([0 2])
   hold on
   
   subplot(length(dii),4,4+4*(i-1))
%    plot(mean(temp))
    EMG_select_mean=EMG_select_mean-mean(EMG_select_mean(1:10));
    
    EMG_CR_1=EMG_select_mean(6:53);
    EMG_CR_mean(i)=mean(abs(EMG_CR_1(16:24)));
    EMG_ECR_mean(i)=mean(abs(EMG_CR_1(16:20)));
    EMG_LCR_mean(i)=mean(abs(EMG_CR_1(21:24)));

    plot(EMG_select_mean(6:53));
     hold on
   line([16,16],ylim,'color','r','linestyle',':');
   line([24,24],ylim,'color','r','linestyle',':');
  axis off
%    ylim([0 2])
   hold on
end

 figure; hold on; set(gcf,'color','w','position',[200 200 200 200]);
 normalize_loco_CR_mean=normalize(loco_CR_mean,'range');
 normalize_EMG_CR_mean=normalize(EMG_CR_mean,'range');
%  scatter(loco_CR_mean,EMG_CR_mean*1000);
%  hold on
%  mdl=fitlm(loco_CR_mean,EMG_CR_mean*1000)
 scatter(normalize_loco_CR_mean,normalize_EMG_CR_mean);
 hold on
 mdl=fitlm(normalize_loco_CR_mean,normalize_EMG_CR_mean)
plot(mdl,'Marker', 'none')
legend('hide'); title('');xlabel('');ylabel('')
% line(xlim,[0 0],'color','k','linestyle','--'); 
% % line([0 0],ylim,'color','k','linestyle','--');      
% hold on 

 figure; hold on; set(gcf,'color','w','position',[300 300 200 200]);
 
 normalize_Signal_UR_CR_mean=normalize(Signal_UR_CR_mean,'range');
%  normalize_EMG_CR_mean=normalize(EMG_CR_mean,'range');
 
 scatter(Signal_UR_CR_mean,EMG_CR_mean*1000);
 hold on
 mdl=fitlm(Signal_UR_CR_mean,EMG_CR_mean*1000)
%   scatter(normalize_Signal_UR_CR_mean,normalize_EMG_CR_mean);
%  hold on
%  mdl=fitlm(normalize_Signal_UR_CR_mean,normalize_EMG_CR_mean)
 
plot(mdl,'Marker', 'none')
legend('hide'); title('');xlabel('');ylabel('')

% %save correlation
% save(sprintf('%s',[mouse_str '_normalize_loco_CR_mean']), 'normalize_loco_CR_mean');
% save(sprintf('%s',[mouse_str '_normalize_EMG_CR_mean']), 'normalize_EMG_CR_mean');
% save(sprintf('%s',[mouse_str '_normalize_Signal_UR_CR_mean']), 'normalize_Signal_UR_CR_mean');