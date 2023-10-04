%Get signal/EMG/locomotion traces/correlation of all cells, all trials
clear;
close all;
clc;
fn='03252021_049_003'; % should be changed when analyze different file
load('-mat',fn);
IndexOfFrame_1=info.frame;
TrialNumber=20;
TrialNoCSOrUS=[7,13,9,6];
TrialIndexAll=1:1:TrialNumber;
TrialIndex=setdiff(TrialIndexAll,TrialNoCSOrUS);
TrialIndex_NoCS=TrialNoCSOrUS(1:2);
TrialIndex_NoUS=TrialNoCSOrUS(3:4);

for i=1:TrialNumber*2
   IndexOfFrame_2= IndexOfFrame_1(1+50*(i-1));
   IndexOfFrame(i)=IndexOfFrame_2;
end 
IndexOfFrame_3=IndexOfFrame(1:2:end);

fn_4=[fn '_quadrature'];
load('-mat',fn_4);
angular_speed=diff(quad_data);%calculate the absolute speed
angular_speed=double([0 angular_speed]);

fn_2='_rigid.signals';
fn_3=[fn fn_2];
load('-mat',fn_3);

fn_7=[fn '_EMG_extract'];
load('-mat',fn_7);

size_sig=size(sig);
CellNumber=size_sig(2);
Res_Cell_all=1:size_sig(2);

EMG_extract_1=zeros(size_sig(1),1);
EMG_extract_1(IndexOfFrame(1)-100:IndexOfFrame(end)+200-1)=EMG_extract(1:end);

%Get the trials: CS-US,CS-,US-

for n=1:CellNumber
    select_cell_sig_0=sig(:,n);
    select_cell_sig=(select_cell_sig_0-min(select_cell_sig_0(1:200)))/abs(min(select_cell_sig_0(1:200)));
%     select_cell_sig=select_cell_sig-mean(select_cell_sig(1:10))/abs(mean(select_cell_sig(1:10)));
    for m=1:length(TrialIndex)
    i=TrialIndex(m);
    select_cell_sig_1=select_cell_sig(IndexOfFrame_3(i)-20:IndexOfFrame_3(i)+139);%from -10/69 to -20/139
    select_cell_sig_3(:,m)=select_cell_sig_1;
    
    locomotion_select_1=angular_speed(IndexOfFrame_3(i)-20:IndexOfFrame_3(i)+139);
    locomotion_select_2(:,m)=locomotion_select_1;
    EMG_select_1=EMG_extract_1(IndexOfFrame_3(i)-20:IndexOfFrame_3(i)+139);
    EMG_select_2(:,m)=EMG_select_1;
    
    
    %calculate amplitude of each trial 
    select_cell_sig_eachtrail_1=select_cell_sig_1(18:52);%from 8:42 to 18:52
    select_cell_sig_eachtrail_2=select_cell_sig_eachtrail_1-min(select_cell_sig_eachtrail_1(1:3));
    select_cell_sig_eachtrail_max_1=max(select_cell_sig_eachtrail_2(3:35));
    select_cell_sig_eachtrail_all_max(n,m)= select_cell_sig_eachtrail_max_1;
    select_cell_sig_eachtrail_max(:,m)= select_cell_sig_eachtrail_max_1;
    
        
    %calculate Loco
    loco_norm=normalize(angular_speed);
    loco_norm_base_1=loco_norm(IndexOfFrame_3(i)-8:IndexOfFrame_3(i)-1);
    loco_norm_cs_1=loco_norm(IndexOfFrame_3(i):IndexOfFrame_3(i)+7);
    loco_norm_us_1=loco_norm(IndexOfFrame_3(i)+8:IndexOfFrame_3(i)+15);
    loco_norm_base(:,m)=mean(abs(loco_norm_base_1));
    loco_norm_cs(:,m)=mean(abs(loco_norm_cs_1));
    loco_norm_us(:,m)=mean(abs(loco_norm_us_1));
    
    %calculate EMG
    EMG_norm=normalize(EMG_extract_1);
    EMG_norm_base_1=EMG_norm(IndexOfFrame_3(i)-8:IndexOfFrame_3(i)-1);
    EMG_norm_cs_1=EMG_norm(IndexOfFrame_3(i):IndexOfFrame_3(i)+7);
    EMG_norm_us_1=EMG_norm(IndexOfFrame_3(i)+8:IndexOfFrame_3(i)+15);
    EMG_norm_base(:,m)=mean(abs(EMG_norm_base_1));
    EMG_norm_cs(:,m)=mean(abs(EMG_norm_cs_1));
    EMG_norm_us(:,m)=mean(abs(EMG_norm_us_1));
    
    end
    Cell_signal_alltrials{n}=select_cell_sig_3;
    %
    select_cell_sig_eachtrail_max_reshape_1=reshape(select_cell_sig_eachtrail_max,4,[]);
    select_cell_sig_eachtrail_max_reshape_mean=mean(select_cell_sig_eachtrail_max_reshape_1);
    select_cell_sig_eachtrail_max_reshape_mean_allcells(:,n)=select_cell_sig_eachtrail_max_reshape_mean;
    Response_integral=select_cell_sig_eachtrail_max_reshape_mean_allcells;
    
    for a=1:length(TrialIndex_NoCS)
    b=TrialIndex_NoCS(a);
    select_cell_sig_nocs_1=select_cell_sig(IndexOfFrame_3(b)-20:IndexOfFrame_3(b)+139);
%     select_cell_sig_nocs_2=(select_cell_sig_nocs_1-mean(select_cell_sig_nocs_1(1:10)))/abs(mean(select_cell_sig_nocs_1(1:10)));
    select_cell_sig_nocs_3(:,a)=select_cell_sig_nocs_1;
    locomotion_select_nocs_1=angular_speed(IndexOfFrame_3(b)-20:IndexOfFrame_3(b)+139);
    locomotion_select_nocs_2(:,a)=locomotion_select_nocs_1;
    EMG_select_nocs_1=EMG_extract_1(IndexOfFrame_3(b)-20:IndexOfFrame_3(b)+139);
    EMG_select_nocs_2(:,a)=EMG_select_nocs_1;
    end
    
      for c=1:length(TrialIndex_NoUS)
    d=TrialIndex_NoUS(c);
    select_cell_sig_nous_1=select_cell_sig(IndexOfFrame_3(d)-20:IndexOfFrame_3(d)+139);
%     select_cell_sig_nous_2=(select_cell_sig_nous_1-mean(select_cell_sig_nous_1(1:10)))/abs(mean(select_cell_sig_nous_1(1:10)));
    select_cell_sig_nous_3(:,c)=select_cell_sig_nous_1;
    locomotion_select_nous_1=angular_speed(IndexOfFrame_3(d)-20:IndexOfFrame_3(d)+139);
    locomotion_select_nous_2(:,c)=locomotion_select_nous_1;
    EMG_select_nous_1=EMG_extract_1(IndexOfFrame_3(d)-20:IndexOfFrame_3(d)+139);
    EMG_select_nous_2(:,c)=EMG_select_nous_1;
    end
%     
    select_cell_sig_mean_1=mean(select_cell_sig_3,2);
    select_cell_sig_mean_all(:,n)= select_cell_sig_mean_1-mean(select_cell_sig_mean_1(1:20));
    
    select_cell_sig_mean_max_1=max(select_cell_sig_mean_1(21:40));
%     select_cell_sig_mean_all(:,n)=select_cell_sig_mean_1;
    select_cell_sig_mean_max(:,n)=select_cell_sig_mean_max_1;
    
    select_cell_sig_mean_min_1=min(select_cell_sig_mean_1(21:40));
    select_cell_sig_mean_min(:,n)=select_cell_sig_mean_min_1;
    
    if abs(select_cell_sig_mean_max_1)>abs(select_cell_sig_mean_min_1)
       select_cell_positive_negative_1(:,n)=1;
    else
       select_cell_positive_negative_1(:,n)=0;
    end
    
    locomotion_select_mean=mean(locomotion_select_2,2);
    EMG_select_mean=mean(EMG_select_2,2);
    
    select_cell_sig_nocs_mean_1=mean(select_cell_sig_nocs_3,2);
    select_cell_sig_nocs_max_1=max(select_cell_sig_nocs_mean_1(21:40));
    select_cell_sig_nocs_max_all(:,n)=select_cell_sig_nocs_max_1;
    select_cell_sig_nocs_mean_all(:,n)=select_cell_sig_nocs_mean_1;
    select_cell_sig_nocs_min_1=min(select_cell_sig_nocs_mean_1(21:40));
    select_cell_sig_nocs_min_all(:,n)=select_cell_sig_nocs_min_1;
    
    select_cell_sig_nous_mean_1=mean(select_cell_sig_nous_3,2);
    select_cell_sig_nous_max_1=max(select_cell_sig_nous_mean_1(21:40));
    select_cell_sig_nous_max_all(:,n)=select_cell_sig_nous_max_1;
    select_cell_sig_nous_mean_all(:,n)=select_cell_sig_nous_mean_1;
    select_cell_sig_nous_min_1=min(select_cell_sig_nous_mean_1(21:40));
    select_cell_sig_nous_min_all(:,n)=select_cell_sig_nous_min_1;
 %Calculate Amplitude
 
 %calculate adaption index (mean amplitude of first 3 trials-mean amplitude of last 3 trials )
 %response integral
    
    
    
end
loco_norm_all_mean=[mean(loco_norm_base),mean(loco_norm_cs),mean(loco_norm_us)];
EMG_norm_all_mean=[mean(EMG_norm_base),mean(EMG_norm_cs),mean(EMG_norm_us)];

% Classification of cells

%%%methods1
Res_Trial_1=0;
for j=1:CellNumber
    spks_1=spks(:,j);
    for k=1:length(TrialIndex)
    Trial_position=IndexOfFrame_3(k);
    spks_afterStimulation_1=spks_1(Trial_position:Trial_position+16); %find whether this is any spks 1s after stimulation
    Notzero=nnz(spks_afterStimulation_1);
        if Notzero~=0
            Res_Trial_1=Res_Trial_1+1; % Count the response trial: there is spks 1s after stimulation
            ResTrailNum(j,k)=k;
        end
    
    end
    
    if Res_Trial_1>12 %response tiral number >5, we would count this cell
       Res_Cell_Whisker_1=j;
    else
        Res_Cell_Whisker_1=0;
    end
     Res_Cell_Whisker_2(:,j)=Res_Cell_Whisker_1; 
     Res_Trial_1=0;
end
Res_Cell_Whisker=find(Res_Cell_Whisker_2~=0);

% % methods 2: large than 3*STD in baseline
% Res_Trial_1=0;
% for j=1:CellNumber
%     sig_0=sig(:,j);
%     sig_1=(sig_0-min(sig_0(1:200)))/abs(min(sig_0(1:200)));
%     for k=1:length(TrialIndex)
%     Trial_position=IndexOfFrame_3(k);
%     sig_afterStimulation_1=sig_1(Trial_position:Trial_position+16); %find whether this is any spks 1s after stimulation
%     sig_baseline_1=sig_1(Trial_position-4:Trial_position-1);
%     sig_baseline_std=std(sig_baseline_1);
%         if mean(sig_afterStimulation_1-mean(sig_baseline_1))>=3*sig_baseline_std
%             Res_Trial_1=Res_Trial_1+1; % Count the response trial: there is spks 1s after stimulation
%             ResTrailNum(j,k)=k;
%         end
%     
%     end
%     
%     if Res_Trial_1>=10 %response tiral number >5, we would count this cell
%        Res_Cell_Whisker_1=j;
%     else
%         Res_Cell_Whisker_1=0;
%     end
%      Res_Cell_Whisker_2(:,j)=Res_Cell_Whisker_1; 
%      Res_Trial_1=0;
% end
% Res_Cell_Whisker=find(Res_Cell_Whisker_2~=0);

% get correlation
clear i
clear j

for i=1:CellNumber
    
    sig_read_0=sig(:,i);
    sig_read_1=(sig_read_0-mean(sig_read_0(1:200)))/abs(mean(sig_read_0(1:200)));
    sig_read_2=sig_read_1;
    sig_read_3=sig_read_1;
    sig_read_4=sig_read_1;
    CellSig_2=sig_read_1(IndexOfFrame(1)-100:IndexOfFrame(end)+200);
for j=1:length(IndexOfFrame_3)
    
    sig_read_2(IndexOfFrame_3(j):IndexOfFrame_3(j)+8)=2*max(sig_read_1);
    sig_read_3(IndexOfFrame_3(j)+9:IndexOfFrame_3(j)+17)=2*max(sig_read_1);
    sig_read_4(IndexOfFrame_3(j):IndexOfFrame_3(j)+160)=2*max(sig_read_1);%remove 10s after CS onset
    
%     sig_read_nostim=sig_read_1(find(sig_read_2~=2*max(sig_read_1)));
%     loco_nostim=angular_speed(find(sig_read_2~=2*max(sig_read_1)));
%     EMG_nostim=EMG_extract_1(find(sig_read_2~=2*max(sig_read_1)));
    
    sig_read_nostim=sig_read_1(find(sig_read_4~=2*max(sig_read_1)));
    loco_nostim=angular_speed(find(sig_read_4~=2*max(sig_read_1)));
    EMG_nostim=EMG_extract_1(find(sig_read_4~=2*max(sig_read_1)));

    sig_read_onlystim=sig_read_1(find(sig_read_2==2*max(sig_read_1)));
    loco_onlystim=angular_speed(find(sig_read_2==2*max(sig_read_1)));
    EMG_onlystim=EMG_extract_1(find(sig_read_2==2*max(sig_read_1)));

    sig_read_onlystim_us=sig_read_1(find(sig_read_3==2*max(sig_read_1)));
    loco_onlystim_us=angular_speed(find(sig_read_3==2*max(sig_read_1)));
    EMG_onlystim_us=EMG_extract_1(find(sig_read_3==2*max(sig_read_1)));
    
    
end
 
    R_nostim_1=corrcoef(loco_nostim,sig_read_nostim);
    R_Loco_nostim(i)=R_nostim_1(1,2);
    
    R_onlystim_1=corrcoef(loco_onlystim,sig_read_onlystim);
    R_Loco_onlystim(i)=R_onlystim_1(1,2);
    
    R_onlystim_us_1=corrcoef(loco_onlystim_us,sig_read_onlystim_us);
    R_Loco_onlystim_us(i)=R_onlystim_us_1(1,2);
    
    R_EMG_nostim_1=corrcoef(EMG_nostim(find(EMG_nostim~=0)),sig_read_nostim(find(EMG_nostim~=0)));
    R_EMG_nostim(i)=R_EMG_nostim_1(1,2);
    
    R_EMG_onlystim_1=corrcoef(EMG_onlystim,sig_read_onlystim);
    R_EMG_onlystim(i)=R_EMG_onlystim_1(1,2);
    
    R_EMG_onlystim_us_1=corrcoef(EMG_onlystim_us,sig_read_onlystim_us);
    R_EMG_onlystim_us(i)=R_EMG_onlystim_us_1(1,2);
    
     R_3=corrcoef(angular_speed,sig_read_1);
     R_Loco(i)=R_3(1,2);
     sig_read_extract=sig_read_1(IndexOfFrame(1)-50:IndexOfFrame(end)+100);
     EMG_extract_2=EMG_extract_1(IndexOfFrame(1)-50:IndexOfFrame(end)+100);
     R_4=corrcoef(EMG_extract_2,sig_read_extract);
     R_EMG(i)=R_4(1,2);
end
%classification 3 types: high-locomotion related; whisker reponsive cells; others
R_Loco_nostim_abs_60percentile=prctile(abs(R_Loco_nostim),60);
R_Loco_high_cell_index=find(abs(R_Loco_nostim)>=R_Loco_nostim_abs_60percentile);
Cell_index_same=intersect(Res_Cell_Whisker,R_Loco_high_cell_index);
Res_Whisker_cell_index=setdiff(Res_Cell_Whisker,Cell_index_same);
all_cell_index=1:1:CellNumber;
Res_whisker_highloco_index=[R_Loco_high_cell_index,Res_Whisker_cell_index];
Res_others_cell_index=setdiff(all_cell_index,Res_whisker_highloco_index);

%Calculate noise correlation(NC) within all cell classes
for ii=1:length(Cell_signal_alltrials)
    for jj=ii+1:length(Cell_signal_alltrials)
x1=Cell_signal_alltrials{ii};
x=x1(21:37,:);% set the duration: 0~1s after cs onset
y1=Cell_signal_alltrials{jj};
y=y1(21:37,:);
x_variability=std(x-mean(x,2),[],1);%at first is 2,each row;1 each  
y_variability=std(y-mean(y,2),[],1);

cov_matrix = cov(x_variability, y_variability);
noise_corr(ii,jj) = cov_matrix(1,2) / (std(x_variability) * std(y_variability));
    noise_corr(jj,ii)=noise_corr(ii,jj);
    end
end
clear x1 x y1 y x_variability y_variability cov_matrix
%NC in whisker-response cells
if length(Res_Whisker_cell_index)~=0
for mm1=1:length(Res_Whisker_cell_index)
    mm2=Res_Whisker_cell_index(mm1);
    Cell_signal_alltrials_whisker{mm1}=Cell_signal_alltrials{mm2};
end
  
for ii=1:length(Cell_signal_alltrials_whisker)
    for jj=ii+1:length(Cell_signal_alltrials_whisker)
x1=Cell_signal_alltrials_whisker{ii};
x=x1(21:37,:);% set the duration: 0~1s after cs onset
y1=Cell_signal_alltrials_whisker{jj};
y=y1(21:37,:);
x_variability=std(x-mean(x,2),[],1);%at first is 2,each row;1 each  
y_variability=std(y-mean(y,2),[],1);

cov_matrix = cov(x_variability, y_variability);
noise_corr_whisker(ii,jj) = cov_matrix(1,2) / (std(x_variability) * std(y_variability));
    noise_corr_whisker(jj,ii)=noise_corr(ii,jj);
    end
end
 
end

% % 1. NC trial-to-trial;
% for ii=1:length(Cell_signal_alltrials)
%     Cell_signal_alltrials_1=Cell_signal_alltrials{ii};
%     Cell_signal_alltrials_2=Cell_signal_alltrials_1-mean(Cell_signal_alltrials_1,2);
%    Cell_signal_alltrials_3=mean(Cell_signal_alltrials_2,2);
%     
%     TrialNoiseCorrelation_1=corrcoef(Cell_signal_alltrials_2);
%     TrialNoiseCorrelation_1=TrialNoiseCorrelation_1(TrialNoiseCorrelation_1~=1)
%     TrialNoiseCorrelation_2=mad(TrialNoiseCorrelation_1);
% %     TrialNoiseCorrelation_3=(sum(TrialNoiseCorrelation_2,2)-1)/15;
%     TrialNoiseCorrelation(:,ii)=mean(TrialNoiseCorrelation_2);
% end
% 
% %2. NC,cell-to-cell
% for mm=1:size(select_cell_sig_mean_all,2)
%     Cell_signal_allcells_1=select_cell_sig_mean_all(:,1);
%     Cell_signal_allcells_2=Cell_signal_allcells_1-mean(select_cell_sig_mean_all,2)
% end

% save locomotion_select_mean, FOR plot traces
fn_12=[fn '_LocoTraces'];
save(sprintf('%s',fn_12), 'locomotion_select_mean');

fn_19=[fn '_EMGTraces'];
save(sprintf('%s',fn_19), 'EMG_select_mean');
% save signal traces of all cells
fn_11=[fn '_AllCellTraces'];
save(sprintf('%s',fn_11), 'select_cell_sig_mean_all');

fn_20=[fn '_AllCellTracesNoCS'];
save(sprintf('%s',fn_20), 'select_cell_sig_nocs_mean_all');
fn_21=[fn '_AllCellTracesNoUS'];
save(sprintf('%s',fn_21), 'select_cell_sig_nous_mean_all');
fn_22=[fn '_alltrials'];
save(sprintf('%s',fn_22), 'Cell_signal_alltrials');


%save correlation: R_Loco_nostim,R_EMG_nostim, for scatter plot
fn_13=[fn '_R_Loco_nostim'];
save(sprintf('%s',fn_13), 'R_Loco_nostim');
fn_23=[fn '_R_Loco'];
save(sprintf('%s',fn_23), 'R_Loco');

fn_14=[fn '_R_EMG_nostim'];
save(sprintf('%s',fn_14), 'R_EMG_nostim');
fn_24=[fn '_R_EMG'];
save(sprintf('%s',fn_24), 'R_EMG');

fn_25=[fn '_AlltrialEMG'];
save(sprintf('%s',fn_25), 'EMG_select_2');

fn_26=[fn '_AlltrialLocomotion'];
save(sprintf('%s',fn_26), 'locomotion_select_2');

%save signal traces of different types
cell_index={R_Loco_high_cell_index,Res_Whisker_cell_index,Res_others_cell_index,Cell_index_same};
fn_15=[fn '_cell_index'];
save(sprintf('%s',fn_15), 'cell_index');

%save response integral

fn_16=[fn '_Response_integral'];
save(sprintf('%s',fn_16), 'Response_integral');

%save noise correlation
fn_17=[fn '_noise_correlation'];
save(sprintf('%s',fn_17), 'noise_corr');

fn_18=[fn '_noise_correlation_whisker'];
save(sprintf('%s',fn_18), 'noise_corr_whisker');
