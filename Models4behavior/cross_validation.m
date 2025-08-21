

clear all

Subjects=[2 3 4 5 7 8 11 12 13 14 15 16 17 18 19 20 22 23 26 27 28 29 31 32 33 34 35 36 37 38 39 40]; %% good subjects

RootDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Participants\'];
LogDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Logfile\'];

load('D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Participants\Cross_valisationt_LME_omega_zeta.mat')
Omega_train=mean(mean(sample1_omega));
zeta_train=mean(mean(sample1_zeta));


%simulate the response based on the parameters from the train data 
load([RootDir,'Sub02\Results_HGF_2level.mat']);
for  m=9:12 %blocks
    
    u=est_obs_all{1, m}.u;
    
    %Simulate responses using the parameters from train data
    sim_HGF = tapas_simModel(u,...
        'tapas_hgf_binary',...
        [NaN 0 1 NaN 1 1 NaN 0 0 1 1 NaN Omega_train 0],...
        'tapas_unitsq_sgm',...
        zeta_train);
    
    correctness=abs(sim_HGF.y-sim_HGF.u);%0 correct; 1 wrong
    correctness(correctness==0)=3;
    correctness(correctness==1)=0;
    correctness(correctness==3)=1;
    sim_response_HGF(:,m-8) = correctness;%1 correct; 0 wrong
end % end of 4 blocks in the test data (3rd run)

%RUN3
%block1
for j=1:20
    block09_ac_HGF(j)=sum(sim_response_HGF(1:j,1)==1)/j;
end
for j=1:25
    block09_re_HGF(j)=sum(sim_response_HGF(21:20+j,1)==1)/j;
end
%block2
for j=1:24
    block10_ac_HGF(j)=sum(sim_response_HGF(1:j,2)==1)/j;
end
for j=1:21
    block10_re_HGF(j)=sum(sim_response_HGF(25:24+j,2)==1)/j;
end

%block3
for j=1:23
    block11_ac_HGF(j)=sum(sim_response_HGF(1:j,3)==1)/j;
end
for j=1:22
    block11_re_HGF(j)=sum(sim_response_HGF(24:23+j,3)==1)/j;
end

%block4
for j=1:21
    block12_ac_HGF(j)=sum(sim_response_HGF(1:j,4)==1)/j;
end
for j=1:24
    block12_re_HGF(j)=sum(sim_response_HGF(22:21+j,4)==1)/j;
end


%Interpolate&Align of HGF simulated response
mean_ac_HGF_interpolate=([block09_ac_HGF,block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20),block09_ac_HGF(20)]+[block10_ac_HGF,block10_ac_HGF(24)]+[block11_ac_HGF,block11_ac_HGF(23),block11_ac_HGF(23)]+[block12_ac_HGF,block12_ac_HGF(21),block12_ac_HGF(21),block12_ac_HGF(21),block12_ac_HGF(21)])/4;

mean_re_HGF_interpolate=([block09_re_HGF]+[block10_re_HGF,block10_re_HGF(21),block10_re_HGF(21),block10_re_HGF(21),block10_re_HGF(21)]+[block11_re_HGF,block11_re_HGF(22),block11_re_HGF(22),block11_re_HGF(22)]+[block12_re_HGF,block12_re_HGF(24)])/4;

%
mean_interpolate_HGF=[mean_ac_HGF_interpolate,mean_re_HGF_interpolate]; %simulated response from HGF


%the real response in 3rd RUN    
for i = 1:length(Subjects)
    sID=Subjects(i);
    Result=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_all.txt']);
    
    response=[];
    for n=1:floor(length(Result.data)/45)
        response=[response,Result.data(45*(n-1)+1:45*(n-1)+45,7)];%%Extract values of every 45 lines(1 block) to Response
    end
    All_real_response{i,:}=response(:,9:12);
    
    %RUN3
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
    
    %Interpolate&Align
    mean_ac_interpolate=([block09_ac,block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20),block09_ac(20)]+[block10_ac,block10_ac(24)]+[block11_ac,block11_ac(23),block11_ac(23)]+[block12_ac,block12_ac(21),block12_ac(21),block12_ac(21),block12_ac(21)])/4;
    
    mean_re_interpolate=([block09_re]+[block10_re,block10_re(21),block10_re(21),block10_re(21),block10_re(21)]+[block11_re,block11_re(22),block11_re(22),block11_re(22)]+[block12_re,block12_re(24)])/4;
    
    %
    mean_interpolate=[mean_ac_interpolate,mean_re_interpolate]; %real data
        

    % mean of all subs
    All_mean_interpolate(i,:)=mean_interpolate;       
    
end% end of subjects

save([RootDir,'\Simulated response vs real data_cross validation.mat'], 'All_real_response','All_mean_interpolate_real', 'mean_interpolate_HGF','sim_response_HGF');

   
% plot mean figures
figure1 = figure('Color',[1 1 1]);
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% Create axes
x=[1:1:50];
y1=All_mean_interpolate;
y2=mean_interpolate_HGF;
shadedErrorBar(x,y1,{@mean,@std},'-r',1);
%    plot(mean(All_mean_interpolate,1),'LineWidth',2);
hold on; plot([25,25],[0,0.8], 'LineWidth',2,'LineStyle','--',...
    'Color',[0.8 0.3 0])
hold on; 
%shadedErrorBar(x,y2,{@mean,@std},'-b',1);
plot(x,mean_interpolate_HGF);
title(['Mean behavioral performance']);
xlabel('Trial number','FontSize',14)
ylabel('Proportion of correct response','FontSize',14)
ylim([0.1 0.8]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',12);

    
%% calculate the accuracy 
for i=1:length(Subjects) % subjects
    
    for j=1:4 % 4 blocks        

        a=sim_response_HGF(:,j);
        b=All_real_response{i, 1}(:,j);
        b(b==1|b==4)=1;
        b(b==2|b==3|b==5)=0;
        
        x=a-b;
        Accuracy=sum(x==0)/length(x);
        Accuracy_allblocks(:,j)=Accuracy; 
    end

     All_Accuracy(i,:)=Accuracy_allblocks;
end

figure;h1=boxplot(All_Accuracy);
set(h1,'Linewidth',1.5)


