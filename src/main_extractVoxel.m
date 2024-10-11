
% 对一个ply文件提取点云，然后分隔到各个voxel中。保存到mat
clc;clear;close all;

ply_name = "TUHH-p1";           % TUHH-p1, terrain-p1, corridor
voxel_size = 0.5; % 体素大小

% 每个voxel最少有多少个点？corridor目前采用15。手持扫描仪：300。TUHH：250
minimal_points_threshold = 250;

%% load point cloud.
filename = "../data/"+ply_name+".ply";
fprintf("--> Loading ply file from: %s \n", filename);
ptCloud = pcread(filename);
fprintf("<-- Loaded. \n");
lidar_pos = ptCloud.Location;

% pcshow(ptCloud);

% downsample the point cloud if necessary.
% ptCloud = pcdownsample(ptCloud, 'gridAverage', 0.05);
% fprintf("--> Total points: %d \n", ptCloud.Count);

% 存储到mat
fprintf("--> Saving Lidar position. \n");
save("pointcloud_"+ply_name+".mat", "lidar_pos");
fprintf("<-- Done. \n");

% 从mat载入
% fprintf("--> Loading lidar pos from mat. \n");
% load("pointcloud_"+ply_name+".mat");
% fprintf("<-- Done. \n");



%% segment the voxel.
fprintf("--> Segment the point into voxels. \n");

min_x = min(lidar_pos(:, 1));
min_y = min(lidar_pos(:, 2));
min_z = min(lidar_pos(:, 3));
max_x = max(lidar_pos(:, 1));
max_y = max(lidar_pos(:, 2));
max_z = max(lidar_pos(:, 3));

voxel_count_x = ceil((max_x - min_x) / voxel_size);
voxel_count_y = ceil((max_y - min_y) / voxel_size);
voxel_count_z = ceil((max_z - min_z) / voxel_size);

voxels = cell(voxel_count_x, voxel_count_y, voxel_count_z);
N = size(lidar_pos,1);
for i = 1:N
    if(mod(i, round(N/10))==0)
        fprintf(".");                   % 输出进度条
    end
    x = lidar_pos(i, 1);
    y = lidar_pos(i, 2);
    z = lidar_pos(i, 3);
    idx_x = floor((x - min_x) / voxel_size) + 1;
    idx_y = floor((y - min_y) / voxel_size) + 1;
    idx_z = floor((z - min_z) / voxel_size) + 1;
    voxels{idx_x, idx_y, idx_z} = [voxels{idx_x, idx_y, idx_z}; [x, y, z]];
end
fprintf("\n <-- Done. Total voxel: %d, %d, %d \n", size(voxels));

% save into folder.
output_folder =  "voxels/"+ply_name;
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
    fprintf("--> Folder not exist. Create. \n");
end

fprintf("--> Start to save data into folders. \n");
index = 0;
for ix = 1:voxel_count_x
    if(mod(ix, round(voxel_count_x/10))==0)
        fprintf(".");
    end
    for iy = 1:voxel_count_y
        for iz = 1:voxel_count_z
            pts = voxels{ix, iy, iz};
            if (size(pts, 1) < minimal_points_threshold)
                continue;
            end
            filename = sprintf('%s/%d.mat', output_folder, index);
            index = index + 1;
            save(filename, "pts", "ix", "iy", "iz", "min_x", "min_y", "min_z", "max_x", "max_y", "max_z", "voxel_size");
        end
    end
end
fprintf("\n<-- done. Total valid voxel: %d \n", index-1);