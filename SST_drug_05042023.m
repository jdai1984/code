clear;
close all;
clc;

load('mycmap.mat')
load('color_value.mat')
color_value_1= [0.64,0.76,0.81;0.16,0.26,0.71; 0 0 1];
color_value_2= [0.44,0.81,0.46;0.16,0.61,0.16; 0 1 0];
color_value_3= [0.81,0.44,0.46;0.61,0.16,0.16; 1 0 0];

color_value_4=[0.7 0.7 0.7;0.5 0.5 0.5;0 0 0];
load('color_line.mat')

dii = dir('*_AllCellTraces.mat');

saline_traces_all=[];

drug_traces_all=[];

for i=1:length(dii)
    fn = strtok(dii(i).name,'.');
    load([fn '.mat'])
    mouse_str_2=fn(11:12);
    mouse_number_id_2=sscanf(mouse_str_2,'%f');
    
    if ismember(mouse_number_id_2,[42 51 64])
     saline_traces_all_1=select_cell_sig_mean_all;
     saline_traces_all=[saline_traces_all saline_traces_all_1];
    elseif ismember(mouse_number_id_2,[47 66]) 
      drug_traces_all_1=select_cell_sig_mean_all;
     drug_traces_all=[drug_traces_all drug_traces_all_1];  
    end
end

M={saline_traces_all',drug_traces_all'};

%plot heatmap all cell traces
figure; hold on; set(gcf,'color','w','position',[100 50 500 300]);
stages = {'saline','drug','saline','drug'};

for ii=1:length(M)
subplot(1,5,ii)
temp=M{ii};
temp=temp(:,6:53);
% temp_mean_CR{ii}=sum(temp(:,16:24),2);
% temp_mean_UR{ii}=sum(temp(:,26:30),2);
% [~,I] = sort(sum(temp(:,25:29),2),'descend');
[~,I] = sort(sum(temp(:,16:32),2),'descend');
Index{ii}=I;
    temp = temp(I,:);
    imagesc(temp,[-1.5,8]); 
colormap(mycmap);
line([16,16],ylim,'color','k','linestyle',':');

line([24,24],ylim,'color','k','linestyle',':');

if ii==1
 ylabel('# of cells');
end
 xticks([16,32,48]); xticklabels({'0','1','2'}); 
 yticks([40,80,120])

 xlabel('Time (s)');
 
 yticks([50,100,150,200,250,300,350 400])
  if ii>1
     yticklabels({})
 end
 title(stages{ii});
end
clear temp


%classify IN neurons
 for ii=1:length(M)
    temp=M{ii};
     
    for m=1:size(temp,1)
        temp_1_trace=temp(m,:);
        temp_1_trace=temp_1_trace(:,6:69);
        temp_1_CR=max(temp_1_trace(:,16:24));
        temp_1_base=max(temp_1_trace(:,1:10));
        temp_1_base_std=std(temp_1_trace(:,1:10));
        temp_1_UR_max=max(temp_1_trace(:,26:30));
        temp_1_UR_min=min(temp_1_trace(:,26:30));
        if (temp_1_CR-temp_1_base)>=4*temp_1_base_std & temp_1_UR_min>0
            temp_id(m)=1;
        elseif temp_1_UR_min<=0 & (abs(temp_1_UR_min)-temp_1_base)>=3*temp_1_base_std
            temp_id(m)=-1;
        else
            temp_id(m)=0;
        end
    end
    
    index_positive_1=find(temp_id==1);  
      index_negative_1=find(temp_id==-1);  
      index_unchanged_1=find(temp_id==0);
      
      index_positive{ii}=index_positive_1;
      index_negative{ii}=index_negative_1;
      index_unchanged{ii}=index_unchanged_1;
    
      num_positive_1=length(find(temp_id==1));  
      num_negative_1=length(find(temp_id==-1));  
      num_unchanged_1=length(find(temp_id==0));
   
      num_positive(ii)=num_positive_1;
      num_negative(ii)=num_negative_1;
      num_unchanged(ii)=num_unchanged_1;
      
      clear index_positive_1  index_negative_1 index_unchanged_1
      clear num_positive_1  num_negative_1 num_unchanged_1
      clear temp temp_1_trace temp_id
 end


%plot mean traces: mean with SEM area
 figure; hold on; set(gcf,'color','w','position',[200 200 200 200]);
 for ii=1:length(M)
    temp=M{ii};
   Index_positive=index_positive{ii};
    Index_negative=index_negative{ii};
    temp_positive=temp(Index_positive,:);
    temp_negative=temp(Index_negative,:);
    temp_positive=temp_positive(:,6:53)+2*(ii-1);
    temp_negative=temp_negative(:,6:53)+2*(ii-1);
    
    temp_1 = nanmean(temp_positive);
    temp_2 = nanstd(temp_positive)./sqrt(sum(~isnan(temp_positive(:,1))));
    h1 = area([(temp_1-temp_2)',(2*temp_2)']);
    set(h1(1),'EdgeColor','none','FaceColor','none');
    set(h1(2),'EdgeColor','none','FaceColor',color_value(2,:),'FaceAlpha',0.3);
%     if ii==1
%         plot(temp_1,'color',color_value(2,:),'linewidth',2,'LineStyle',':');
%     else
%     plot(temp_1,'color',color_value(2,:),'linewidth',2);
%     end
    
     plot(temp_1,'color',color_value(2,:),'linewidth',2);
    
    temp_3 = nanmean(temp_negative);
    temp_4 = nanstd(temp_negative)./sqrt(sum(~isnan(temp_negative(:,1))));
    h2= area([(temp_3-temp_4)',(3*temp_4)']);
    set(h2(1),'EdgeColor','none','FaceColor','none');
    set(h2(2),'EdgeColor','none','FaceColor',color_value(2,:),'FaceAlpha',0.3);
%     if ii==1
%         plot(temp_3,'color',color_value(2,:),'linewidth',2,'LineStyle',':');
%     else
%     plot(temp_3,'color',color_value(2,:),'linewidth',2);
%     end
    plot(temp_3,'color',color_value(2,:),'linewidth',2,'LineStyle',':');
    
    ylim([-0.5 3.5]);
    line([16,16],[-0.5 3.2],'color','k','linestyle',':','linewidth',1);
    
 end
hold on
line([24,24],[-0.5 3.2],'color','k','linestyle',':','linewidth',1);
xlim([1,48]); xticks([16,32,48]); xticklabels({'0','1','2'}); xlabel('Time (s)');
ylabel('Mean \Deltaf/f'); axis square;
axis off
clear temp_1 temp_2

%statistics: bar plot
M11={saline_traces_all(:,index_positive{1})',drug_traces_all(:,index_positive{2})'};
figure; set(gcf,'position',[300,300,200,200]); hold on;

for ii=1:length(M11)
    temp=M11{ii};
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
    value_M11_cs{ii}=temp_var;
    
    
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    

end
plot(temp_1,'color',color_value(2,:),'LineWidth',2,'LineStyle','-');
 for ii = 1:length(M11)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',2,'LineStyle','-');
 end   
xlim([0.5,length(M11)+0.5]); ylim([0,1]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks(-1:1:2)
clear temp temp_1 temp_2
p = ranksum(value_M11_cs{1},value_M11_cs{2})

hold on
for ii=1:length(M11)
    temp=M11{ii};
    temp=temp(:,6:53);
    temp=temp(:,25:48);
    temp_var=max(temp');
    
    value_M11_us{ii}=temp_var;
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    

end

plot([3 4],temp_1,'color',color_value(2,:),'LineWidth',3,'LineStyle','-');
 for ii = 1:length(M11)
    line([ii+2,ii+2],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',3,'LineStyle','-');
 end   
xlim([0.5,2*length(M11)+0.5]); ylim([0,2.5]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks(0:1:3)
clear temp temp_1 temp_2

p = ranksum(value_M11_us{1},value_M11_us{2})



M12={saline_traces_all(:,index_negative{1})',drug_traces_all(:,index_negative{2})'};
figure; set(gcf,'position',[300,300,200,200]); hold on;

for ii=1:length(M12)
    temp=M12{ii};
    temp=temp(:,6:53);
    temp=temp(:,16:24);
    temp_var=max(temp');
    
    value_M12_cs{ii}=temp_var;
    
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    

end
plot(temp_1,'color',color_value(2,:),'LineWidth',2,'LineStyle',':');
 for ii = 1:length(M11)
    line([ii,ii],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',2,'LineStyle',':');
 end   
xlim([0.5,length(M11)+0.5]); ylim([0,1]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
yticks(-1:1:2)
clear temp temp_1 temp_2
p = ranksum(value_M12_cs{1},value_M12_cs{2})



hold on
for ii=1:length(M12)
    temp=M12{ii};
    temp=temp(:,6:53);
    temp=temp(:,25:48);
    temp_var=min(temp');
    
    value_M12_us{ii}=temp_var;
    
    temp_1(:,ii) = nanmean(temp_var);
    temp_2(:,ii)  = nanstd(temp_var)./sqrt(sum(~isnan((temp_var))));
    

end

plot([3 4],temp_1,'color',color_value(2,:),'LineWidth',3,'LineStyle',':');
 for ii = 1:length(M11)
    line([ii+2,ii+2],[temp_1(ii)-temp_2(ii),temp_1(ii)+temp_2(ii)],'color',color_value(2,:),'LineWidth',3,'LineStyle',':');
 end   
xlim([0.5,2*length(M11)+0.5]); xticks([1:4]); xticklabels(stages); ylabel('Mean \Deltaf/f');
 yticks(-0.5:0.5:0.5);ylim([-0.5,0.5]); 
clear temp temp_1 temp_2

p = ranksum(value_M12_us{1},value_M12_us{2})