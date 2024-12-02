function [func_TR, echo_time, total_EPI_rot, stc_num, stc_ord, stc_ref] = func_ReadParams(scanner)

% Repetition Time
func_TR = 0.7;
% Echo time of (TE) of the functional data (ms)
echo_time = [4.92 7.38];
% Number of Slices
stc_num = 54;
% Slice Order (1=ascending, 2=descending, 3=interleaved(middle-top),
% 4=interleaved(buttom-up), 5=interleaved(top-down), 6:slice timings
% available in the JSON file)
stc_ord = 6;
% Reference Slice
stc_ref = 0;
% Total EPI read-out time (ms)
if strcmp(scanner , 'pris')
    total_EPI_rot = 49.8007;
elseif strcmp(scanner , 'vida')
    total_EPI_rot = 46.4789;
end