% Recipe_fMRI_searchlight
%
% Cai Wingfield 11-2009, 2-2010, 3-2010, 8-2010
%__________________________________________________________________________
% Copyright (C) 2010 Medical Research Council
import rsa.*
import rsa.fig.*
import rsa.fmri.*
import rsa.rdm.*
import rsa.sim.*
import rsa.spm.*
import rsa.stat.*
import rsa.util.*
%%%%%%%%%%%%%%%%%%%%
%% Initialisation %%
%%%%%%%%%%%%%%%%%%%%

% Define the model/stages and ROI for the searchlight analysis
close all
clear userOptions
Name_searchlight={'Stimulus_LERE_S1_3b','Outcome_LERE_S1_3b','Outcome_LERN_lOFC','Outcome_LERE_lOFC'};

%labels for outcome-selective  LE->RN
conditionLabels{1} = { ...
    'outcome_HIT_LE', ...
    'outcome_CR_LE', ...
    'outcome_FA_LE', ...
    'outcome_MIS_LE', ...
    'outcome_HIT_RN', ...
    'outcome_CR_RN', ...
    'outcome_FA_RN', ...
    'outcome_MIS_RN', ...
    };

%labels for   LE->RE
conditionLabels{2} = { ...
    'outcome_HIT_LE', ...
    'outcome_CR_LE', ...
    'outcome_FA_LE', ...
    'outcome_MIS_LE', ...
    'outcome_HIT_RE', ...
    'outcome_CR_RE', ...
    'outcome_FA_RE', ...
    'outcome_MIS_RE', ...
    };

models_all = modelRDMs_RL_new();  %
Name_models=fieldnames(models_all);
%%
for i=1:length(Name_searchlight)
    
    
    if strcmp(Name_searchlight(i),'Stimulus_LERE_S1_3b')==1
       ROIname='S1_3b';
       Id_conditionLabels=2;
       model_current=struct(Name_models{1},models_all.Stimulus_selective);
    elseif strcmp(Name_searchlight(i),'Outcome_LERE_S1_3b')==1
       ROIname='S1_3b';
       Id_conditionLabels=2;
       model_current=struct(Name_models{2},models_all.Outcome_selective); 
    elseif strcmp(Name_searchlight(i),'Outcome_LERN_lOFC')==1
       ROIname='lOFC';
       Id_conditionLabels=1;
       model_current=struct(Name_models{2},models_all.Outcome_selective);  
    elseif strcmp(Name_searchlight(i),'Outcome_LERE_lOFC')==1
       ROIname='lOFC';
       Id_conditionLabels=2;
       model_current=struct(Name_models{2},models_all.Outcome_selective); 
    end
    
    %define the userOptions
    userOptions = defineUserOptions_RL();
    userOptions.maskNames = { ROIname };
    userOptions.conditionLabels=conditionLabels{Id_conditionLabels};
    userOptions.rootPath = fullfile('D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Results_RSA_new\',['Searchlight_',Name_searchlight{i}]);
    
    
    mkdir(userOptions.rootPath)

    %%%%%%%%%%%%%%%%%%%%%%
    %% Data preparation %%
    %%%%%%%%%%%%%%%%%%%%%%
    
    fullBrainVols = rsa.fmri.fMRIDataPreparation('SPM', userOptions);
    binaryMasks_nS = rsa.fmri.fMRIMaskPreparation(userOptions);


    %% %%%%%%%%%%%%%%%%%%%%%%%%%
    %%model RDM      %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    models = rsa.constructModelRDMs(model_current, userOptions);  %outcome selective model


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Searchlight within the mask %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    rsa.fmri.fMRISearchlight_RL(fullBrainVols, binaryMasks_nS, models, 'SPM', userOptions);


    %% Statics
    % load the previously computed rMaps and concatenate across subjects
    cd ([userOptions.rootPath,filesep,'Maps']);
    
    load('RL_GoNoGo_fMRISearchlight_Maps.mat');
    
    Nsubjects=size( struct2table(nMaps_nS), 2);
    
    % prepare the rMaps:
    
    for subjectI = 1:Nsubjects
        
        if  strcmp(Name_searchlight(i),'Stimulus_LERE_S1_3b')==1
            rMaps{subjectI} = eval(strcat('rMaps_nS.Stimulus_selective.',userOptions.subjectNames{subjectI},'.',ROIname));
        else
            rMaps{subjectI} = eval(strcat('rMaps_nS.Outcome_selective.',userOptions.subjectNames{subjectI},'.',ROIname));
        end
        
        fprintf(['loading the correlation maps for ',userOptions.subjectNames{subjectI},'\n']);
        
        % concatenate across subjects
        thisRs = rMaps{subjectI};
        thisModelSims(:,:,:,subjectI) = thisRs(:,:,:);
        
    end
    
    
    mask=eval(strcat('binaryMasks_nS.',userOptions.subjectNames{1},'.',ROIname));
    mask=round(mask);
    % obtain a pMaps from applying a 1-sided signrank test and also t-test to
    % the model similarities:
    for x=1:size(thisModelSims,1)
        for y=1:size(thisModelSims,2)
            for z=1:size(thisModelSims,3)
                if mask(x,y,z) == 1
                    if all(isnan(thisModelSims(x,y,z,:)))
                        p_t(x,y,z) = NaN;
                        p_sr(x,y,z) = NaN;
                    else
                        [h p_t(x,y,z)] = ttest(squeeze(thisModelSims(x,y,z,:)),0,0.05,'right');
                        [p_sr(x,y,z)] = rsa.stat.signrank_onesided(squeeze(thisModelSims(x,y,z,:)));
                        
                    end
                    
                else
                    p_t(x,y,z) = NaN;
                    p_sr(x,y,z) = NaN;
                    
                end
                
            end
        end
        
    end
    
    % apply FDR correction
    pThrsh_t  = rsa.stat.FDRthreshold(p_t,0.05,mask);
    pThrsh_sr = rsa.stat.FDRthreshold(p_sr,0.05,mask);
    % apply Bonferoni correction
    %p_bnf = 0.05/sum(mask(:));
    
    %save
    p_results.p_t=p_t;
    p_results.p_sr=p_sr;
    p_results.pThrsh_t=pThrsh_t;
    p_results.pThrsh_sr=pThrsh_sr;

    save([userOptions.rootPath,filesep,'Maps',filesep,'p_results'],'p_results');

    % mark the suprathreshold voxels in yellow
    supraThreshMarked_t = zeros(size(p_t));
    supraThreshMarked_t(p_t <= pThrsh_t) = 1;
    
    
    supraThreshMarked_sr = zeros(size(p_sr));
    supraThreshMarked_sr(p_sr <= pThrsh_sr) = 1;
    
    %save the binay suprathreshed mask
    
    V = spm_vol_nifti('D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Results_RSA_new\Searchlight_Stimulus_LERE_S1_3b\Maps\RL_GoNoGo_rMap_S1_3b_Stimulus_selective_Sub02.nii');
    
    Vnew=V;
    Vnew.fname='Mask_t.nii';
    spm_write_vol(Vnew,supraThreshMarked_t);
    Vnew.fname='Mask_sr.nii';
    spm_write_vol(Vnew,supraThreshMarked_sr);
    


end
% 
% 
% % display the location where the effect was inserted (in green):
% brainVol = rsa.fmri.addRoiToVol(map2vol(anatVol),mask2roi(mask),[1 0 0],2);
% brainVol_effectLoc = rsa.fmri.addBinaryMapToVol(brainVol,Mask.*mask,[0 1 0]);
% rsa.fig.showVol(brainVol_effectLoc,'simulated effect [green]',2);
% rsa.fig.handleCurrentFigure([returnHere,filesep,'DEMO4',filesep,'results_DEMO4_simulatedEffectRegion'],userOptions);
% 
% % display the FDR-thresholded maps on a sample anatomy (signed rank test) :
% brainVol = rsa.fmri.addRoiToVol(map2vol(anatVol),mask2roi(mask),[1 0 0],2);
% brainVol_sr = rsa.fmri.addBinaryMapToVol(brainVol,supraThreshMarked_sr.*mask,[1 1 0]);
% rsa.fig.showVol(brainVol_sr,'signrank, E(FDR) < .05',3)
% %rsa.fig.handleCurrentFigure([returnHere,filesep,'DEMO4',filesep,'results_DEMO4_signRank'],userOptions);
% 
% % display the FDR-thresholded maps on a sample anatomy (t-test) :
% brainVol = rsa.fmri.addRoiToVol(map2vol(anatVol),mask2roi(mask),[1 0 0],2);
% brainVol_t = rsa.fmri.addBinaryMapToVol(brainVol,supraThreshMarked_t.*mask,[1 1 0]);
% rsa.fig.showVol(brainVol_t,'t-test, E(FDR) < .05',4)
% %rsa.fig.handleCurrentFigure([returnHere,filesep,'DEMO4',filesep,'results_DEMO2_tTest'],userOptions);
% 
% 
