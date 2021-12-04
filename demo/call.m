myDir = 'Healthy'; %gets directory
myFiles = dir(fullfile(myDir,'*.wav')); %gets all wav files in struct
i=1;
for k = 1:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile('Healthy', baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    f=ones(40,16);
    f(1:40,1:15)=final(fullFileName);
    csvwrite(['healthy',num2str(i),'.csv'],f);
    i=i+1;
end