function [beta, connection_ub_ave, throughput_ub_ave, connection_he_ave,...
    throughput_he_ave, obj_bm_ave, obj_ub_ave, obj_he_ave] = normalizedResults(mainFolder)

[beta, connection_ub, throughput_ub, obj_ub, connection_he, ...
    throughput_he, obj_he, obj_bm] = collectData(mainFolder);

connection_ub_ave = mean(connection_ub, 2);
throughput_ub_ave = mean(throughput_ub, 2);
connection_he_ave = mean(connection_he, 2);
throughput_he_ave = mean(throughput_he, 2);
obj_ub_ave = mean(obj_ub, 2);
obj_he_ave = mean(obj_he, 2);

beta = beta(:, 1);

obj_bm_ave = zeros(size(obj_bm{1}));
for i=1:length(obj_bm)
    obj_bm_ave = obj_bm_ave+obj_bm{i};
end
obj_bm_ave = obj_bm_ave(2:end, :)/length(obj_bm);

% connection_he_ave = smooth(beta, connection_he_ave, 5);
% throughput_he_ave = smooth(beta, throughput_he_ave, 5);
