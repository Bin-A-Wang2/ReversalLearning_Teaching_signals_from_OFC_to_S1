
function batch_DICOM_Import_RL(Subject)


RootDir='D:\Bochum\DATA\fMRI_RL_GoNoGo\';
prfx='Sub';
Nr_run=3;

for i=1:length(Subject)
    sub=Subject(i);
    inputpath= [RootDir,'Rawdata_RL\',prfx,num2str(sub,'%.2d')];
    outputpath= [RootDir,'Preprocessing_RL\',prfx,num2str(sub,'%.2d')];
    mkdir(outputpath);
    mkdir([outputpath,'\RUN1']);
    mkdir([outputpath,'\RUN2']);
    mkdir([outputpath,'\RUN3']);
    mkdir([outputpath,'\T1']);
    %% find the path for raw data in 3 RUNS
    
    for j=1:Nr_run
        
        rawpath1=[inputpath,'\RUN',num2str(j),'\DICOM\'];
        rawdir1=dir(rawpath1);
        
        for i=1:(length(rawdir1)-10)
            rawfile1{i,j}=[rawpath1,rawdir1(i+10).name];
        end
        
        rawpath2=[inputpath,'\RUN',num2str(j),'\DICOM\00000001\'];
        rawdir2=dir(rawpath2);
        
        for i=1:(length(rawdir2)-2)
            rawfile2{i,j}=[rawpath2,rawdir2(i+2).name];
        end
        
        rawpath3=[inputpath,'\RUN',num2str(j),'\DICOM\00000002\'];
        rawdir3=dir(rawpath3);
        for i=1:(length(rawdir3)-2)
            rawfile3{i,j}=[rawpath3,rawdir3(i+2).name];
        end
        
        rawpath4=[inputpath,'\RUN',num2str(j),'\DICOM\00000003\'];
        rawdir4=dir(rawpath4);
        for i=1:(length(rawdir4)-2)
            rawfile4{i,j}=[rawpath4,rawdir4(i+2).name];
        end
        
        rawpath5=[inputpath,'\RUN',num2str(j),'\DICOM\00000004\'];
        rawdir5=dir(rawpath5);
        for i=1:(length(rawdir5)-2)
            rawfile5{i,j}=[rawpath5,rawdir5(i+2).name];
        end
        
        rawpath6=[inputpath,'\RUN',num2str(j),'\DICOM\00000005\'];
        rawdir6=dir(rawpath6);
        for i=1:(length(rawdir6)-2)
            rawfile6{i,j}=[rawpath6,rawdir6(i+2).name];
        end
        
        rawpath7=[inputpath,'\RUN',num2str(j),'\DICOM\00000006\'];
        rawdir7=dir(rawpath7);
        for i=1:(length(rawdir7)-2)
            rawfile7{i,j}=[rawpath7,rawdir7(i+2).name];
        end
        
        rawpath8=[inputpath,'\RUN',num2str(j),'\DICOM\00000007\'];
        rawdir8=dir(rawpath8);
        for i=1:(length(rawdir8)-2)
            rawfile8{i,j}=[rawpath8,rawdir8(i+2).name];
        end
        
        rawpath9=[inputpath,'\RUN',num2str(j),'\DICOM\00000008\'];
        rawdir9=dir(rawpath9);
        for i=1:(length(rawdir9)-2)
            rawfile9{i,j}=[rawpath9,rawdir9(i+2).name];
        end
    end
    rawfile=[rawfile1;rawfile2;rawfile3;rawfile4;rawfile5;rawfile6;rawfile7;rawfile8;rawfile9];
    %% find the path for T1 data
    T1path=[inputpath,'\T1\DICOM\'];
    T1dir=dir(T1path);
    for i=1:(length(T1dir)-2)
        rawT1{i,1}=[T1path,T1dir(i+2).name];
    end
    
    %%
    matlabbatch{1}.spm.util.import.dicom.data = rawfile(:,1);
    id=cellfun('length',matlabbatch{1, 1}.spm.util.import.dicom.data);
    matlabbatch{1, 1}.spm.util.import.dicom.data(id==0)=[];
    
    matlabbatch{1}.spm.util.import.dicom.root = 'flat';
    matlabbatch{1}.spm.util.import.dicom.outdir = {[outputpath,'\RUN1']};
    matlabbatch{1}.spm.util.import.dicom.protfilter = '.*';
    matlabbatch{1}.spm.util.import.dicom.convopts.format = 'nii';
    matlabbatch{1}.spm.util.import.dicom.convopts.meta = 0;
    matlabbatch{1}.spm.util.import.dicom.convopts.icedims = 0;
    %%
    matlabbatch{2}.spm.util.import.dicom.data = rawfile(:,2);
    id=cellfun('length',matlabbatch{1,2}.spm.util.import.dicom.data);
    matlabbatch{1,2}.spm.util.import.dicom.data(id==0)=[];
    
    matlabbatch{2}.spm.util.import.dicom.root = 'flat';
    matlabbatch{2}.spm.util.import.dicom.outdir = {[outputpath,'\RUN2']};
    matlabbatch{2}.spm.util.import.dicom.protfilter = '.*';
    matlabbatch{2}.spm.util.import.dicom.convopts.format = 'nii';
    matlabbatch{2}.spm.util.import.dicom.convopts.meta = 0;
    matlabbatch{2}.spm.util.import.dicom.convopts.icedims = 0;
    %%
    matlabbatch{3}.spm.util.import.dicom.data = rawfile(:,3);
    id=cellfun('length',matlabbatch{1,3}.spm.util.import.dicom.data);
    matlabbatch{1,3}.spm.util.import.dicom.data(id==0)=[];
    
    matlabbatch{3}.spm.util.import.dicom.root = 'flat';
    matlabbatch{3}.spm.util.import.dicom.outdir = {[outputpath,'\RUN3']};
    matlabbatch{3}.spm.util.import.dicom.protfilter = '.*';
    matlabbatch{3}.spm.util.import.dicom.convopts.format = 'nii';
    matlabbatch{3}.spm.util.import.dicom.convopts.meta = 0;
    matlabbatch{3}.spm.util.import.dicom.convopts.icedims = 0;
    %%
    matlabbatch{4}.spm.util.import.dicom.data = rawT1;
    %%
    matlabbatch{4}.spm.util.import.dicom.root = 'flat';
    matlabbatch{4}.spm.util.import.dicom.outdir = {[outputpath,'\T1']};
    matlabbatch{4}.spm.util.import.dicom.protfilter = '.*';
    matlabbatch{4}.spm.util.import.dicom.convopts.format = 'nii';
    matlabbatch{4}.spm.util.import.dicom.convopts.meta = 0;
    matlabbatch{4}.spm.util.import.dicom.convopts.icedims = 0;
    
    spm_jobman('run',matlabbatch);
end
    
