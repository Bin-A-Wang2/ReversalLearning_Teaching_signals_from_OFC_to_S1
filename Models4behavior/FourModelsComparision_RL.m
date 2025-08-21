
function FourModelsComparision_RL (RootDir,Subjects)

%Subjects=[2 3 4 5 7 8 11 12 13 14 15 16 17 18 19 20 22 23 26 27 28 29 31 32 33 34 35 36 37 38 39 40]; %% good subjects
%RootDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\'];
outputDir= [RootDir,'Results_OFC_S1\Participants'];
prfx='Sub';

for i=1:length(Subjects)
    sub=Subjects(i);
    inputpath= [RootDir,'\Results_OFC_S1\Participants\',prfx,num2str(sub,'%.2d')];
    load([inputpath,'\index_decision_prePE.mat']);
    
    for j=1:12
        
        Obs_correctstay=sum(index_decision_all(:,j)==1)./(sum(index_decision_all(:,j)==1)+sum(index_decision_all(:,j)==3));
        Obs_wrongstay=sum(index_decision_all(:,j)==2)./(sum(index_decision_all(:,j)==2)+sum(index_decision_all(:,j)==4));
        
        All_Obs_correctstay(j,1)=Obs_correctstay;
        All_Obs_wrongstay(j,1)=Obs_wrongstay;
        
    end
    
    correctstay(i,1)=nanmean(All_Obs_correctstay);
    wrongstay(i,1)=nanmean(All_Obs_wrongstay);
end

%% HGF simulated correctstay and wrongstay
sim_times=500;

est_obs_all=load([RootDir,'\Results_OFC_S1\Participants\Sub02\Results_HGF_2level.mat']);

for m=1:12
    %% get the index for different decision (1: Keep_correct; 2: keep_wrong; 3: change_correct; 4: change_wrong)
    u=est_obs_all.est_obs_all{1, m}.u;
    
    % Simulate the trajectories of beliefs about external states, and responses based on these beliefs
    %Find Bayes optimal parameter values (bopars)
    for n=1:sim_times
        
        %simulated using random model
        b = 0.5;
        [a_rand, r_rand] = simulate_random_stay_RL(u, b);
        sim(1).a(:,n) = a_rand;
        sim(1).r(:,n) = r_rand;
        
        %simulated using WSLS
        epsilon = 0.1;
        [a_WSLS, r_WSLS] = simulate_WSLS_RL(u, epsilon);
        sim(2).a(:,n) = a_WSLS;
        sim(2).r(:,n) = r_WSLS;
        
        %simulated using RW
        bopars_RW = tapas_fitModel( [],...
                                     u,...
                                    'tapas_rw_binary_config',...
                                    'tapas_bayes_optimal_binary_config',...
                                     'tapas_quasinewton_optim_config');
        
        %Simulate responses under softmax model
        sim_RW = tapas_simModel( u,...
                                 'tapas_rw_binary',...
                                 bopars_RW.p_prc.p,...
                                 'tapas_softmax_binary',...
                                 5);        
                             
        sim(3).a(:,n) = sim_RW.y;
        correctness= abs(sim_RW.y-sim_RW.u);%0 correct; 1 wrong
        correctness(correctness==0)=3;
        correctness(correctness==1)=0;
        correctness(correctness==3)=1;
        sim(3).r(:,n)  = correctness;%1 correct; 0 wrong
        
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
       
        sim(4).a(:,n) = sim_HGF.y;
        correctness=abs(sim_HGF.y-sim_HGF.u);%0 correct; 1 wrong
        correctness(correctness==0)=3;
        correctness(correctness==1)=0;
        correctness(correctness==3)=1;
        sim(4).r(:,n) = correctness;%1 correct; 0 wrong
    end
    
    sim_all{1,m}=sim;
    
end

for b=1:12
    sim=sim_all{1, b} ; 
    
    for i = 1:length(sim)
        for n = 1:sim_times
            sim(i).stay(:,n) = analysis_Stay_correctandwrong(sim(i).a(:,n)', sim(i).r(:,n)');
        end
        pro_stay(:,i) = nanmean(sim(i).stay,2);
    end
     
    pro_stay_all{1,b}=pro_stay;
end

ave_pro_stay=(pro_stay_all{1,1} + pro_stay_all{1,2} +pro_stay_all{1,3} + pro_stay_all{1,4}+pro_stay_all{1,5} + pro_stay_all{1,6} + ...
              pro_stay_all{1,7} + pro_stay_all{1,8}+ pro_stay_all{1,9} + pro_stay_all{1,10}+ pro_stay_all{1,11} + pro_stay_all{1,12})./12;

save([outputDir,'\Pro_stay_4models_new2.mat'], 'correctstay', 'wrongstay','sim_all',...
    'pro_stay_all', 'ave_pro_stay');

% plot the figure
figure1 = figure('Color',[1 1 1]);
hold on;
l = plot([0 1], [[ave_pro_stay],[mean(wrongstay);mean(correctstay)]]);
ylim([0 1])
set(l, 'marker', '.', 'markersize', 50, 'linewidth', 3)
legend({'M1: Random' 'M2: WSLS' 'M3:RW' 'M4:HGF' 'Observed' }, ...
'location', 'southeast')
xlabel('Previous outcome')
ylabel('Probability of staying')
set(gca, 'xtick', [0 1],'XTickLabel',{'Wrong','Correct'}, 'tickdir', 'out', 'fontsize', 18, 'xlim', [-0.1 1.1])
