function install
path = mfilename('fullpath');
path = path(1:end-7);
load('example_Images_data.mat','Images_pre')
Images = cell(length(Images_pre),1);
for i = 1:length(Images_pre)
    Images{i} = [path,Images_pre{i}];
end
save('example_Images_data.mat','Images','-append')
end