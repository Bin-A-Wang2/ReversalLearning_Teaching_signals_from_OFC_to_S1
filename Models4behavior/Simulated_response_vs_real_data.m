

clear all

Subjects=[2 3 4 5 7 8 11 12 13 14 15 16 17 18 19 20 22 23 26 27 28 29 31 32 33 34 35 36 37 38 39 40]; %% good subjects

RootDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Participants\'];
LogDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Logfile\'];
sim_times=100;


for i = 1:length(Subjects)
    sID=Subjects(i);
    Result=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_all.txt']);
    
    response=[];
    for n=1:floor(length(Result.data)/45)
        response=[response,Result.data(45*(n-1)+1:45*(n-1)+45,7)];%%Extract values of every 45 lines(1 block) to Response
    end
    
    load([RootDir,'Sub' num2str(sID,'%.2d'),'\Results_HGF_2level.mat']);
    
    for s=1:sim_times
    
     for  m=1:12
         
         u=est_obs_all{1, m}.u; 
        
            %simulated using HGF
            bopars_HGF = tapas_fitModel( [],...
                u,...
                'tapas_hgf_binary_config_2levels_2',...
                'tapas_bayes_optimal_binary_config',...
                'tapas_quasinewton_optim_config');
            %Simulate responses
            sim_HGF = tapas_simModel(u,...
                'tapas_hgf_binary',...
                bopars_HGF.p_prc.p,...
                'tapas_unitsq_sgm',...
                10);
            
            correctness=abs(sim_HGF.y-sim_HGF.u);%0 correct; 1 wrong
            correctness(correctness==0)=3;
            correctness(correctness==1)=0;
            correctness(correctness==3)=1;
            response_HGF(:,m) = correctness;%1 correct; 0 wrong  
    end % end of 12 blocks
    
    
    %RUN1
    %block1
    for j=1:22
        block01_ac(j)=sum(response(1:j,1)==1|response(1:j,1)==4)/j;
        block01_ac_HGF(j)=sum(response_HGF(1:j,1)==1)/j;
    end
    for j=1:23
        block01_re(j)=sum(response(23:22+j,1)==1|response(23:22+j,1)==4)/j;
        block01_re_HGF(j)=sum(response_HGF(23:22+j,1)==1)/j;
    end
    %block2
    for j=1:24
        block02_ac(j)=sum(response(1:j,2)==1|response(1:j,2)==4)/j;
        block02_ac_HGF(j)=sum(response_HGF(1:j,2)==1)/j;
    end
    for j=1:21
        block02_re(j)=sum(response(25:24+j,2)==1|response(25:24+j,2)==4)/j;
        block02_re_HGF(j)=sum(response_HGF(25:24+j,2)==1)/j;
    end
    
    %block3
    for j=1:21
        block03_ac(j)=sum(response(1:j,3)==1|response(1:j,3)==4)/j;
        block03_ac_HGF(j)=sum(response_HGF(1:j,3)==1)/j;
    end
    for j=1:24
        block03_re(j)=sum(response(22:21+j,3)==1|response(22:21+j,3)==4)/j;
        block03_re_HGF(j)=sum(response_HGF(22:21+j,3)==1)/j;
    end
    
    %block4
    for j=1:23
        block04_ac(j)=sum(response(1:j,4)==1|response(1:j,4)==4)/j;
        block04_ac_HGF(j)=sum(response_HGF(1:j,4)==1)/j;
    end
    for j=1:22
        block04_re(j)=sum(response(24:23+j,4)==1|response(24:23+j,4)==4)/j;
        block04_re_HGF(j)=sum(response_HGF(24:23+j,4)==1)/j;
    end
    
    
    %RUN2
    %block1
    for j=1:25
        block05_ac(j)=sum(response(1:j,5)==1|response(1:j,5)==4)/j;
        block05_ac_HGF(j)=sum(response_HGF(1:j,5)==1)/j;
    end
    for j=1:20
        block05_re(j)=sum(response(26:25+j,5)==1|response(26:25+j,5)==4)/j;
        block05_re_HGF(j)=sum(response_HGF(26:25+j,5)==1)/j;
    end
    %block2
    for j=1:22
        block06_ac(j)=sum(response(1:j,6)==1|response(1:j,6)==4)/j;
        block06_ac_HGF(j)=sum(response_HGF(1:j,6)==1)/j;
    end
    for j=1:23
        block06_re(j)=sum(response(23:22+j,6)==1|response(23:22+j,6)==4)/j;
        block06_re_HGF(j)=sum(response_HGF(23:22+j,6)==1)/j;
    end
    
    %block3
    for j=1:24
        block07_ac(j)=sum(response(1:j,7)==1|response(1:j,7)==4)/j;
        block07_ac_HGF(j)=sum(response_HGF(1:j,7)==1)/j;
    end
    for j=1:21
        block07_re(j)=sum(response(25:24+j,7)==1|response(25:24+j,7)==4)/j;
        block07_re_HGF(j)=sum(response_HGF(25:24+j,7)==1)/j;
    end
    
    %block4
    for j=1:20
        block08_ac(j)=sum(response(1:j,8)==1|response(1:j,8)==4)/j;
        block08_ac_HGF(j)=sum(response_HGF(1:j,8)==1)/j;
    end
    for j=1:25
        block08_re(j)=sum(response(21:20+j,8)==1|response(21:20+j,8)==4)/j;
        block08_re_HGF(j)=sum(response_HGF(21:20+j,8)==1)/j;
    end
    
    
    
    %block1
    for j=1:20
        block09_ac(j)=sum(response(1:j,9)==1|response(1:j,9)==4)/j;
        block09_ac_HGF(j)=sum(response_HGF(1:j,9)==1)/j;
    end
    for j=1:25
        block09_re(j)=sum(response(21:20+j,9)==1|response(21:20+j,9)==4)/j;
        block09_re_HGF(j)=sum(response_HGF(21:20+j,9)==1)/j;
    end
    %block2
    for j=1:24
        block10_ac(j)=sum(response(1:j,10)==1|response(1:j,10)==4)/j;
        block10_ac_HGF(j)=sum(response_HGF(1:j,10)==1)/j;
    end
    for j=1:21
        block10_re(j)=sum(response(25:24+j,10)==1|response(25:24+j,10)==4)/j;
        block10_re_HGF(j)=sum(response_HGF(25:24+j,10)==1)/j;
    end
    
    %block3
    for j=1:23
        block11_ac(j)=sum(response(1:j,11)==1|response(1:j,11)==4)/j;
        block11_ac_HGF(j)=sum(response_HGF(1:j,11)==1)/j;
    end
    for j=1:22
        block11_re(j)=sum(response(24:23+j,11)==1|response(24:23+j,11)==4)/j;
        block11_re_HGF(j)=sum(response_HGF(24:23+j,11)==1)/j;
    end
    
    %block4
    for j=1:21
        block12_ac(j)=sum(response(1:j,12)==1|response(1:j,12)==4)/j;
        block12_ac_HGF(j)=sum(response_HGF(1:j,12)==1)/j;
    end
    for j=1:24
        block12_re(j)=sum(response(22:21+j,12)==1|response(22:21+j,12)==4)/j;
        block12_re_HGF(j)=sum(response_HGF(22:21+j,12)==1)/j;
    end
    
    

    
    %Interpolate&Align
    mean_ac_interpolate=([block01_ac,block01_ac(22),block01_ac(22),block01_ac(22)]+[block02_ac,block02_ac(24)]+[block03_ac,block03_ac(21),block03_ac(21),block03_ac(21),block03_ac(21)]+[block04_ac,block04_ac(23),block04_ac(23)]...
        +block05_ac+[block06_ac,block06_ac(22),block06_ac(22),block06_ac(22)]+[block07_ac,block07_ac(24)]+[block08_ac,block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20),block08_ac(20)]...
        +[block09_ac,block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20)]+[block10_ac,block10_ac(24)]+[block11_ac,block11_ac(23),block11_ac(23)]+[block12_ac,block12_ac(21),block12_ac(21),block12_ac(21),block12_ac(21)])/12;
    
    mean_re_interpolate=([block01_re,block01_re(23),block01_re(23)]+[block02_re,block02_re(21),block02_re(21),block02_re(21),block02_re(21)]+[block03_re,block03_re(24)]+[block04_re,block04_re(22),block04_re(22),block04_re(22)]...
        +[block05_re,block05_re(20),block05_re(20),block05_re(20),block05_re(20),block05_re(20)]+[block06_re,block06_re(23),block06_re(23)]+[block07_re,block07_re(21),block07_re(21),block07_re(21),block07_re(21)]+[block08_re]...
        +[block09_re]+[block10_re,block10_re(21),block10_re(21),block10_re(21),block10_re(21)]+[block11_re,block11_re(22),block11_re(22),block11_re(22)]+[block12_re,block12_re(24)])/12;
    
    %Interpolate&Align of HGF simulated response
    mean_ac_HGF_interpolate=([block01_ac_HGF,block01_ac_HGF(22),block01_ac_HGF(22),block01_ac_HGF(22)]+[block02_ac_HGF,block02_ac_HGF(24)]+[block03_ac_HGF,block03_ac_HGF(21),block03_ac_HGF(21),block03_ac_HGF(21),block03_ac_HGF(21)]+[block04_ac_HGF,block04_ac_HGF(23),block04_ac_HGF(23)]...
        +block05_ac_HGF+[block06_ac_HGF,block06_ac_HGF(22),block06_ac_HGF(22),block06_ac_HGF(22)]+[block07_ac_HGF,block07_ac_HGF(24)]+[block08_ac_HGF,block08_ac_HGF(20),block08_ac_HGF(20),block08_ac_HGF(20),block08_ac_HGF(20),block08_ac_HGF(20)]...
        +[block09_ac_HGF,block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20)]+[block10_ac_HGF,block10_ac_HGF(24)]+[block11_ac_HGF,block11_ac_HGF(23),block11_ac_HGF(23)]+[block12_ac_HGF,block12_ac_HGF(21),block12_ac_HGF(21),block12_ac_HGF(21),block12_ac_HGF(21)])/12;
    
    mean_re_HGF_interpolate=([block01_re_HGF,block01_re_HGF(23),block01_re_HGF(23)]+[block02_re_HGF,block02_re_HGF(21),block02_re_HGF(21),block02_re_HGF(21),block02_re_HGF(21)]+[block03_re_HGF,block03_re_HGF(24)]+[block04_re_HGF,block04_re_HGF(22),block04_re_HGF(22),block04_re_HGF(22)]...
        +[block05_re_HGF,block05_re_HGF(20),block05_re_HGF(20),block05_re_HGF(20),block05_re_HGF(20),block05_re_HGF(20)]+[block06_re_HGF,block06_re_HGF(23),block06_re_HGF(23)]+[block07_re_HGF,block07_re_HGF(21),block07_re_HGF(21),block07_re_HGF(21),block07_re_HGF(21)]+[block08_re_HGF]...
        +[block09_re_HGF]+[block10_re_HGF,block10_re_HGF(21),block10_re_HGF(21),block10_re_HGF(21),block10_re_HGF(21)]+[block11_re_HGF,block11_re_HGF(22),block11_re_HGF(22),block11_re_HGF(22)]+[block12_re_HGF,block12_re_HGF(24)])/12;
   
    %
    mean_interpolate=[mean_ac_interpolate,mean_re_interpolate]; %real data
    mean_interpolate_HGF=[mean_ac_HGF_interpolate,mean_re_HGF_interpolate]; %simulated response from HGF
    
    
    mean_interpolate_HGF_allsimulations(s,:)=mean_interpolate_HGF;
    
    end % end of stimulation time

    % mean of all subs
    All_mean_interpolate(i,:)=mean_interpolate;   
    All_mean_interpolate_HGF(i,:)= mean(mean_interpolate_HGF_allsimulations);  
    
    
end% end of subjects
save([RootDir,'\Simulated response vs real data.mat'], 'All_mean_interpolate', 'All_mean_interpolate_HGF');

   
% plot mean figures
figure1 = figure('Color',[1 1 1]);
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create axes
x=[1:1:50];
y1=All_mean_interpolate;
y2=All_mean_interpolate_HGF;
shadedErrorBar(x,y1,{@mean,@std},'-r',1);
%    plot(mean(All_mean_interpolate,1),'LineWidth',2);
hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
    'Color',[0.8 0.3 0])
hold on; shadedErrorBar(x,y2,{@mean,@std},'-b',1);
title(['Mean behavioral performance']);
xlabel('Trial number','FontSize',14)
ylabel('Proportion of correct response','FontSize',14)
ylim([0.1 0.8]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',12);

    
