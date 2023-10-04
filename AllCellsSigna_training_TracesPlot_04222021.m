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

%%%Plot the signal changes with stimulation
% figure(2)
for n=1:CellNumber
    select_cell_sig_0=sig(:,n);
    select_cell_sig=(select_cell_sig_0-mean(select_cell_sig_0(1:200)))/abs(mean(select_cell_sig_0(1:200)));
%     select_cell_sig=select_cell_sig-mean(select_cell_sig(1:10))/abs(mean(select_cell_sig(1:10)));
    for m=1:length(TrialIndex)
    i=TrialIndex(m);
    select_cell_sig_1=select_cell_sig(IndexOfFrame_3(i)-10:IndexOfFrame_3(i)+69);
    
    select_cell_sig_3(:,m)=select_cell_sig_1;
    locomotion_select_1=angular_speed(IndexOfFrame_3(i)-10:IndexOfFrame_3(i)+69);
    locomotion_select_2(:,m)=locomotion_select_1;
    EMG_select_1=EMG_extract_1(IndexOfFrame_3(i)-10:IndexOfFrame_3(i)+69);
    EMG_select_2(:,m)=EMG_select_1;
    end
    
    for a=1:length(TrialIndex_NoCS)
    b=TrialIndex_NoCS(a);
    select_cell_sig_nocs_1=select_cell_sig(IndexOfFrame_3(b)-10:IndexOfFrame_3(b)+69);
%     select_cell_sig_nocs_2=(select_cell_sig_nocs_1-mean(select_cell_sig_nocs_1(1:10)))/abs(mean(select_cell_sig_nocs_1(1:10)));
    select_cell_sig_nocs_3(:,a)=select_cell_sig_nocs_1;
    locomotion_select_nocs_1=angular_speed(IndexOfFrame_3(b)-10:IndexOfFrame_3(b)+69);
    locomotion_select_nocs_2(:,a)=locomotion_select_nocs_1;
    EMG_select_nocs_1=EMG_extract_1(IndexOfFrame_3(b)-10:IndexOfFrame_3(b)+69);
    EMG_select_nocs_2(:,a)=EMG_select_nocs_1;
    end
    
      for c=1:length(TrialIndex_NoUS)
    d=TrialIndex_NoUS(c);
    select_cell_sig_nous_1=select_cell_sig(IndexOfFrame_3(d)-10:IndexOfFrame_3(d)+69);
%     select_cell_sig_nous_2=(select_cell_sig_nous_1-mean(select_cell_sig_nous_1(1:10)))/abs(mean(select_cell_sig_nous_1(1:10)));
    select_cell_sig_nous_3(:,c)=select_cell_sig_nous_1;
    locomotion_select_nous_1=angular_speed(IndexOfFrame_3(d)-10:IndexOfFrame_3(d)+69);
    locomotion_select_nous_2(:,c)=locomotion_select_nous_1;
    EMG_select_nous_1=EMG_extract_1(IndexOfFrame_3(d)-10:IndexOfFrame_3(d)+69);
    EMG_select_nous_2(:,c)=EMG_select_nous_1;
    end
%     
    select_cell_sig_mean_1=mean(select_cell_sig_3,2);
    select_cell_sig_mean_max_1=max(select_cell_sig_mean_1(11:30));
    select_cell_sig_mean_all(:,n)=select_cell_sig_mean_1;
    select_cell_sig_mean_max(:,n)=select_cell_sig_mean_max_1;
    
    select_cell_sig_mean_min_1=min(select_cell_sig_mean_1(11:30));
    select_cell_sig_mean_min(:,n)=select_cell_sig_mean_min_1;
    
    if abs(select_cell_sig_mean_max_1)>abs(select_cell_sig_mean_min_1)
       select_cell_positive_negative_1(:,n)=1;
    else
       select_cell_positive_negative_1(:,n)=0;
    end
    
    locomotion_select_mean=mean(locomotion_select_2,2);
%     EMG_select_mean=mean(EMG_select_2,2);
    
    select_cell_sig_nocs_mean_1=mean(select_cell_sig_nocs_3,2);
    select_cell_sig_nocs_max_1=max(select_cell_sig_nocs_mean_1(11:30));
    select_cell_sig_nocs_max_all(:,n)=select_cell_sig_nocs_max_1;
    select_cell_sig_nocs_mean_all(:,n)=select_cell_sig_nocs_mean_1;
    select_cell_sig_nocs_min_1=min(select_cell_sig_nocs_mean_1(11:30));
    select_cell_sig_nocs_min_all(:,n)=select_cell_sig_nocs_min_1;
    
    select_cell_sig_nous_mean_1=mean(select_cell_sig_nous_3,2);
    select_cell_sig_nous_max_1=max(select_cell_sig_nous_mean_1(11:30));
    select_cell_sig_nous_max_all(:,n)=select_cell_sig_nous_max_1;
    select_cell_sig_nous_mean_all(:,n)=select_cell_sig_nous_mean_1;
     select_cell_sig_nous_min_1=min(select_cell_sig_nous_mean_1(11:30));
    select_cell_sig_nous_min_all(:,n)=select_cell_sig_nous_min_1;
    
%     subplot(CellNumber,1,n)
%     plot(select_cell_sig_mean_1)
%     hold on
%     axis off
end
aaa=10;
Fig_num_integer=fix(CellNumber/aaa);
Fig_num_rem=rem(CellNumber,aaa);
if Fig_num_rem==0
    Fig_num=Fig_num_integer;
else
    Fig_num=Fig_num_integer+1;
end
for nn=1:Fig_num
    
select_cell_all=1+aaa*(nn-1):aaa+aaa*(nn-1);%[1,2,3];

if max(select_cell_all)>CellNumber
  select_cell_all=1+aaa*(nn-1):CellNumber;  
end

figure (nn)
for p=1:length(select_cell_all)
    select_cell=select_cell_all(p);
sig_cell_select_5=sig(:,select_cell);
sig_cell_select=(sig_cell_select_5-min(sig_cell_select_5(1:200)))/abs(min(sig_cell_select_5(1:200)));

subplot(length(select_cell_all)+2,4,1+4*(p-1):3+4*(p-1))
plot(sig_cell_select,'black');
hold on
for k=1:TrialNumber
    h=line([IndexOfFrame_3(k) IndexOfFrame_3(k)], [min(sig_cell_select) max(sig_cell_select)]);
     set(h,'LineWidth',0.1);
    set(h,'LineStyle','--');
    set(h,'color','blue');
    %xlim([0 2563])
    if ismember(k,TrialIndex_NoCS)
        set(h,'color','blue');
    elseif ismember(k,TrialIndex_NoUS)
        set(h,'color','red');
    else
    set(h,'color','green');
    end
    ylabel(sprintf('%d',select_cell),'FontSize', 10)
end
axis off
subplot(length(select_cell_all)+2,4,4+4*(p-1))
plot(select_cell_sig_mean_all(:,select_cell),'g','LineWidth',2)
hold on
plot(select_cell_sig_nocs_mean_all(:,select_cell),'blue','LineWidth',0.5)
hold on
plot(select_cell_sig_nous_mean_all(:,select_cell),'red','LineWidth',0.5)

hold on
h=line([11 11], [0 max(select_cell_sig_mean_all(:,select_cell))]);
set(h,'LineWidth',0.1);
set(h,'color','black');
set(h,'LineStyle','--');
hold on
h2=line([19 19], [0 max(select_cell_sig_mean_all(:,select_cell))]);
set(h2,'LineWidth',0.1);
set(h2,'color','black');
set(h2,'LineStyle','--');
set(gca,'FontSize',4)

axis off
% ylabel('Cell number','FontSize',6)
% title('Avg Sig (CS-US)','FontSize',6)
end
subplot(length(select_cell_all)+2,4,1+4*(p):3+4*(p))

plot(angular_speed)
ylim([-50 100])
hold on
for k=1:TrialNumber
    h=line([IndexOfFrame_3(k) IndexOfFrame_3(k)], [min(angular_speed) max(angular_speed)]);
     set(h,'LineWidth',0.2);
    set(h,'LineStyle','--');
    set(h,'color','blue');
    %xlim([0 2563])
    if ismember(k,TrialIndex_NoCS)
        set(h,'color','blue');
    elseif ismember(k,TrialIndex_NoUS)
        set(h,'color','red');
    else
    set(h,'color','green');
    end
    
end
ylabel('Locomotion','FontSize', 6)
axis off

subplot(length(select_cell_all)+2,4,4+4*(p))
% figure(2)
% subplot(2,1,2)
plot(locomotion_select_mean,'g','LineWidth',2)
hold on
plot(mean(locomotion_select_nocs_2,2),'blue','LineWidth',0.5)
hold on
plot(mean(locomotion_select_nous_2,2),'red','LineWidth',0.5)
hold on
h=line([11 11], [min(locomotion_select_mean) max(locomotion_select_mean)]);
set(h,'LineWidth',0.1);
set(h,'color','black');
set(h,'LineStyle','--');
hold on
h2=line([19 19], [min(locomotion_select_mean) max(locomotion_select_mean)]);
set(h2,'LineWidth',0.1);
set(h2,'color','black');
set(h2,'LineStyle','--');
set(gca,'FontSize',4)
axis off

subplot(length(select_cell_all)+2,4,1+4*(p+1):3+4*(p+1))
% figure(2)
% subplot(2,1,1)
plot(EMG_extract_1)
hold on
for k=1:TrialNumber
    h=line([IndexOfFrame_3(k) IndexOfFrame_3(k)], [min(EMG_extract_1) max(EMG_extract_1)]);
     set(h,'LineWidth',0.2);
    set(h,'LineStyle','--');
    set(h,'color','blue');
    %xlim([0 2563])
    if ismember(k,TrialIndex_NoCS)
        set(h,'color','blue');
    elseif ismember(k,TrialIndex_NoUS)
        set(h,'color','red');
    else
    set(h,'color','green');
    end
    
end
ylabel('EMG','FontSize', 6)
axis off

subplot(length(select_cell_all)+2,4,4+4*(p+1))
plot(mean(EMG_select_2,2),'g','LineWidth',2)
hold on
plot(mean(EMG_select_nocs_2,2),'blue','LineWidth',0.5)
hold on
plot(mean(EMG_select_nous_2,2),'red','LineWidth',0.5)
hold on
h=line([11 11], [min(mean(EMG_select_2,2)) max(mean(EMG_select_2,2))]);
set(h,'LineWidth',0.1);
set(h,'color','black');
set(h,'LineStyle','--');
hold on
h2=line([19 19], [min(mean(EMG_select_2,2)) max(mean(EMG_select_2,2))]);
set(h2,'LineWidth',0.1);
set(h2,'color','black');
set(h2,'LineStyle','--');
set(gca,'FontSize',4)
axis off
end
