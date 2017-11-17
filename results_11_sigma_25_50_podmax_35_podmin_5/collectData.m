function [beta, connection_ub, throughput_ub, obj_ub, connection_he, ...
    throughput_he, obj_he, benchmarks] = collectData(mainFolder)

curdir = dir(mainFolder);
trafficMatrixNames = {};
results = {};
benchmarks = {};
for i = 1:length(curdir)
    if curdir(i).isdir && ~strcmp(curdir(i).name, '.') && ~strcmp(curdir(i).name, '..')
        trafficMatrixNames = [trafficMatrixNames, curdir(i).name];
        folderName = strcat(curdir(i).folder, '\', curdir(i).name);
        filenames = dir(folderName);
        for j = 1:length(filenames)
            filename = filenames(j).name;
            tmp = strsplit(filename, '_');
            if strcmp(tmp{1}, 'obj') && strcmp(tmp{2}, 'final')
                %                 disp(filename)
                filepath = strcat(filenames(j).folder, '\', filename);
                results = [results, importObjFinal(filepath)];
            end
            % import benchmarks
            folderdir = curdir(i).folder;
            folderdir = strsplit(folderdir, '\');
            arch = strsplit(folderdir{end}, '_');
            arch = arch{1};
            if strcmp(arch, 'A1')
                arch = 1;
            elseif strcmp(arch, 'A2')
                arch = 2;
            elseif strcmp(arch, 'A3')
                arch = 3;
            end
            if strcmp(tmp{1}, 'obj') && strcmp(tmp{2}, 'results')
                filepath = strcat(filenames(j).folder, '\', filename);
                benchmarks = [benchmarks, importBenchMark(filepath, arch)'];
            end
        end
    end
end

betaNumber = size(results{1}, 1);
matrixNumber = length(results);

beta = zeros(betaNumber, matrixNumber);
connection_ub = zeros(betaNumber, matrixNumber);
throughput_ub = zeros(betaNumber, matrixNumber);
obj_ub = zeros(betaNumber, matrixNumber);
% connection_lb = zeros(betaNumber, matrixNumber);
% throughput_lb = zeros(betaNumber, matrixNumber);
% obj_lb = zeros(betaNumber, matrixNumber);
connection_he = zeros(betaNumber, matrixNumber);
throughput_he = zeros(betaNumber, matrixNumber);
obj_he = zeros(betaNumber, matrixNumber);

for i = 1:matrixNumber
    beta(:, i) = results{i}(:, 1);
    connection_ub(:, i) = results{i}(:, 5);
    throughput_ub(:, i) = results{i}(:, 7);
    obj_ub(:, i) = results{i}(:, 8);
    connection_he(:, i) = results{i}(:, 4);
    throughput_he(:, i) = results{i}(:, 6);
    obj_he(:, i) = results{i}(:, 2);
    %     figure;
    %     plot(connection_ub(:, i), throughput_ub(:, i))
    %     hold on;
    %     plot(connection_he(:, i), throughput_he(:, i))
end