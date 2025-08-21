
%%calculate the Bayes Optimal Parameter for RW and HGF
RootDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\'];
outputDir=[RootDir,'Results_OFC_S1\Participants\'];

est_obs_all=load([RootDir,'\Results_OFC_S1\Participants\Sub02\Results_HGF_2level.mat']);

for i=1:12
    u=est_obs_all.est_obs_all{1, i}.u;
    
    
    bopars_RW = tapas_fitModel( [],...
                             u,...
                            'tapas_rw_binary_config',...
                            'tapas_bayes_optimal_binary_config',...
                             'tapas_quasinewton_optim_config');
    optimal_alpha_RW(i)= bopars_RW.p_prc.p(2);
    
    bopars_HGF = tapas_fitModel( [],...
            u,...
            'tapas_hgf_binary_config_2levels_2',...
            'tapas_bayes_optimal_binary_config',...
            'tapas_quasinewton_optim_config');
        
    optimal_omega_HGF(i)= bopars_HGF.p_prc.p(13);
end

save([outputDir,'\Bayes Optimal Paramters.mat'], 'optimal_alpha_RW', 'optimal_omega_HGF');
