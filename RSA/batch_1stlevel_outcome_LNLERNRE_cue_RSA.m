% List of open inputs
function batch_1stlevel_outcome_LNLERNRE_cue_RSA(RootDir,Subjects)  

Nr_run=3;
cond_name={'outcome_correct_LN','outcome_wrong_LN','outcome_correct_LE','outcome_wrong_LE',...
           'outcome_correct_RN','outcome_wrong_RN','outcome_correct_RE','outcome_wrong_RE',...
           'outcome_HIT_LN','outcome_CR_LN', 'outcome_HIT_LE','outcome_CR_LE', 'outcome_HIT_RN','outcome_CR_RN', 'outcome_HIT_RE','outcome_CR_RE',...
           'outcome_FA_LN','outcome_MIS_LN', 'outcome_FA_LE','outcome_MIS_LE', 'outcome_FA_RN','outcome_MIS_RN', 'outcome_FA_RE','outcome_MIS_RE',...
           'outcome_late response','cue_all','cue_late response'};

output_name=['Results_outcome_LNLERNRE_cue_RSA'];
job_name=['Model_1stlevel_outcome_LNLERNRE_cue_RSA.mat'];
prfx='Sub';

inputdir=[RootDir,'Preprocessing_RL\'];
outputdir=[RootDir,'Results\Participants\'];

%% loop for each subject
for i=1:length(Subjects)
    fprintf('Working on participant %d\n',Subjects(i));

    sub=Subjects(i);

    inputpath= [inputdir,prfx,num2str(sub,'%.2d')];
    outputpath= [outputdir,prfx,num2str(sub,'%.2d'),'\',output_name];
    
    %% get the path of processed swra* file in 3 RUNs
    clear file_all filePath
    for j=1:Nr_run
        datapath=[inputpath,'\RUN',num2str(j),'\'];
        datadir=dir([datapath,'\wrs*']);
        for i = 1:length(datadir)
            filePath{i,j} = [datapath,datadir(i).name];
        end
    end
    
    file_all=[filePath(:,1);filePath(:,2);filePath(:,3)];
    id=cellfun('length',file_all);
    file_all(id==0)=[];
       
    %% get the onset for conditions in 3 RUNs
    load([outputdir,prfx,num2str(sub,'%.2d'),'\Onset_cue_all.mat'],'onset_cue_all','onset_cue_missing_all');
    load([outputdir,prfx,num2str(sub,'%.2d'),'\Onset_outcome_all.mat']);
    
    onset_outcome_correct_LN=[onset_outcome_HIT_LN_all;onset_outcome_CR_LN_all];
    onset_outcome_wrong_LN=[onset_outcome_FA_LN_all;onset_outcome_MISS_LN_all];

    onset_outcome_correct_LE=[onset_outcome_HIT_LE_all;onset_outcome_CR_LE_all];
    onset_outcome_wrong_LE=[onset_outcome_FA_LE_all;onset_outcome_MISS_LE_all];
    
    onset_outcome_correct_RN=[onset_outcome_HIT_RN_all;onset_outcome_CR_RN_all];
    onset_outcome_wrong_RN=[onset_outcome_FA_RN_all;onset_outcome_MISS_RN_all];
    
    onset_outcome_correct_RE=[onset_outcome_HIT_RE_all;onset_outcome_CR_RE_all];
    onset_outcome_wrong_RE=[onset_outcome_FA_RE_all;onset_outcome_MISS_RE_all];
    %onset_cue_LN_all;onset_cue_LE_all;onset_cue_RN_all;onset_cue_NE_all; onset_cue_missing_all
    
    
    %% get the file path of head movement parameters
    Headfiles = fullfile(inputpath,'rp_all.txt');
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  first level speficication
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear matlabbatch
    
    matlabbatch{1}.spm.stats.fmri_spec.dir = {outputpath};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.2;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = file_all;%%
    
    
    % cond1
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).name =  cond_name{1};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).onset = onset_outcome_correct_LN;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
    
    
    % cond2
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).name =  cond_name{2};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).onset = onset_outcome_wrong_LN;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
    
    
    % cond3
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).name =  cond_name{3};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).onset = onset_outcome_correct_LE;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;
    
    % cond4
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).name = cond_name{4}; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).onset = onset_outcome_wrong_LE; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).orth = 1;
    
    % cond5
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).name =  cond_name{5};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).onset = onset_outcome_correct_RN;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).orth = 1;
    
    % cond6
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).name =  cond_name{6};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).onset = onset_outcome_wrong_RN;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).orth = 1;
    
    
    % cond7
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).name =  cond_name{7};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).onset = onset_outcome_correct_RE;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).orth = 1;
    
    
    % cond8
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).name =  cond_name{8};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).onset = onset_outcome_wrong_RE;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).orth = 1;
    
    
    % cond9
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).name =  cond_name{9};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).onset = onset_outcome_HIT_LN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(9).orth = 1;
    
    % cond10
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).name =  cond_name{10};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).onset = onset_outcome_CR_LN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(10).orth = 1;
    
    
    % cond11
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).name =  cond_name{11};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).onset = onset_outcome_HIT_LE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(11).orth = 1;
    
    
    % cond12
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).name =  cond_name{12};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).onset = onset_outcome_CR_LE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(12).orth = 1;
    
    
    % cond13
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).name =  cond_name{13};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).onset = onset_outcome_HIT_RN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(13).orth = 1;
    
    
    % cond14
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).name =  cond_name{14};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).onset = onset_outcome_CR_RN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(14).orth = 1;
    
    
    % cond15
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).name =  cond_name{15};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).onset = onset_outcome_HIT_RE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(15).orth = 1;
    
    % cond16
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).name =  cond_name{16};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).onset = onset_outcome_CR_RE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(16).orth = 1;
    
    % cond17
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).name =  cond_name{17};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).onset = onset_outcome_FA_LN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(17).orth = 1;
    
    % cond18
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).name =  cond_name{18};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).onset = onset_outcome_MISS_LN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(18).orth = 1;
    
    % cond19
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).name =  cond_name{19};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).onset = onset_outcome_FA_LE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(19).orth = 1;
    
    % cond20
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).name =  cond_name{20};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).onset = onset_outcome_MISS_LE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(20).orth = 1;
    
    % cond21
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).name =  cond_name{21};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).onset = onset_outcome_FA_RN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(21).orth = 1;
    
    % cond22
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).name =  cond_name{22};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).onset = onset_outcome_MISS_RN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(22).orth = 1;
    
    % cond23
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).name =  cond_name{23};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).onset = onset_outcome_FA_RE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(23).orth = 1;
    
    % cond24
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).name =  cond_name{24};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).onset = onset_outcome_MISS_RE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(24).orth = 1;
    
    % cond25
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).name =  cond_name{25};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).onset = onset_outcome_missing_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(25).orth = 1;
    
    % cond26
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).name =  cond_name{26};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).onset = onset_cue_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(26).orth = 1;
    
    % cond27
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).name =  cond_name{27};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).onset = onset_cue_missing_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(27).orth = 1;
    
    %
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {Headfiles};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;

    %
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    

    save([outputdir,prfx,num2str(sub,'%.2d'),'\',job_name], 'matlabbatch');
    
    % run job
    spm_jobman('run',matlabbatch);
    
    %% concatenate three sessions
    scans = [453 453 453];
    spm_fmri_concatenate([outputpath,'\SPM.mat'], scans);
    
    
%     %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %  model estimation and result check
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear matlabbatch
    
    matlabbatch{1}.spm.stats.fmri_est.spmmat(1) = {[outputpath,'\SPM.mat']};
    matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
%     
%     matlabbatch{2}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
%     matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = contrast_name{1};
%     matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = contrast{1};
%     matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = contrast_name{2};
%     matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = contrast{2};
%     matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{3}.tcon.name = contrast_name{3};
%     matlabbatch{2}.spm.stats.con.consess{3}.tcon.weights = contrast{3};
%     matlabbatch{2}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{4}.tcon.name = contrast_name{4};
%     matlabbatch{2}.spm.stats.con.consess{4}.tcon.weights = contrast{4};
%     matlabbatch{2}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{5}.tcon.name = contrast_name{5};
%     matlabbatch{2}.spm.stats.con.consess{5}.tcon.weights = contrast{5};
%     matlabbatch{2}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{6}.tcon.name = contrast_name{6};
%     matlabbatch{2}.spm.stats.con.consess{6}.tcon.weights = contrast{6};
%     matlabbatch{2}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{7}.tcon.name = contrast_name{7};
%     matlabbatch{2}.spm.stats.con.consess{7}.tcon.weights = contrast{7};
%     matlabbatch{2}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{8}.tcon.name = contrast_name{8};
%     matlabbatch{2}.spm.stats.con.consess{8}.tcon.weights = contrast{8};
%     matlabbatch{2}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{9}.tcon.name = contrast_name{9};
%     matlabbatch{2}.spm.stats.con.consess{9}.tcon.weights = contrast{9};
%     matlabbatch{2}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.consess{10}.tcon.name = contrast_name{10};
%     matlabbatch{2}.spm.stats.con.consess{10}.tcon.weights = contrast{10};
%     matlabbatch{2}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
%     matlabbatch{2}.spm.stats.con.delete = 0;
% 
%     %%result check
%     matlabbatch{3}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
%     matlabbatch{3}.spm.stats.results.conspec(1).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(1).contrasts = 1;
%     matlabbatch{3}.spm.stats.results.conspec(1).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(1).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(1).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(1).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(1).mask.none = 1;
%     
%     matlabbatch{3}.spm.stats.results.conspec(2).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(2).contrasts = 2;
%     matlabbatch{3}.spm.stats.results.conspec(2).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(2).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(2).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(2).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(2).mask.none = 1;
%     
%     matlabbatch{3}.spm.stats.results.conspec(3).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(3).contrasts = 3;
%     matlabbatch{3}.spm.stats.results.conspec(3).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(3).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(3).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(3).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(3).mask.none = 1;
%     
%     matlabbatch{3}.spm.stats.results.conspec(4).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(4).contrasts = 4;
%     matlabbatch{3}.spm.stats.results.conspec(4).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(4).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(4).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(4).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(4).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(5).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(5).contrasts = 5;
%     matlabbatch{3}.spm.stats.results.conspec(5).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(5).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(5).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(5).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(5).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(6).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(6).contrasts = 6;
%     matlabbatch{3}.spm.stats.results.conspec(6).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(6).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(6).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(6).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(6).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(7).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(7).contrasts = 7;
%     matlabbatch{3}.spm.stats.results.conspec(7).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(7).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(7).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(7).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(7).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(8).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(8).contrasts = 8;
%     matlabbatch{3}.spm.stats.results.conspec(8).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(8).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(8).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(8).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(8).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(9).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(9).contrasts = 9;
%     matlabbatch{3}.spm.stats.results.conspec(9).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(9).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(9).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(9).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(9).mask.none = 1;
%         
%     matlabbatch{3}.spm.stats.results.conspec(10).titlestr = '';
%     matlabbatch{3}.spm.stats.results.conspec(10).contrasts = 10;
%     matlabbatch{3}.spm.stats.results.conspec(10).threshdesc = 'none';
%     matlabbatch{3}.spm.stats.results.conspec(10).thresh = 0.001;
%     matlabbatch{3}.spm.stats.results.conspec(10).extent = 0;
%     matlabbatch{3}.spm.stats.results.conspec(10).conjunction = 1;
%     matlabbatch{3}.spm.stats.results.conspec(10).mask.none = 1;
%     
%     
%     
%     matlabbatch{3}.spm.stats.results.units = 1;
%     matlabbatch{3}.spm.stats.results.export{1}.ps = true;
%     
%     
   spm_jobman('run',matlabbatch);
%     
    
end

