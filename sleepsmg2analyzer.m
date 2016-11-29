%{
sleepsmg2analyzer.m

This script converts staging data created using sleepSMG to a .txt file
importable in BrainVision Analyzer 2.1.

Created by: Ahren Fitzroy, UMass Amherst
Last edited: 2016-11-29

Dependencies: None directly, but requires input from sleepSMG (http://sleepsmg.sourceforge.net/),
which requires EEGLAB (https://sccn.ucsd.edu/eeglab/).

%}

function [] = sleepsmg2analyzer(stageData)
if nargin < 1
    [infn infp] = uigetfile('*.mat', 'Please select the sleepSMG staging file to load');
    load([infp '/' infn]);
end
[outfn outfp] = uiputfile('*.txt', 'Where to export BrainVision .txt format marker file?', 'SUBJECTIDHERE_stages.txt');
outfid = fopen([outfp '/' outfn], 'w+');

%write to output file
fprintf(outfid, ['Sampling rate: ' num2str(stageData.srate) 'Hz, SamplingInterval: ' num2str(1000/stageData.srate) 'ms\n']);
fprintf(outfid, 'Type, Description, Position, Length, Channel')
for evt = 1:size(stageData.onsets,1)
    fprintf(outfid, '\n');
    fprintf(outfid, [num2str(stageData.stages(evt,1)) ', , ' num2str(stageData.onsets(evt,1)) ', 1, All']);
end

fclose(outfid);

end