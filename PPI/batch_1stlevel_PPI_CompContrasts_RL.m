% List of open inputs
function batch_1stlevel_PPI_CompContrasts_RL(RootDir,Subjects,VOIname,contrast_name)  %Subjects=[1 2 4 6 9 10 12 15 16 17 18 19 20 21 22 23 24 25 26 28 29 30 31 32 33];

%spm('defaults','fMRI')
prfx='Sub';

for i=1:length(Subjects)
    sub=Subjects(i);
    inputpath= fullfile(RootDir,'Results_OFC_S1\Participants\',[prfx,num2str(sub,'%.2d')],['PPI_',VOIname]);
      
    %% define the name and contrast
    
    
    contrast= [0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0];

    matlabbatch{1}.spm.stats.con.spmmat(1) = {fullfile(inputpath,'\SPM.mat')};
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = contrast_name;
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = contrast;
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

    matlabbatch{1}.spm.stats.con.delete = 0;
    
%     %%result check
%     matlabbatch{2}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
%     matlabbatch{2}.spm.stats.results.conspec(1).titlestr = '';
%     matlabbatch{2}.spm.stats.results.conspec(1).contrasts = 1;
%     matlabbatch{2}.spm.stats.results.conspec(1).threshdesc = 'none';
%     matlabbatch{2}.spm.stats.results.conspec(1).thresh = 0.001;
%     matlabbatch{2}.spm.stats.results.conspec(1).extent = 0;
%     matlabbatch{2}.spm.stats.results.conspec(1).conjunction = 1;
%     matlabbatch{2}.spm.stats.results.conspec(1).mask.none = 1;
%     
%     matlabbatch{2}.spm.stats.results.conspec(2).titlestr = '';
%     matlabbatch{2}.spm.stats.results.conspec(2).contrasts = 2;
%     matlabbatch{2}.spm.stats.results.conspec(2).threshdesc = 'none';
%     matlabbatch{2}.spm.stats.results.conspec(2).thresh = 0.001;
%     matlabbatch{2}.spm.stats.results.conspec(2).extent = 0;
%     matlabbatch{2}.spm.stats.results.conspec(2).conjunction = 1;
%     matlabbatch{2}.spm.stats.results.conspec(2).mask.none = 1;
    
       
%     
%     matlabbatch{2}.spm.stats.results.units = 1;
%     matlabbatch{2}.spm.stats.results.export{1}.ps = true;
    
    spm_jobman('run',matlabbatch);
    
end

