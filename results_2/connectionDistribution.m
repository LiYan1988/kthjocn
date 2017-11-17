function [trafficHistogram] = connectionDistribution(filePath, arch, nclasses, edges)
% filePath: the path containing results for all the traffic matrices
load betaString.mat
trafficHistogram = zeros(nclasses, 22);
curdir = dir(filePath);
% process for each traffic matrix
ndir = 0;
coreUsage = {};
nameList = {};
for i = 1:22
    coreUsage{i} = zeros(2);
    nameList{i} = zeros(2);
end
for i = 1:length(curdir)
    if curdir(i).isdir && ~strcmp(curdir(i).name, '.') && ~strcmp(curdir(i).name, '..')
        folderName = strcat(curdir(i).folder, '\', curdir(i).name);
        filenames = dir(folderName);
        
        cnknames = {};
        foldername = filenames(1).folder;
        for j = 1:length(filenames)
            filename = filenames(j).name;
            tmp = strsplit(filename, '_');
            if strcmp(tmp{1}, 'cnklist')
                cnknames = [cnknames, strcat(foldername, '\', filename)];
            end
        end
        
%         filenames = {};
%         for j = 1:length(betaString)
%             tmp = strcat(foldername, '\', filenameRoot, '_', betaString(j), '.csv');
%             filenames = [filenames, strcat(foldername, '\', filenameRoot, '_', betaString(j), '.csv')];
%         end
        
        try
            counter = 1;
            for j = 1:length(cnknames)
                filename = cnknames(j);
                disp(filename)
                tmp = strsplit(filename{end}, '_');
                nameList{j} = str2num(tmp{end}(1:end-4));
                if arch==1 || arch==2
                    [~,~,~,~,~,~,tfk_slot] = importfileConnectionAllocation(filename{1}, 2, inf);
                elseif arch==3
                    [~,~,~,~,~,~,tmp,tfk_slot] = importfileConnectionAllocation3(filename{1}, 2, inf);
                end
%                 edges = [49, 99, 199, 399, 999, 1999];
                [N, ~, ~] = histcounts(tfk_slot, edges);
                trafficHistogram(:, counter) = trafficHistogram(:, counter)+N'/sum(N);
                counter = counter+1;
                if size(coreUsage{j},1)==2
                    coreUsage{j} = [tmp,tfk_slot];
                else
                    coreUsage{j} = [coreUsage{j};[tmp,tfk_slot]];
                end
            end
            ndir = ndir+1;
        catch
            continue
        end
        
    end
end
trafficHistogram = trafficHistogram/ndir;
tmp = strsplit(curdir(1).folder, '\');
filename = strcat('tfkhist', '_', tmp{end-1}, '_', tmp{end}, '.mat');
save(filename, 'trafficHistogram')
save('coreUsage.mat', 'coreUsage', 'nameList')

