
RootDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\'];
outputDir=[RootDir,'Results_OFC_S1\Participants'];

sim_times=500;
est_obs_all=load([RootDir,'\Results_OFC_S1\Participants\Sub02\Results_HGF_2level.mat']);


%simulation of random model with the parameter space (b=0-1)
p_correct_all_rand=[];
for  b = 0:0.1:1
    
    for  m=1:12
        u=est_obs_all.est_obs_all{1, m}.u;
        
        for n=1:sim_times
            
            [a_rand, r_rand] = simulate_random_stay_RL(u, b);
            sim_rand(:,n) = r_rand;
            
        end %end of 500 smulation times
        
        p_correct_rand(:,m)=mean(sum(sim_rand)/45);

    end % end of 12 blocks
    
    p_correct_all_rand=[p_correct_all_rand,mean(p_correct_rand)];
    
end % end of time point of b


%simulation of WSLS model with the parameter space (epsilon = 0.1;)
p_correct_all_WSLS=[];
for  epsilon = 0:0.1:1
    for  m=1:12
         u=est_obs_all.est_obs_all{1, m}.u;  
         
        for n=1:sim_times

            [a_WSLS, r_WSLS] = simulate_WSLS_RL(u, epsilon);
            sim_WSLS(:,n)  = r_WSLS;
            
        end%end of 500 smulation times
        
        p_correct_WSLS(:,m)=mean(sum(sim_WSLS)/45);
        
    end% end of 12 blocks
    
    p_correct_all_WSLS=[p_correct_all_WSLS,mean(p_correct_WSLS)];
    
end% end of time point of epsilon


%simulation of RW model with the parameter space (alpha, beta)

v0=0.5;
beta=[1 2 5 10 20];
alpha= 0:0.1:1;

for i=1:length(beta)
    v_beta = beta(i); % 
    
    for j=1:length(alpha)
        v_alpha = alpha(j);%
        
        for  m=1:12
             u=est_obs_all.est_obs_all{1, m}.u;
             
            for n=1:sim_times
                
                %Simulate responses under softmax model
                sim_RW = tapas_simModel( u,...
                                         'tapas_rw_binary',...
                                         [v0 v_alpha],...
                                         'tapas_softmax_binary',...
                                         v_beta);
                
                correctness= abs(sim_RW.y-sim_RW.u);%0 correct; 1 wrong
                correctness(correctness==0)=3;
                correctness(correctness==1)=0;
                correctness(correctness==3)=1;
                response_RW(:,n)  = correctness;%1 correct; 0 wrong

            end %end of 500 smulation times
            
              p_correct_RW(:,m)=mean(sum(response_RW)/45);
              
        end % end of 12 blocks
        
         p_correct_allalpha_RW(:,j)=mean(p_correct_RW);
         
    end % end of time point of alpha
    
    p_correct_all_RW(i,:)=p_correct_allalpha_RW;
    
end % end of time point of beta


% 
% 
% %simulation of RW model with the parameter space (only beta), alpha is
% %estimated by Bayes-optimal
% 
% v0=0.5;
% beta=1:1:20;
% 
% for i=1:length(beta)
%     v_beta = beta(i); % 
%      
%         for  m=1:12
%              u=est_obs_all.est_obs_all{1, m}.u;
%              
%             for n=1:sim_times
% 
%                 bopars_RW = tapas_fitModel( [],...
%                                      u,...
%                                     'tapas_rw_binary_config',...
%                                     'tapas_bayes_optimal_binary_config',...
%                                      'tapas_quasinewton_optim_config');
%                                  
%                 %Simulate responses under softmax model
%                 sim_RW = tapas_simModel( u,...
%                                          'tapas_rw_binary',...
%                                           bopars_RW.p_prc.p,...
%                                          'tapas_softmax_binary',...
%                                          v_beta);
%                 
%                 correctness= abs(sim_RW.y-sim_RW.u);%0 correct; 1 wrong
%                 correctness(correctness==0)=3;
%                 correctness(correctness==1)=0;
%                 correctness(correctness==3)=1;
%                 response_RW(:,n)  = correctness;%1 correct; 0 wrong
% 
%             end %end of 500 smulation times
%             
%               p_correct_RW(:,m)=mean(sum(response_RW)/45);
%               
%         end % end of 12 blocks
% 
%         p_correct_all_beta_RW(i,:)=mean(p_correct_RW); 
%     
% end % end of time point of beta



%simulation of HGF model with the parameter space (omega and zeta)

omega=-10:1:-2;
zeta=[1 2 5 10 20];

for i=1:length(zeta)
    v_zeta = zeta(i); %
    
     for j=1:length(omega)
        v_omega = omega(j);%
    
    for  m=1:12
         u=est_obs_all.est_obs_all{1, m}.u;
         
        for n=1:sim_times
  
            %Simulate responses
            sim_HGF = tapas_simModel(u,...
                'tapas_hgf_binary',...
                 [NaN 0 1 NaN 1 1 NaN 0 0 1 1 NaN v_omega 0],...
                'tapas_unitsq_sgm',...
                v_zeta);
            
            correctness=abs(sim_HGF.y-sim_HGF.u);%0 correct; 1 wrong
            correctness(correctness==0)=3;
            correctness(correctness==1)=0;
            correctness(correctness==3)=1;
            response_HGF(:,n) = correctness;%1 correct; 0 wrong  
            
        end %end of 500 smulation times
        
        p_correct_HGF(:,m)=mean(sum(response_HGF)/45);
        
    end % end of 12 blocks
    
    p_correct_all_omega_HGF(j,:)=mean(p_correct_HGF);
    
        end % end of time point of omega
    
    p_correct_all_HGF(i,:)=p_correct_all_omega_HGF;
    
end % end of time point of beta

% 
% 
% %simulation of HGF model with the parameter space (only zeta), omega is
% %estimated by Bayes-optimal
% 
% zeta=1:1:20;
% 
% for i=1:length(zeta)
%     v_zeta = zeta(i); %
%     
%     
%     for  m=1:12
%          u=est_obs_all.est_obs_all{1, m}.u;
%         
%         for n=1:sim_times
% 
%             %simulated using HGF
%             bopars_HGF = tapas_fitModel( [],...
%                 u,...
%                 'tapas_hgf_binary_config_2levels_2',...
%                 'tapas_bayes_optimal_binary_config',...
%                 'tapas_quasinewton_optim_config');
%             %Simulate responses
%             sim_HGF = tapas_simModel(u,...
%                 'tapas_hgf_binary',...
%                 bopars_HGF.p_prc.p,...
%                 'tapas_unitsq_sgm',...
%                 v_zeta);
%             
%             correctness=abs(sim_HGF.y-sim_HGF.u);%0 correct; 1 wrong
%             correctness(correctness==0)=3;
%             correctness(correctness==1)=0;
%             correctness(correctness==3)=1;
%             response_HGF(:,n) = correctness;%1 correct; 0 wrong  
%             
%         end %end of 500 smulation times
%         
%         p_correct_HGF(:,m)=mean(sum(response_HGF)/45);
%         
%     end % end of 12 blocks
%     
%     p_correct_all_zeta_HGF(i,:)=mean(p_correct_HGF);
%     
% end % end of time point of zeta


save([outputDir,'\simulation_p_correct_parameters.mat'], 'p_correct_all_rand', 'p_correct_all_WSLS','p_correct_all_RW','p_correct_all_HGF');

%% plot the figure

    scrsz = get(0,'ScreenSize');
    outerpos = [0.5*scrsz(3),0.3*scrsz(4),0.55*scrsz(3),0.4*scrsz(4)];
    figure1 = figure('OuterPosition', outerpos,'Color',[1 1 1]);
    
    subplot1=subplot(1,4,1);
    hold(subplot1,'on');
    plot(p_correct_all_rand,'Color',[1 0 0],'LineWidth',1.5);
    
    ylabel('p (correct)');
    xlabel('Bias parameter (b)');
    title('Random');
    xlim(subplot1,[0.8 11.2]);
    ylim(subplot1,[0.4 0.6]);
    set(subplot1,'FontSize',12,'XTick',[1 6 11],'XTickLabel',{'0','0.5','1'})

    
    subplot2=subplot(1,4,2);
    hold(subplot2,'on');
    plot(p_correct_all_WSLS,'Color',[1 0 0],'LineWidth',1.5);
    ylabel('p (correct)');
    xlabel('Randomness parameter (?)');
    title('WSLS');

    xlim(subplot2,[0.8 11.2]);
    ylim(subplot2,[0.4 0.6]);
    set(subplot2,'FontSize',12,'XTick',[1 6 11],'XTickLabel',{'0','0.5','1'})
    
    subplot3=subplot(1,4,3);
    hold(subplot3,'on');
    plot1=plot(flip(p_correct_all_RW)','LineWidth',1.5);
    ylabel('p (correct)');
    xlabel('Learning rate (?)');
    title('RW');

    set(plot1(1),'DisplayName','?=20','Color',[1 0.8 0.8]);
    set(plot1(2),'DisplayName','?=10','Color',[1 0.4 0.4]);
    set(plot1(3),'DisplayName','?=5','Color',[1 0 0]);
    set(plot1(4),'DisplayName','?=2','Color',[0.6 0 0]);
    set(plot1(5),'DisplayName','?=1','Color',[0.2 0 0]);
       
    xlim(subplot3,[0.8 11.2]);
    ylim(subplot3,[0.4 0.7]);
    set(subplot3,'FontSize',12,'XTick',[1 6 11],'XTickLabel',{'0','0.5','1'})
    legend1 = legend(subplot3,'show');
    set(legend1,'EdgeColor',[1 1 1]);
    
    subplot4=subplot(1,4,4);
    hold(subplot4,'on');
    plot2=plot(flip(p_correct_all_HGF)','LineWidth',1.5);
    ylabel('p (correct)');
    xlabel('Step size (?)');
    title('HGF');

    set(plot2(1),'DisplayName','?=20','Color',[1 0.8 0.8]);
    set(plot2(2),'DisplayName','?=10','Color',[1 0.4 0.4]);
    set(plot2(3),'DisplayName','?=5','Color',[1 0 0]);
    set(plot2(4),'DisplayName','?=2','Color',[0.6 0 0]);
    set(plot2(5),'DisplayName','?=1','Color',[0.2 0 0]);
    
    xlim(subplot4,[0.8 11.2]);
    ylim(subplot4,[0.4 0.7]);
    set(subplot4,'FontSize',12,'XTick',[1 6 10],'XTickLabel',{'-10','-5','-1'})
    legend2 = legend(subplot4,'show');
    set(legend2,'EdgeColor',[1 1 1]);
