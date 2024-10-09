
clc;clear;close all;

folder = "./voxel_terrain";

fig = figure("Name", "Voxel");
index = 0;
for index = 0:99999
    filename = sprintf("%s/%d.mat", folder, index);
    if ~exist(filename, "file")
        fprintf("==> Error. Cannot find file: %s \n", filename);
        return ;
    else
        % fig = figure("Name", num2str(index));
        load(filename);
        plotVoxel(fig, filename);
        feat = extractFeatures(pts);

        string_all_lambda = sprintf("lambda: %.4f, %.4f, %.4f", feat(1), feat(2), feat(3));
        planarity = (feat(2)-feat(3)) / feat(1);
        sphericity = feat(3) / feat(1);
        string_planarity = sprintf("planarity: %.4f", planarity);
        string_sphericity = sprintf("sphericity: %.4f", sphericity);
        labelTextOnFigure(fig, string_all_lambda, string_planarity, string_sphericity);
        
        1;
    end
end
