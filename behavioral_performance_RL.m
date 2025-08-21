
function behavioral_performance_RL(LogDir,Subjects)

%LogDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Logfile\'];

plot_individual   = false;
plot_mean   = true;

for i = 1:length(Subjects)
    sID=Subjects(i);
    Result=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_all.txt']);
    
    response=[];
    for n=1:floor(length(Result.data)/45)
        response=[response,Result.data(45*(n-1)+1:45*(n-1)+45,7)];%%Extract values of every 45 lines(1 block) to Response
    end
    
    
    %RUN1
    %block1
    for j=1:22
        
        block01_ac(j)=sum(response(1:j,1)==1|response(1:j,1)==4)/j;
    end
    for j=1:23
        block01_re(j)=sum(response(23:22+j,1)==1|response(23:22+j,1)==4)/j;
    end
    %block2
    for j=1:24
        block02_ac(j)=sum(response(1:j,2)==1|response(1:j,2)==4)/j;
    end
    for j=1:21
        block02_re(j)=sum(response(25:24+j,2)==1|response(25:24+j,2)==4)/j;
    end
    
    %block3
    for j=1:21
        block03_ac(j)=sum(response(1:j,3)==1|response(1:j,3)==4)/j;
    end
    for j=1:24
        block03_re(j)=sum(response(22:21+j,3)==1|response(22:21+j,3)==4)/j;
    end
    
    %block4
    for j=1:23
        block04_ac(j)=sum(response(1:j,4)==1|response(1:j,4)==4)/j;
    end
    for j=1:22
        block04_re(j)=sum(response(24:23+j,4)==1|response(24:23+j,4)==4)/j;
    end
    
    
    %RUN2
    %block1
    for j=1:25
        block05_ac(j)=sum(response(1:j,5)==1|response(1:j,5)==4)/j;
    end
    for j=1:20
        block05_re(j)=sum(response(26:25+j,5)==1|response(26:25+j,5)==4)/j;
    end
    %block2
    for j=1:22
        block06_ac(j)=sum(response(1:j,6)==1|response(1:j,6)==4)/j;
    end
    for j=1:23
        block06_re(j)=sum(response(23:22+j,6)==1|response(23:22+j,6)==4)/j;
    end
    
    %block3
    for j=1:24
        block07_ac(j)=sum(response(1:j,7)==1|response(1:j,7)==4)/j;
    end
    for j=1:21
        block07_re(j)=sum(response(25:24+j,7)==1|response(25:24+j,7)==4)/j;
    end
    
    %block4
    for j=1:20
        block08_ac(j)=sum(response(1:j,8)==1|response(1:j,8)==4)/j;
    end
    for j=1:25
        block08_re(j)=sum(response(21:20+j,8)==1|response(21:20+j,8)==4)/j;
    end
    
    
    
    %block1
    for j=1:20
        block09_ac(j)=sum(response(1:j,9)==1|response(1:j,9)==4)/j;
    end
    for j=1:25
        block09_re(j)=sum(response(21:20+j,9)==1|response(21:20+j,9)==4)/j;
    end
    %block2
    for j=1:24
        block10_ac(j)=sum(response(1:j,10)==1|response(1:j,10)==4)/j;
    end
    for j=1:21
        block10_re(j)=sum(response(25:24+j,10)==1|response(25:24+j,10)==4)/j;
    end
    
    %block3
    for j=1:23
        block11_ac(j)=sum(response(1:j,11)==1|response(1:j,11)==4)/j;
    end
    for j=1:22
        block11_re(j)=sum(response(24:23+j,11)==1|response(24:23+j,11)==4)/j;
    end
    
    %block4
    for j=1:21
        block12_ac(j)=sum(response(1:j,12)==1|response(1:j,12)==4)/j;
    end
    for j=1:24
        block12_re(j)=sum(response(22:21+j,12)==1|response(22:21+j,12)==4)/j;
    end
    
    
    %Align
    %     mean_align=nanmean([[nan,nan,nan,block01_ac,block01_re,nan,nan];[nan,block02_ac,block02_re,nan,nan,nan,nan];[nan,nan,nan,nan,block03_ac,block03_re,nan];[nan,nan,block04_ac,block04_re,nan,nan,nan];...
    %         [block05_ac,block05_re,nan,nan,nan,nan,nan];[nan,nan,nan,block06_ac,block06_re,nan,nan];[nan,block07_ac,block07_re,nan,nan,nan,nan];[nan,nan,nan,nan,nan,block08_ac,block08_re];...
    %         [nan,nan,nan,nan,nan,block09_ac,block09_re];[nan,block10_ac,block10_re,nan,nan,nan,nan];[nan,nan,block11_ac,block11_re,nan,nan,nan];[nan,nan,nan,nan,block12_ac,block12_re,nan]]);
    %
    %     figure;plot(mean_align);
    %
    
    %Interpolate&Align
    mean_ac_interpolate=([block01_ac,block01_ac(22),block01_ac(22),block01_ac(22)]+[block02_ac,block02_ac(24)]+[block03_ac,block03_ac(21),block03_ac(21),block03_ac(21),block03_ac(21)]+[block04_ac,block04_ac(23),block04_ac(23)]...
        +block05_ac+[block06_ac,block06_ac(22),block06_ac(22),block06_ac(22)]+[block07_ac,block07_ac(24)]+[block08_ac,block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20)]...
        +[block09_ac,block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20)]+[block10_ac,block10_ac(24)]+[block11_ac,block11_ac(23),block11_ac(23)]+[block12_ac,block12_ac(21),block12_ac(21),block12_ac(21),block12_ac(21)])/12;
    
    mean_re_interpolate=([block01_re,block01_re(23),block01_re(23)]+[block02_re,block02_re(21),block02_re(21),block02_re(21),block02_re(21)]+[block03_re,block03_re(24)]+[block04_re,block04_re(22),block04_re(22),block04_re(22)]...
        +[block05_re,block05_re(20),block05_re(20),block05_re(20),block05_re(20),block05_re(20)]+[block06_re,block06_re(23),block06_re(23)]+[block07_re,block07_re(21),block07_re(21),block07_re(21),block07_re(21)]+[block08_re]...
        +[block09_re]+[block10_re,block10_re(21),block10_re(21),block10_re(21),block10_re(21)]+[block11_re,block11_re(22),block11_re(22),block11_re(22)]+[block12_re,block12_re(24)])/12;
    
    
    
    mean_ac_interpolate_R1=([block01_ac,block01_ac(22),block01_ac(22),block01_ac(22)]+[block02_ac,block02_ac(24)]+[block03_ac,block03_ac(21),block03_ac(21),block03_ac(21),block03_ac(21)]+[block04_ac,block04_ac(23),block04_ac(23)])/4;
    mean_ac_interpolate_R2=(block05_ac+[block06_ac,block06_ac(22),block06_ac(22),block06_ac(22)]+[block07_ac,block07_ac(24)]+[block08_ac,block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20)])/4;
    mean_ac_interpolate_R3=([block09_ac,block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20)]+[block10_ac,block10_ac(24)]+[block11_ac,block11_ac(23),block11_ac(23)]+[block12_ac,block12_ac(21),block12_ac(21),block12_ac(21),block12_ac(21)])/4;
    
    mean_re_interpolate_R1=([block01_re,block01_re(23),block01_re(23)]+[block02_re,block02_re(21),block02_re(21),block02_re(21),block02_re(21)]+[block03_re,block03_re(24)]+[block04_re,block04_re(22),block04_re(22),block04_re(22)])/4;
    mean_re_interpolate_R2=([block05_re,block05_re(20),block05_re(20),block05_re(20),block05_re(20),block05_re(20)]+[block06_re,block06_re(23),block06_re(23)]+[block07_re,block07_re(21),block07_re(21),block07_re(21),block07_re(21)]+[block08_re])/4;
    mean_re_interpolate_R3=([block09_re]+[block10_re,block10_re(21),block10_re(21),block10_re(21),block10_re(21)]+[block11_re,block11_re(22),block11_re(22),block11_re(22)]+[block12_re,block12_re(24)])/4;
    

    
    
%     %% New aligh
%     mean_ac_interpolate=nanmean([[block01_ac,nan,nan,nan];[block02_ac,nan];[block03_ac,nan,nan,nan,nan];[block04_ac,nan,nan];...
%                                 block05_ac;[block06_ac,nan,nan,nan];[block07_ac,nan];[block08_ac,nan,nan,nan,nan,nan];...
%                                 [block09_ac,nan,nan,nan,nan,nan];[block10_ac,nan];[block11_ac,nan,nan];[block12_ac,nan,nan,nan,nan]]);
%     
%     mean_re_interpolate=nanmean([[block01_re,nan,nan];[block02_re,nan,nan,nan,nan];[block03_re,nan];[block04_re,nan,nan,nan];...
%                                 [block05_re,nan,nan,nan,nan,nan];[block06_re,nan,nan];[block07_re,nan,nan,nan,nan];[block08_re];...
%                                 [block09_re];[block10_re,nan,nan,nan,nan];[block11_re,nan,nan,nan];[block12_re,nan]]);
%     
%     
%     
%     mean_ac_interpolate_R1=nanmean([[block01_ac,nan,nan,nan];[block02_ac,nan];[block03_ac,nan,nan,nan,nan];[block04_ac,nan,nan]]);
%     mean_ac_interpolate_R2=nanmean([block05_ac;[block06_ac,nan,nan,nan];[block07_ac,nan];[block08_ac,nan,nan,nan,nan,nan]]);
%     mean_ac_interpolate_R3=nanmean([[block09_ac,nan,nan,nan,nan,nan];[block10_ac,nan];[block11_ac,nan,nan];[block12_ac,nan,nan,nan,nan]]);
%     
%     mean_re_interpolate_R1=nanmean([[block01_re,nan,nan];[block02_re,nan,nan,nan,nan];[block03_re,nan];[block04_re,nan,nan,nan]]);
%     mean_re_interpolate_R2=nanmean([[block05_re,nan,nan,nan,nan,nan];[block06_re,nan,nan];[block07_re,nan,nan,nan,nan];[block08_re]]);
%     mean_re_interpolate_R3=nanmean([[block09_re];[block10_re,nan,nan,nan,nan];[block11_re,nan,nan,nan];[block12_re,nan]]);
    
    
    
    %%
    
    mean_interpolate=[mean_ac_interpolate,mean_re_interpolate];
    mean_interpolate_R1=[mean_ac_interpolate_R1,mean_re_interpolate_R1];
    mean_interpolate_R2=[mean_ac_interpolate_R2,mean_re_interpolate_R2];
    mean_interpolate_R3=[mean_ac_interpolate_R3,mean_re_interpolate_R3];
    
    
    
    %Averaged propertion of correct
    for m=1:12
        Pro_correct_ac_naive=sum(response(1:10,m)==1|response(1:10,m)==4)/10;
        All_pro_correct_ac_naive(m)=Pro_correct_ac_naive;
    end

    
    All_pro_correct_ac_expert=[sum(response(13:22,1)==1|response(13:22,1)==4)/10,sum(response(15:24,2)==1|response(15:24,2)==4)/10,sum(response(12:21,3)==1|response(12:21,3)==4)/10,sum(response(14:23,4)==1|response(14:23,4)==4)/10,...
        sum(response(16:25,5)==1|response(16:25,5)==4)/10,sum(response(13:22,6)==1|response(13:22,6)==4)/10,sum(response(15:24,7)==1|response(15:24,7)==4)/10,sum(response(11:20,8)==1|response(11:20,8)==4)/10,...
        sum(response(11:20,9)==1|response(11:20,9)==4)/10,sum(response(15:24,10)==1|response(15:24,10)==4)/10,sum(response(14:23,11)==1|response(14:23,11)==4)/10,sum(response(12:21,12)==1|response(12:21,12)==4)/10];
    
    
    All_pro_correct_re_naive=[sum(response(23:32,1)==1|response(23:32,1)==4)/10,sum(response(25:34,2)==1|response(25:34,2)==4)/10,sum(response(22:31,3)==1|response(22:31,3)==4)/10,sum(response(24:33,4)==1|response(24:33,4)==4)/10,...
        sum(response(26:35,5)==1|response(26:35,5)==4)/10,sum(response(23:32,6)==1|response(23:32,6)==4)/10,sum(response(25:34,7)==1|response(25:34,7)==4)/10,sum(response(21:30,8)==1|response(21:30,8)==4)/10,...
        sum(response(21:30,9)==1|response(21:30,9)==4)/10,sum(response(25:34,10)==1|response(25:34,10)==4)/10,sum(response(24:33,11)==1|response(24:33,11)==4)/10,sum(response(22:31,12)==1|response(22:31,12)==4)/10];

    
    for m=1:12
        Pro_correct_re_expert=sum(response(36:45,m)==1|response(36:45,m)==4)/10;
        All_pro_correct_re_expert(m)=Pro_correct_re_expert;
    end
    
    %% mean of all subs
    
    All_mean_interpolate(i,:)=mean_interpolate;
    All_mean_interpolate_R1(i,:)=mean_interpolate_R1;
    All_mean_interpolate_R2(i,:)=mean_interpolate_R2;
    All_mean_interpolate_R3(i,:)=mean_interpolate_R3;
    
    
    Ac_naive(i,:)=mean(All_pro_correct_ac_naive);
    Ac_expert(i,:)=mean(All_pro_correct_ac_expert);
    Re_naive(i,:)=mean(All_pro_correct_re_naive);
    Re_expert(i,:)=mean(All_pro_correct_re_expert);
    
    if plot_individual
        
        %% plot figure
        figure1 = figure('Color',[1 1 1]);
        axes1 = axes('Parent',figure1);
        hold(axes1,'on');
        % Create axes
        plot(mean_interpolate,'LineWidth',2);
        hold on; plot([25,25],[0,0.7], 'LineWidth',2,'LineStyle','--',...
            'Color',[0.8 0.3 0])
        title(['Sub' num2str(sID,'%.2d'),': behavioral performance']);
        xlabel('Trial number','FontSize',14);
        ylabel('Proportion of correct response','FontSize',14);
        box(axes1,'on');
        % Set the remaining axes properties
        set(axes1,'FontSize',12);
        
        scrsz = get(0,'ScreenSize');
        outerpos = [0.3*scrsz(3),0.5*scrsz(4),0.2*scrsz(3),0.5*scrsz(4)];
        figure2 = figure('OuterPosition', outerpos,'Color',[1 1 1]);
        % Create axes
        subplot1=subplot(3,1,1);
        plot(mean_interpolate_R1,'LineWidth',2);
        hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
            'Color',[0.8 0.3 0]);
        ylim(subplot1,[0 0.8]);
        title(['Sub' num2str(sID,'%.2d'),'\_R1: behavioral performance']);
        set(subplot1,'FontSize',12);
        
        subplot2=subplot(3,1,2);
        plot(mean_interpolate_R2,'LineWidth',2);
        hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
            'Color',[0.8 0.3 0])
        ylim(subplot2,[0 0.8]);
        ylabel('Proportion of correct response','FontSize',14);
        title(['Sub' num2str(sID,'%.2d'),'\_R2: behavioral performance']);
        set(subplot2,'FontSize',12);
        
        subplot3=subplot(3,1,3);
        plot(mean_interpolate_R3,'LineWidth',2);
        hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
            'Color',[0.8 0.3 0])
        ylim(subplot3,[0 0.8]);
        title(['Sub' num2str(sID,'%.2d'),'\_R3: behavioral performance']);
        xlabel('Trial number','FontSize',14);
        % Set the remaining axes properties
        set(subplot3,'FontSize',12);
        
        
        %error bar
        l=0.427;
        x=[1-l/3 1+l/3 2-l/3 2+l/3 ];
        y=[mean(All_pro_correct_ac_naive) mean(All_pro_correct_ac_expert) mean(All_pro_correct_re_naive) mean(All_pro_correct_re_expert)];
        a=[mean(All_pro_correct_ac_naive) mean(All_pro_correct_ac_expert); mean(All_pro_correct_re_naive) mean(All_pro_correct_re_expert)];
        figure3 = figure('Color',[1 1 1]);
        b=bar(a,1,'group');
        %legend('Naive','Expert')
        E=(1/sqrt(size(All_pro_correct_ac_naive,2)).*[std(All_pro_correct_ac_naive) std(All_pro_correct_ac_expert) std(All_pro_correct_re_naive) std(All_pro_correct_re_expert)]);
        
        hold on
        set(gca,'XTickLabel',{'Learning','Reversal'},'FontSize',12);
        
        % hold on
        errorbar(x,y,E,'linestyle','none');
        title(['Sub' num2str(sID,'%.2d'),': mean behavioral performance']);
        
    end
    
end


if plot_mean
   
    % plot mean figures
    figure1 = figure('Color',[1 1 1]);
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');
    % Create axes
    x=[1:1:50];
    y=All_mean_interpolate;
    shadedErrorBar(x,y,{@mean,@std},'-r',1);
    %    plot(mean(All_mean_interpolate,1),'LineWidth',2);
    hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
        'Color',[0.8 0.3 0])
    title(['Mean behavioral performance']);
    xlabel('Trial number','FontSize',14)
    ylabel('Proportion of correct response','FontSize',14)
    ylim([0.1 0.8]);
    box(axes1,'on');
    % Set the remaining axes properties
    set(axes1,'FontSize',12);
    
    
    
    scrsz = get(0,'ScreenSize');
    outerpos = [0.3*scrsz(3),0.5*scrsz(4),0.2*scrsz(3),0.5*scrsz(4)];
    figure2 = figure('OuterPosition', outerpos,'Color',[1 1 1]);
    % Create axes
    subplot1=subplot(3,1,1);
    plot(mean(All_mean_interpolate_R1,1),'LineWidth',2);
    hold on; plot([25,25],[0,0.7], 'LineWidth',2,'LineStyle','--',...
        'Color',[0.8 0.3 0]);
    ylim(subplot1,[0 0.7]);
    title(['Mean behavioral performance\_R1']);
    set(subplot1,'FontSize',12);
    
    subplot2=subplot(3,1,2);
    plot(mean(All_mean_interpolate_R2,1),'LineWidth',2);
    hold on; plot([25,25],[0,0.7], 'LineWidth',2,'LineStyle','--',...
        'Color',[0.8 0.3 0])
    ylim(subplot2,[0 0.7]);
    ylabel('Proportion of correct response','FontSize',14);
    title(['Mean behavioral performance\_R2']);
    set(subplot2,'FontSize',12);
    
    subplot3=subplot(3,1,3);
    plot(mean(All_mean_interpolate_R3,1),'LineWidth',2);
    hold on; plot([25,25],[0,0.7], 'LineWidth',2,'LineStyle','--',...
        'Color',[0.8 0.3 0])
    ylim(subplot3,[0 0.7]);
    title(['Mean behavioral performance\_R3']);
    xlabel('Trial number','FontSize',14);
    % Set the remaining axes properties
    set(subplot3,'FontSize',12);
    
    
    %dot plot
    scrsz = get(0,'ScreenSize');
    outerpos = [0.5*scrsz(3),0.3*scrsz(4),0.55*scrsz(3),0.4*scrsz(4)];
    figure4 = figure('OuterPosition', outerpos,'Color',[1 1 1]);
    subplot4=subplot(1,3,1);
    hold(subplot4,'on');
    plot(Ac_naive,Ac_expert,'o','MarkerFaceColor',[0 0 0],'Color',[0 0 0]);
    hold on; plot([0.75,0],[0.75,0], 'LineWidth',1,'LineStyle','--',...
        'Color',[0 0 0])
    xlim(subplot4,[0.3 0.8]);
    ylim(subplot4,[0.3 0.8]);
    ylabel('Proportion of correct in last 10 trials (LE)','FontSize',10);
    xlabel('Proportion of correct in first 10 trials (LN)','FontSize',10);
    title(['Learning']);
    set(subplot4,'FontSize',12);
    
    subplot5=subplot(1,3,2);
    hold(subplot5,'on');
    plot(Re_naive,Re_expert,'o','MarkerFaceColor',[0 0 0],'Color',[0 0 0])
    hold on; plot([0.75,0],[0.75,0], 'LineWidth',1,'LineStyle','--',...
        'Color',[0 0 0])
    xlim(subplot5,[0.3 0.8]);
    ylim(subplot5,[0.3 0.8]);
    ylabel('Proportion of correct in last 10 trials (RE)','FontSize',10);
    xlabel('Proportion of correct in first 10 trials (RN)','FontSize',10);
    title(['Reversal']);
    set(subplot5,'FontSize',12);
    
    %boxplot
    subplot6=subplot(1,3,3);
    hold(subplot6,'on');
    
    boxplot([Ac_naive,Ac_expert,Re_naive,Re_expert])
    
      %error bar    
%     l=0.427;
%     x=[1-l/3 1+l/3 2-l/3 2+l/3];
%     y=[mean(Ac_naive) mean(Ac_expert) mean(Re_naive) mean(Re_expert)];
%     a=[mean(Ac_naive) mean(Ac_expert); mean(Re_naive) mean(Re_expert)];
%     bar1=bar(a,1,'group');
%     hold on
%     set(bar1(1),...
%         'FaceColor',[0.8 0.8 0.8]);
%     set(bar1(2),...
%         'FaceColor',[0.5 0.5 0.5]);
%     set(subplot6,'XTick',[0.86 1.15 1.86 2.15],'XTickLabel',{'LN','LE','RN','RE'});
%     %legend('Naive','Expert')
%     
%     E=(1/sqrt(size(Ac_naive,2)).*[std(Ac_naive) std(Ac_expert) std(Re_naive) std(Re_expert)]);
%     errorbar(x,y,E,'linestyle','none','LineWidth',1,'Color',[0 0 0]);
    title(['Mean behavioral performance']);
    set(subplot6,'FontSize',12);
    
end