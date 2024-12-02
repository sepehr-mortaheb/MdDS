clc 
clear 

%% Initialization 

% --- Set the following directories --- 

% Directory of the BIDS formated data:
bids_dir = '/Users/sepehrmortaheb/Desktop/MdDS_test/data';
% Save directory of the fMRI processing:
save_dir = '/Users/sepehrmortaheb/Desktop/MdDS_test/preprocessed';

%##########################################################################
% --- Set the Acquisition Parameters --- 

scanner = 'vida'; % pris, vida
task_name = 'rest';

[func_TR, echo_time, total_EPI_rot, stc_num, stc_ord, stc_ref] = func_ReadParams(scanner);

%##########################################################################
% --- Set the Participants Information --- 

% Subjects list [Ex: {'sub-XXX'; 'sub-YYY'}]
subj_list = {'sub-patientMT09'};

% Sessions list [Ex: {'ses-ZZZ'; 'ses-TTT'}]
ses_list = {'ses-post'};

%##########################################################################
% --- Creating Handy Variables and AddPath Required Directories ---

% Directories Struct
art_dir = which('art');
art_dir(end-4:end) = []; 
spm_dir = which('spm');
spm_dir(end-4:end) = [];
Dirs = struct();
Dirs.bids = bids_dir; 
Dirs.out = save_dir;
Dirs.spm = spm_dir;
Dirs.art = art_dir;

% Acquisition Parameters Struct
AcqParams = struct();
AcqParams.name = task_name;
AcqParams.tr = func_TR; 
AcqParams.et = echo_time;
AcqParams.trot = total_EPI_rot;
AcqParams.nslc = stc_num;
AcqParams.ordslc = stc_ord;
AcqParams.refslc = stc_ref;
AcqParams.scanner = scanner;

% Subject Information Struct
Subjects(length(subj_list)) = struct();
for i=1:length(subj_list)
    Subjects(i).name = subj_list{i};
    Subjects(i).dir = fullfile(bids_dir, subj_list{i});
    Subjects(i).sessions = ses_list; 
end

% Adding required paths 
addpath(art_dir);
addpath(spm_dir);
addpath(fullfile(spm_dir, 'src'));
addpath('./functions');

%% Functional Pipeline 

for subj_num = 1:numel(subj_list)
    subj = subj_list{subj_num};
    func_PipelineSS(Dirs, Subjects(subj_num), AcqParams);
end