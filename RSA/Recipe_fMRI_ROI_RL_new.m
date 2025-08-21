% Recipe_fMRI_ROI
% this 'recipe' performs region of interest analysis on fMRI data.
% Cai Wingfield 5-2010, 6-2010, 7-2010, 8-2010
%__________________________________________________________________________
% Copyright (C) 2010 Medical Research Council

%%%%%%%%%%%%%%%%%%%%
%% Initialisation %%
%%%%%%%%%%%%%%%%%%%%
%toolboxRoot = 'D:\Bochum\toolbox\rsatoolbox\rsatoolbox-develop'; addpath(genpath(toolboxRoot));
%mkdir (userOptions.rootPath);

%% Define the condition labels %%
%labels for  LE->RN
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


userOptions = defineUserOptions_RL();
compareRDM=0;
%%
for i= 1:length(conditionLabels)
    close all
    userOptions.conditionLabels=conditionLabels{i};
    if i==1
        userOptions.rootPath = 'D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Results_RSA\Results_new\RDMs_LERN';
    elseif i==2
        userOptions.rootPath = 'D:\Bochum\DATA\fMRI_RL_GoNoGo\Results_OFC_S1\Results_RSA\Results_new\RDMs_LERE';
    end
    mkdir(userOptions.rootPath)
    cd (userOptions.rootPath)
    
    %%%%%%%%%%%%%%%%%%%%%%%
    %%% Data preparation %%
    %%%%%%%%%%%%%%%%%%%%%%%
    
    fullBrainVols = rsa.fmri.fMRIDataPreparation('SPM', userOptions);
    binaryMasks_nS = rsa.fmri.fMRIMaskPreparation(userOptions);
    responsePatterns = rsa.fmri.fMRIDataMasking(fullBrainVols, binaryMasks_nS, 'SPM', userOptions);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% First-order RDM calculation %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    RDMs  = rsa.constructRDMs(responsePatterns, 'SPM', userOptions);
    sRDMs = rsa.rdm.averageRDMs_subjectSession(RDMs, 'session');
    %rsa.fig.figureRDMs(sRDMs, userOptions, struct('fileName', 'RoIRDMs', 'figureNumber', 1));
    
    sRDMs_mod=sRDMs;
    for m=1:size(sRDMs,1)
        for n=1:size(sRDMs,2)
            sRDMs_mod(m,n).RDM=sRDMs(m,n).RDM(1:4,5:8);
        end
    end
    
    mRDMs = rsa.rdm.averageRDMs_subjectSession(RDMs, 'session', 'subject');
    %rsa.fig.figureRDMs(mRDMs, userOptions, struct('fileName', 'RoIRDMs', 'figureNumber', 2));
    
    mRDMs_mod=mRDMs;
    for j=1:length(mRDMs)
        mRDMs_mod(j).RDM=mRDMs(j).RDM (1:4,5:8);
    end
    
    save([userOptions.rootPath,'\RDMs\RL_GoNoGo_RDMs.mat'],'RDMs','sRDMs','mRDMs','sRDMs_mod','mRDMs_mod');
    
    Models_all = rsa.constructModelRDMs(modelRDMs_RL_new(), userOptions);

    %% compare RDMs with models
    if compareRDM
        
        rsa.fig.figureRDMs(Models_all, userOptions, struct('fileName', 'ModelRDMs', 'figureNumber', 3));
        roinumber=length(mRDMs_mod);
        
        for i= 1:length(Models_all)
            
            Models=Models_all(i);
            for n=1:roinumber
                RDMs_allROI{n}=sRDMs_mod(n,:);
            end
            
            userOptions.RDMcorrelationType='Kendall_taua';
            userOptions.RDMrelatednessTest = 'subjectRFXsignedRank';
            userOptions.RDMrelatednessThreshold = 0.05;
            userOptions.nRandomisations = 1000;
            
            userOptions.figureIndex = [10 11];
            userOptions.RDMrelatednessMultipleTesting = 'FDR';
            userOptions.candRDMdifferencesMultipleTesting = 'FDR';
            userOptions.candRDMdifferencesTest = 'subjectRFXsignedRank';
            userOptions.candRDMdifferencesThreshold = 0.05;
            userOptions.candRDMdifferencesMultipleTesting = 'none';
            userOptions.plotpValues = '*';
            
            
            str_var=strrep(['Stats_',Models.name],' ','_');
            eval([str_var,'=rsa.compareRefRDM2candRDMs(Models, RDMs_allROI, userOptions);']);
            
            %stats=rsa.compareRefRDM2candRDMs(Models, RDMs_allROI, userOptions); % reference RDM = model RDM; candidate RDMs = OFC&S1 RDMs to test which region fits better to the model RDM
            
            save ([userOptions.rootPath,'\',str_var,'.mat'],str_var);
            % %
            %     roiIndex = 1;% index of the ROI for which the group average RDM will serve
            % %     % as the reference RDM.
            %     Models_all=
            %     for i=1:numel(Models)
            %          models{i}=Models(i);
            %     end
            %     stats_p_r=rsa.compareRefRDM2candRDMs(sRDMs(roiIndex,:), models, userOptions); %1 ROI RDM -> 2 model RDMs to test which model fits better to the ROI RDM
            %
        end
    end
    
end

