
clc;clear;close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
name = "corridor";              % TUHH-p1, terrain-p1, corridor

voxel_folder = "./voxels/" + name;
full_pc_file = "pointcloud_" + name + ".mat";

fig_voxel = figure("Name", "Voxel");
fig_pc = figure("Name", "Full-PC");

%% draw full pc
load("pointcloud_" + name + ".mat");
figure(fig_pc);
title("Full pointcloud");
full_pc = lidar_pos(1:2:end, :);
plot3(full_pc(:,1), full_pc(:,2), full_pc(:,3), ".", "MarkerSize", 2, "Color", [0.5,0.5,0.5]);
axis("equal");
xlabel("m");
ylabel("m");
zlabel("m");
cube_handler1 = [];
cube_handler2 = [];

%% plot voxel and save features.

output_folder = "./features/" + name;
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
    fprintf("--> Folder not exist. Create. \n");
end


for index = 1:99999
    filename = sprintf("%s/%d.mat", voxel_folder, index);
    if ~exist(filename, "file")
        fprintf("==> Error. Cannot find file: %s \n", filename);
        return ;
    else
        load(filename);         % load: pts, voxel_size, (ix, iy, yz), (min_x,y,z)

        % 绘制voxel，并提取特征。
        % pts_norm = plotVoxel(fig_voxel, pts, ix, iy, iz, min_x, min_y, min_z, voxel_size);
        pts_norm = pts - [ix-0.5, iy-0.5, iz-0.5]*voxel_size - [min_x, min_y, min_z];

        title(filename);
        feat = extractFeatures(pts);

        % string_all_lambda = sprintf("lambda: %.4f, %.4f, %.4f", feat(1), feat(2), feat(3));
        % planarity = (feat(2)-feat(3)) / feat(1);
        % sphericity = feat(3) / feat(1);
        % string_planarity = sprintf("planarity: %.2f", planarity);
        % string_sphericity = sprintf("sphericity: %.2f", sphericity);
        % labelTextOnFigure(fig_voxel, string_all_lambda, string_planarity, string_sphericity);
        
        % % 绘制voxel在full-pc中的位置
        % eraseVoxelPosition(fig_pc, cube_handler1, cube_handler2);
        % [cube_handler1, cube_handler2] = drawVoxelPosition(fig_pc, ix,iy,iz,min_x, min_y, min_z, voxel_size);
        % title(filename);

        % if(planarity < 0.5)
        %     3;
        % end
        
        fprintf("idx: %d\n", index);

        % save features
        output_filename = sprintf("%s/%d.mat", output_folder , index);
        save(output_filename, "pts_norm", "feat");

    end
end
