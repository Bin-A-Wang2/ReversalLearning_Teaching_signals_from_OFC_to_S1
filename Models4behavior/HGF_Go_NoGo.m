function  HGF_Go_NoGo(RootDir,Subjects)
% Run HGF and save the parameters in Results_HGF.mat
%
% OUTPUT:
%     Results_HGF.mat: including 'Result', 'sim','est_obs','modulator', 'all_R1', 'all_PE_R1', 'all_NoPE_R1', 'all_UP_R1', 'all_DOWN_R1',...
%                                'all_R2', 'all_PE_R2','all_NoPE_R2', 'all_UP_R2', 'all_DOWN_R2', 'all_R3', 'all_PE_R3','all_NoPE_R3','all_UP_R3', 'all_DOWN_R3'
%
%  Edit by Bin Wang 07/09/2015 Bochum
%--------------------------------------------------------------------------


%clear all
%close all

plot_indiidual_fig                = false;
plot_averaged_fig                = false;

%% Run HGF

rng('default')
LogDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Logfile\'];
for i = 1:length(Subjects)
    sID=Subjects(i);
    outputDir=[RootDir,'Results_OFC_S1\Participants\','Sub',num2str(sID,'%.2d')];
    
   
    Result_R1=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_R1.txt']);
    Result_R2=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_R2.txt']);
    Result_R3=importdata([LogDir,'Sub' num2str(sID,'%.2d') '_RL_Go_NoGo_results_R3.txt']);

    %RUN1
    u_block01=Result_R1.data(Result_R1.data(:,2)==1,3);
    u_block01(u_block01==2)=0;
    u_block01(u_block01==4)=0;
    u_block01(u_block01==3)=1; %1,3->1; 2,4->0
    
    u_block02=Result_R1.data(Result_R1.data(:,2)==2,3);
    u_block02(u_block02==1)=0;
    u_block02(u_block02==3)=0;
    u_block02(u_block02==2)=1;
    u_block02(u_block02==4)=1; %1,3->0; 2,4->1  
    
    u_block03=Result_R1.data(Result_R1.data(:,2)==3,3);
    u_block03(u_block03==2)=0;
    u_block03(u_block03==4)=0;
    u_block03(u_block03==3)=1; %1,3->1; 2,4->0
    
    u_block04=Result_R1.data(Result_R1.data(:,2)==4,3);
    u_block04(u_block04==1)=0;
    u_block04(u_block04==3)=0;
    u_block04(u_block04==2)=1;
    u_block04(u_block04==4)=1; %1,3->0; 2,4->1  
    
    %RUN2
    u_block05=Result_R2.data(Result_R2.data(:,2)==1,3);
    u_block05(u_block05==2)=0;
    u_block05(u_block05==4)=0;
    u_block05(u_block05==3)=1; %1,3->1; 2,4->0
    
    u_block06=Result_R2.data(Result_R2.data(:,2)==2,3);
    u_block06(u_block06==1)=0;
    u_block06(u_block06==3)=0;
    u_block06(u_block06==2)=1;
    u_block06(u_block06==4)=1; %1,3->0; 2,4->1  
    
    u_block07=Result_R2.data(Result_R2.data(:,2)==3,3);
    u_block07(u_block07==2)=0;
    u_block07(u_block07==4)=0;
    u_block07(u_block07==3)=1; %1,3->1; 2,4->0
    
    u_block08=Result_R2.data(Result_R2.data(:,2)==4,3);
    u_block08(u_block08==1)=0;
    u_block08(u_block08==3)=0;
    u_block08(u_block08==2)=1;
    u_block08(u_block08==4)=1; %1,3->0; 2,4->1      
    
    %RUN3
    u_block09=Result_R3.data(Result_R3.data(:,2)==1,3);
    u_block09(u_block09==2)=0;
    u_block09(u_block09==4)=0;
    u_block09(u_block09==3)=1; %1,3->1; 2,4->0
    
    u_block10=Result_R3.data(Result_R3.data(:,2)==2,3);
    u_block10(u_block10==1)=0;
    u_block10(u_block10==3)=0;
    u_block10(u_block10==2)=1;
    u_block10(u_block10==4)=1; %1,3->0; 2,4->1  
    
    u_block11=Result_R3.data(Result_R3.data(:,2)==3,3);
    u_block11(u_block11==2)=0;
    u_block11(u_block11==4)=0;
    u_block11(u_block11==3)=1; %1,3->1; 2,4->0
    
    u_block12=Result_R3.data(Result_R3.data(:,2)==4,3);
    u_block12(u_block12==1)=0;
    u_block12(u_block12==3)=0;
    u_block12(u_block12==2)=1;
    u_block12(u_block12==4)=1; %1,3->0; 2,4->1         
    
    %Response
    %RUN1
    value_block01=Result_R1.data(Result_R1.data(:,2)==1,[3,7]);
    value_block01((value_block01(:,1)==1&value_block01(:,2)==1),3)=1;
    value_block01((value_block01(:,1)==1&value_block01(:,2)==3),3)=0;
    value_block01((value_block01(:,1)==2&value_block01(:,2)==2),3)=1;
    value_block01((value_block01(:,1)==2&value_block01(:,2)==4),3)=0;
    value_block01((value_block01(:,1)==3&value_block01(:,2)==2),3)=0;
    value_block01((value_block01(:,1)==3&value_block01(:,2)==4),3)=1;
    value_block01((value_block01(:,1)==4&value_block01(:,2)==1),3)=0;
    value_block01((value_block01(:,1)==4&value_block01(:,2)==3),3)=1;
    value_block01((value_block01(:,2)==5),3)=NaN;

    value_block02=Result_R1.data(Result_R1.data(:,2)==2,[3,7]);
    value_block02((value_block02(:,1)==1&value_block02(:,2)==1),3)=0;
    value_block02((value_block02(:,1)==1&value_block02(:,2)==3),3)=1;
    value_block02((value_block02(:,1)==2&value_block02(:,2)==2),3)=0;
    value_block02((value_block02(:,1)==2&value_block02(:,2)==4),3)=1;
    value_block02((value_block02(:,1)==3&value_block02(:,2)==2),3)=1;
    value_block02((value_block02(:,1)==3&value_block02(:,2)==4),3)=0;
    value_block02((value_block02(:,1)==4&value_block02(:,2)==1),3)=1;
    value_block02((value_block02(:,1)==4&value_block02(:,2)==3),3)=0;
    value_block02((value_block02(:,2)==5),3)=NaN;

    value_block03=Result_R1.data(Result_R1.data(:,2)==3,[3,7]);
    value_block03((value_block03(:,1)==1&value_block03(:,2)==1),3)=1;
    value_block03((value_block03(:,1)==1&value_block03(:,2)==3),3)=0;
    value_block03((value_block03(:,1)==2&value_block03(:,2)==2),3)=1;
    value_block03((value_block03(:,1)==2&value_block03(:,2)==4),3)=0;
    value_block03((value_block03(:,1)==3&value_block03(:,2)==2),3)=0;
    value_block03((value_block03(:,1)==3&value_block03(:,2)==4),3)=1;
    value_block03((value_block03(:,1)==4&value_block03(:,2)==1),3)=0;
    value_block03((value_block03(:,1)==4&value_block03(:,2)==3),3)=1;
    value_block03((value_block03(:,2)==5),3)=NaN;

    value_block04=Result_R1.data(Result_R1.data(:,2)==4,[3,7]);
    value_block04((value_block04(:,1)==1&value_block04(:,2)==1),3)=0;
    value_block04((value_block04(:,1)==1&value_block04(:,2)==3),3)=1;
    value_block04((value_block04(:,1)==2&value_block04(:,2)==2),3)=0;
    value_block04((value_block04(:,1)==2&value_block04(:,2)==4),3)=1;
    value_block04((value_block04(:,1)==3&value_block04(:,2)==2),3)=1;
    value_block04((value_block04(:,1)==3&value_block04(:,2)==4),3)=0;
    value_block04((value_block04(:,1)==4&value_block04(:,2)==1),3)=1;
    value_block04((value_block04(:,1)==4&value_block04(:,2)==3),3)=0;
    value_block04((value_block04(:,2)==5),3)=NaN;
   
    %RUN2
    value_block05=Result_R2.data(Result_R2.data(:,2)==1,[3,7]);
    value_block05((value_block05(:,1)==1&value_block05(:,2)==1),3)=1;
    value_block05((value_block05(:,1)==1&value_block05(:,2)==3),3)=0;
    value_block05((value_block05(:,1)==2&value_block05(:,2)==2),3)=1;
    value_block05((value_block05(:,1)==2&value_block05(:,2)==4),3)=0;
    value_block05((value_block05(:,1)==3&value_block05(:,2)==2),3)=0;
    value_block05((value_block05(:,1)==3&value_block05(:,2)==4),3)=1;
    value_block05((value_block05(:,1)==4&value_block05(:,2)==1),3)=0;
    value_block05((value_block05(:,1)==4&value_block05(:,2)==3),3)=1;
    value_block05((value_block05(:,2)==5),3)=NaN;
    value_block05((value_block05(:,2)==5),3)=NaN;

    value_block06=Result_R2.data(Result_R2.data(:,2)==2,[3,7]);
    value_block06((value_block06(:,1)==1&value_block06(:,2)==1),3)=0;
    value_block06((value_block06(:,1)==1&value_block06(:,2)==3),3)=1;
    value_block06((value_block06(:,1)==2&value_block06(:,2)==2),3)=0;
    value_block06((value_block06(:,1)==2&value_block06(:,2)==4),3)=1;
    value_block06((value_block06(:,1)==3&value_block06(:,2)==2),3)=1;
    value_block06((value_block06(:,1)==3&value_block06(:,2)==4),3)=0;
    value_block06((value_block06(:,1)==4&value_block06(:,2)==1),3)=1;
    value_block06((value_block06(:,1)==4&value_block06(:,2)==3),3)=0;
    value_block06((value_block06(:,2)==5),3)=NaN;

    value_block07=Result_R2.data(Result_R2.data(:,2)==3,[3,7]);
    value_block07((value_block07(:,1)==1&value_block07(:,2)==1),3)=1;
    value_block07((value_block07(:,1)==1&value_block07(:,2)==3),3)=0;
    value_block07((value_block07(:,1)==2&value_block07(:,2)==2),3)=1;
    value_block07((value_block07(:,1)==2&value_block07(:,2)==4),3)=0;
    value_block07((value_block07(:,1)==3&value_block07(:,2)==2),3)=0;
    value_block07((value_block07(:,1)==3&value_block07(:,2)==4),3)=1;
    value_block07((value_block07(:,1)==4&value_block07(:,2)==1),3)=0;
    value_block07((value_block07(:,1)==4&value_block07(:,2)==3),3)=1;
    value_block07((value_block07(:,2)==5),3)=NaN;
    
    value_block08=Result_R2.data(Result_R2.data(:,2)==4,[3,7]);
    value_block08((value_block08(:,1)==1&value_block08(:,2)==1),3)=0;
    value_block08((value_block08(:,1)==1&value_block08(:,2)==3),3)=1;
    value_block08((value_block08(:,1)==2&value_block08(:,2)==2),3)=0;
    value_block08((value_block08(:,1)==2&value_block08(:,2)==4),3)=1;
    value_block08((value_block08(:,1)==3&value_block08(:,2)==2),3)=1;
    value_block08((value_block08(:,1)==3&value_block08(:,2)==4),3)=0;
    value_block08((value_block08(:,1)==4&value_block08(:,2)==1),3)=1;
    value_block08((value_block08(:,1)==4&value_block08(:,2)==3),3)=0;
    value_block08((value_block08(:,2)==5),3)=NaN;
   
    
    %RUN3
    value_block09=Result_R3.data(Result_R3.data(:,2)==1,[3,7]);
    value_block09((value_block09(:,1)==1&value_block09(:,2)==1),3)=1;
    value_block09((value_block09(:,1)==1&value_block09(:,2)==3),3)=0;
    value_block09((value_block09(:,1)==2&value_block09(:,2)==2),3)=1;
    value_block09((value_block09(:,1)==2&value_block09(:,2)==4),3)=0;
    value_block09((value_block09(:,1)==3&value_block09(:,2)==2),3)=0;
    value_block09((value_block09(:,1)==3&value_block09(:,2)==4),3)=1;
    value_block09((value_block09(:,1)==4&value_block09(:,2)==1),3)=0;
    value_block09((value_block09(:,1)==4&value_block09(:,2)==3),3)=1;
    value_block09((value_block09(:,2)==5),3)=NaN;

    value_block10=Result_R3.data(Result_R3.data(:,2)==2,[3,7]);
    value_block10((value_block10(:,1)==1&value_block10(:,2)==1),3)=0;
    value_block10((value_block10(:,1)==1&value_block10(:,2)==3),3)=1;
    value_block10((value_block10(:,1)==2&value_block10(:,2)==2),3)=0;
    value_block10((value_block10(:,1)==2&value_block10(:,2)==4),3)=1;
    value_block10((value_block10(:,1)==3&value_block10(:,2)==2),3)=1;
    value_block10((value_block10(:,1)==3&value_block10(:,2)==4),3)=0;
    value_block10((value_block10(:,1)==4&value_block10(:,2)==1),3)=1;
    value_block10((value_block10(:,1)==4&value_block10(:,2)==3),3)=0;
    value_block10((value_block10(:,2)==5),3)=NaN;

    value_block11=Result_R3.data(Result_R3.data(:,2)==3,[3,7]);
    value_block11((value_block11(:,1)==1&value_block11(:,2)==1),3)=1;
    value_block11((value_block11(:,1)==1&value_block11(:,2)==3),3)=0;
    value_block11((value_block11(:,1)==2&value_block11(:,2)==2),3)=1;
    value_block11((value_block11(:,1)==2&value_block11(:,2)==4),3)=0;
    value_block11((value_block11(:,1)==3&value_block11(:,2)==2),3)=0;
    value_block11((value_block11(:,1)==3&value_block11(:,2)==4),3)=1;
    value_block11((value_block11(:,1)==4&value_block11(:,2)==1),3)=0;
    value_block11((value_block11(:,1)==4&value_block11(:,2)==3),3)=1;
    value_block11((value_block11(:,2)==5),3)=NaN;
    
    value_block12=Result_R3.data(Result_R3.data(:,2)==4,[3,7]);
    value_block12((value_block12(:,1)==1&value_block12(:,2)==1),3)=0;
    value_block12((value_block12(:,1)==1&value_block12(:,2)==3),3)=1;
    value_block12((value_block12(:,1)==2&value_block12(:,2)==2),3)=0;
    value_block12((value_block12(:,1)==2&value_block12(:,2)==4),3)=1;
    value_block12((value_block12(:,1)==3&value_block12(:,2)==2),3)=1;
    value_block12((value_block12(:,1)==3&value_block12(:,2)==4),3)=0;
    value_block12((value_block12(:,1)==4&value_block12(:,2)==1),3)=1;
    value_block12((value_block12(:,1)==4&value_block12(:,2)==3),3)=0;
    value_block12((value_block12(:,2)==5),3)=NaN;
    
    u_all=[u_block01,u_block02,u_block03,u_block04,u_block05,u_block06,u_block07,u_block08,u_block09,u_block10,u_block11,u_block12];
    y_all=[value_block01(:,3),value_block02(:,3),value_block03(:,3),value_block04(:,3),value_block05(:,3),value_block06(:,3),...
           value_block07(:,3),value_block08(:,3),value_block09(:,3),value_block10(:,3),value_block11(:,3),value_block12(:,3)];
       
       
       

    for j=1:12
                
        % Fit perceptual (tapas_hgf_binary_config) and observation models
        % (tapas_unitsq_sgm_config) to observed responses (2 levels)
        est_obs = tapas_fitModel(y_all(:,j),...
                                 u_all(:,j),...
                                'tapas_hgf_binary_config_2levels_2',...
                                'tapas_unitsq_sgm_config',...
                                'tapas_quasinewton_optim_config');
    
        est_obs_all(j)={est_obs};
        
        % alpha1(mu1hat,conditional probability) all >0.5
        mu1hat_all(:,j)=est_obs_all{1,j}.traj.muhat(:,1); 
     %   index=find(mu1hat_all(:,j)<0.5);
     %   mu1hat_all(index,j)=1-mu1hat_all(index,j);
        
        % alpha2(mu2hat,prior belief) all > 0
        mu2hat_all(:,j)=est_obs_all{1,j}.traj.muhat(:,2); 
        mu2hat_all(:,j)=abs( mu2hat_all(:,j));
             
        
    end
    
    if exist([outputDir,'\Results_HGF_2level.mat'],'file')~=2
       save([outputDir,'\Results_HGF_2level.mat'], 'est_obs_all');
    end
    
    %Interpolate (mu1hat)
    All_mu1hat_interpolate= [[mu1hat_all(1:22,1);mu1hat_all(22,1);mu1hat_all(22,1);mu1hat_all(22,1);                                    mu1hat_all(23:45,1);mu1hat_all(45,1);mu1hat_all(45,1)],...
                             [mu1hat_all(1:24,2);mu1hat_all(24,2);                                                                      mu1hat_all(25:45,2);mu1hat_all(45,2);mu1hat_all(45,2);mu1hat_all(45,2);mu1hat_all(45,2)],...
                             [mu1hat_all(1:21,3);mu1hat_all(21,3);mu1hat_all(21,3);mu1hat_all(21,3);mu1hat_all(21,3);                   mu1hat_all(22:45,3);mu1hat_all(45,3)],...
                             [mu1hat_all(1:23,4);mu1hat_all(23,4);mu1hat_all(23,4);                                                     mu1hat_all(24:45,4);mu1hat_all(45,4);mu1hat_all(45,4);mu1hat_all(45,4)],...
                             [mu1hat_all(1:25,5);                                                                                       mu1hat_all(26:45,5);mu1hat_all(45,5);mu1hat_all(45,5);mu1hat_all(45,5);mu1hat_all(45,5);mu1hat_all(45,5)],...
                             [mu1hat_all(1:22,6);mu1hat_all(22,6);mu1hat_all(22,6);mu1hat_all(22,6);                                    mu1hat_all(23:45,6);mu1hat_all(45,6);mu1hat_all(45,6)],...
                             [mu1hat_all(1:24,7);mu1hat_all(24,7);                                                                      mu1hat_all(25:45,7);mu1hat_all(45,7);mu1hat_all(45,7);mu1hat_all(45,7);mu1hat_all(45,7)],...
                             [mu1hat_all(1:20,8);mu1hat_all(20,8);mu1hat_all(20,8);mu1hat_all(20,8);mu1hat_all(20,8);mu1hat_all(20,8);  mu1hat_all(21:45,8)],...
                             [mu1hat_all(1:20,9);mu1hat_all(20,9);mu1hat_all(20,9);mu1hat_all(20,9);mu1hat_all(20,9);mu1hat_all(20,9);  mu1hat_all(21:45,9)],...
                             [mu1hat_all(1:24,10);mu1hat_all(24,10);                                                                    mu1hat_all(25:45,10);mu1hat_all(45,10);mu1hat_all(45,10);mu1hat_all(45,10);mu1hat_all(45,10)],...
                             [mu1hat_all(1:23,11);mu1hat_all(23,11);mu1hat_all(23,11);                                                  mu1hat_all(24:45,11);mu1hat_all(45,11);mu1hat_all(45,11);mu1hat_all(45,11)],...
                             [mu1hat_all(1:21,12);mu1hat_all(21,12);mu1hat_all(21,12);mu1hat_all(21,12);mu1hat_all(21,12);              mu1hat_all(22:45,12);mu1hat_all(45,12)]];
   
    mean_mu1hat(:,i)=mean(All_mu1hat_interpolate,2);  
    
    if plot_indiidual_fig
        %individual plot of mu1hat
        pro=[0.7*ones(1,25),0.3*ones(1,25)];
        scrsz = get(0,'ScreenSize');
        outerpos = [0.3*scrsz(3),0.5*scrsz(4),0.2*scrsz(3),0.35*scrsz(4)];
        figure('OuterPosition', outerpos)
        plot(pro,'Color', [0 0 0],'LineWidth', 2,'Linestyle','-')
        hold on
        x=[1:1:50];
        y=All_mu1hat_interpolate';
        shadedErrorBar(x,y,{@mean,@std},'-r',1);
        ylim([0 1]);
        xlabel('Trial number')
        ylabel('Conditional probability')
        title('sample-target contingency (black), and conditional probability(mu1hat, red)')
    end
    
    %Interpolate (mu2hat)
    All_mu2hat_interpolate=[[mu2hat_all(1:22,1);mu2hat_all(22,1);mu2hat_all(22,1);mu2hat_all(22,1);                                      mu2hat_all(23:45,1);mu2hat_all(45,1);mu2hat_all(45,1)],...
                            [mu2hat_all(1:24,2);mu2hat_all(24,2);                                                                        mu2hat_all(25:45,2);mu2hat_all(45,2);mu2hat_all(45,2);mu2hat_all(45,2);mu2hat_all(45,2)],...
                            [mu2hat_all(1:21,3);mu2hat_all(21,3);mu2hat_all(21,3);mu2hat_all(21,3);mu2hat_all(21,3);                     mu2hat_all(22:45,3);mu2hat_all(45,3)],...
                            [mu2hat_all(1:23,4);mu2hat_all(23,4);mu2hat_all(23,4);                                                       mu2hat_all(24:45,4);mu2hat_all(45,4);mu2hat_all(45,4);mu2hat_all(45,4)],...
                            [mu2hat_all(1:25,5);                                                                                         mu2hat_all(26:45,5);mu2hat_all(45,5);mu2hat_all(45,5);mu2hat_all(45,5);mu2hat_all(45,5);mu2hat_all(45,5)],...
                            [mu2hat_all(1:22,6);mu2hat_all(22,6);mu2hat_all(22,6);mu2hat_all(22,6);                                      mu2hat_all(23:45,6);mu2hat_all(45,6);mu2hat_all(45,6)],...
                            [mu2hat_all(1:24,7);mu2hat_all(24,7);                                                                        mu2hat_all(25:45,7);mu2hat_all(45,7);mu2hat_all(45,7);mu2hat_all(45,7);mu2hat_all(45,7)],...
                            [mu2hat_all(1:20,8);mu2hat_all(20,8);mu2hat_all(20,8);mu2hat_all(20,8);mu2hat_all(20,8);mu2hat_all(20,8);    mu2hat_all(21:45,8)],...
                            [mu2hat_all(1:20,9);mu2hat_all(20,9);mu2hat_all(20,9);mu2hat_all(20,9);mu2hat_all(20,9);mu2hat_all(20,9);    mu2hat_all(21:45,9)],...
                            [mu2hat_all(1:24,10);mu2hat_all(24,10);                                                                      mu2hat_all(25:45,10);mu2hat_all(45,10);mu2hat_all(45,10);mu2hat_all(45,10);mu2hat_all(45,10)],...
                            [mu2hat_all(1:23,11);mu2hat_all(23,11);mu2hat_all(23,11);                                                    mu2hat_all(24:45,11);mu2hat_all(45,11);mu2hat_all(45,11);mu2hat_all(45,11)],...
                            [mu2hat_all(1:21,12);mu2hat_all(21,12);mu2hat_all(21,12);mu2hat_all(21,12);mu2hat_all(21,12);                mu2hat_all(22:45,12);mu2hat_all(45,12)]];
    
    mean_mu2hat(:,i)=mean(All_mu2hat_interpolate,2);                     

    if plot_indiidual_fig
        %individual plot of mu2hat
        pro=[0.7*ones(1,25),0.3*ones(1,25)];
        scrsz = get(0,'ScreenSize');
        outerpos = [0.3*scrsz(3),0.5*scrsz(4),0.2*scrsz(3),0.35*scrsz(4)];
        figure('OuterPosition', outerpos)
        plot(pro,'Color', [0 0 0],'LineWidth', 2,'Linestyle','-')
        ylim([0 1]);
        ylabel('sample-target contingency')
        hold on
        x=[1:1:50];
        y=All_mu2hat_interpolate';
        yyaxis right
        shadedErrorBar(x,y,{@mean,@std},'-r',1);
        %ylim([0 1]);
        xlabel('Trial number')
        ylabel('Prior belief')
        title('sample-target contingency (black), and prior belief (mu2hat, red)')
    end
    
end % end of subjects

if plot_averaged_fig
    
    %averaged plot of mu2hat
    pro=[0.7*ones(1,25),0.3*ones(1,25)];
    scrsz = get(0,'ScreenSize');
    outerpos = [0.3*scrsz(3),0.5*scrsz(4),0.2*scrsz(3),0.35*scrsz(4)];
    figure1 = figure('OuterPosition', outerpos,'Color',[1 1 1]);
    axes1 = axes('Parent',figure1);
    
    x=[1:1:50];
    y=mean_mu2hat';
    shadedErrorBar(x,y,{@mean,@std},'-r',2);
    %ylim([0 1]);
    hold on
    line([25,25],[0,1.2],'LineWidth',2,'LineStyle','--','Color',[0 0 0])
    xlabel('Trial number')
    ylabel('Prior belief')
    title(' Averaged prior belief (mu2hat, red)')
    set(axes1,'FontSize',12);
end
