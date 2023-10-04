clear;
close all;
clc;
fn='jda4039';
fn_1='04142021_054_008';
EMGall=abfload([fn '.abf']);
TrialNum=20;
TTLNum=40;
size_emgall=size(EMGall);
length_size=size_emgall(3);

for i=1:length_size
    emgall2=EMGall(:,:,i);   
    cell{i}=emgall2;
end   
emgnew=vertcat(cell{1:length_size});
Pulse1=emgnew(:,2)/4; % channel 2 is the pulse of the airpuff
Pulse2=emgnew(:,1)/4; % channel 1 is the pulse of the whisker and the airpuff
EMG3=emgnew(:,3); % channel 3 is the EMG signal

FrenquencyAcquisition=13500;
Pulseposition1=find(Pulse2>1);
Pulseposition2=diff(Pulseposition1);
Pulseposition_position=find(Pulseposition2>50);
Pulseposition=0;

fn_7=[fn_1 '_IndexofFrame'];
load('-mat',fn_7);
IndexOfFrame_3=IndexOfFrame;
for i=1:TTLNum
    if i == 1
        Pulseposition(i)=Pulseposition1(i);
    else
    Pulseposition(i)=Pulseposition1(Pulseposition_position(i-1)+1);
    end
end


    EMG_Eye=EMG3(1:Pulseposition(TTLNum)+(20*FrenquencyAcquisition));
    
    sigwithoutDC=detrend(EMG_Eye); %Remove any DC offset of the signal
    rec_sigwithoutDC=abs(sigwithoutDC);  %Rectification of the EMG signal
    [b,a]=butter(5,60/6000,'low'); %Low pass the signal, cut off
    filter_rec_sigwithoutDC=filtfilt(b,a,rec_sigwithoutDC); %filter the signals to obtain the linear envelope. The command filtfilt performs filtering in both directions to eliminate any
    EMGEye=filter_rec_sigwithoutDC; 
    plot(EMGEye); 
    %grid off;
%     axis off;
    hold on
   
    
% EMG_extract_position_2=[];
    for m=1:TTLNum
                
        h=line([Pulseposition(m) Pulseposition(m)], [0.1*min(EMGEye) 0.2*max(EMGEye)]);
    %xlim([0 2563])
    set(h,'LineWidth',0.5);
    set(h,'color','green');
    set(h,'LineStyle','--');
        
    end
EMG_extract_position_3=[];
 for i=1:length(IndexOfFrame)-1
    
 EMG_pulselength=Pulseposition(i+1)-Pulseposition(i);
 Frame_pulselength=IndexOfFrame_3(i+1)-IndexOfFrame_3(i);  
 Size_dif=fix(EMG_pulselength/Frame_pulselength);
    for p=1:Frame_pulselength
            EMG_extract_position_1=Pulseposition(i)+Size_dif*(p-1);
            EMG_extract_position(:,p)=EMG_extract_position_1;
            %EMG_extract_1(:,p)=EMGEye(EMG_extract_position);
    end
     
     
EMG_extract_position_3=[EMG_extract_position_3 EMG_extract_position];
clear EMG_extract_position
 end
%  EMG_extract_position_1(1)=Pulseposition(1);
%  Pulseposition(2);
%  for j=1:Frame_pulselength
%      for i=1:length(IndexOfFrame)
%       EMG_extract_position_1(j)=Pulseposition(1);
%      end
%             
%    
%  end
    
    
    
    
 
%     EMG_extract_position=nonzeros(EMG_extract_position);
EMG_extract_position=EMG_extract_position_3;
    EMG_extract_1=EMGEye(EMG_extract_position_3);
    
    for i=1:100
  EMG_extract_position_Add1(i,:)=(EMG_extract_position(1)-Size_dif*(100-i));
    end

    for i=1:200
  EMG_extract_position_Add2(i,:)=(EMG_extract_position(end)+Size_dif*i);
    end

    
EMG_extract_position_add=[EMG_extract_position_Add1; EMG_extract_position'; EMG_extract_position_Add2];
EMG_extract=EMGEye(EMG_extract_position_add);   


%  EMG_extract=EMGEye(EMG_extract_position_3);    
 fn_2=[fn_1 '_EMG_extract'];
save(sprintf('%s',fn_2), 'EMG_extract');
  figure(2)
plot(EMG_extract)
hold on
IndexOfFrame_2=IndexOfFrame-IndexOfFrame(1)+100;
    for m=1:TTLNum
                
        h=line([IndexOfFrame_2(m) IndexOfFrame_2(m)], [0.1*min(EMGEye) 0.2*max(EMGEye)]);
    %xlim([0 2563])
    set(h,'LineWidth',0.5);
    set(h,'color','green');
    set(h,'LineStyle','--');
        
    end