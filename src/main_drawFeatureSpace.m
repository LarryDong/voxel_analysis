clc;clear;close all;

name = "TUHH-p1";           % TUHH-p1, terrain-p1, corridor
input_folder = "features/"+name;

fig_feature_space = figure("Name", "Feature space"); hold on;
xlabel("planarity"); xlim([0, 1]);
zlabel("linearity"); ylim([0, 1]);
ylabel("surface variantion"); zlim([0, 1]);
grid on;
title(name);

fig_voxel = figure("Name", "Show Voxel");


for index = 1:500
    filename = sprintf("%s/%d.mat", input_folder, index);
    if ~exist(filename, "file")
        fprintf("==> Error. Cannot find file: %s \n", filename);
        return ;
    else
        load(filename);         % load: pts_norm, feat
        % feat = double(feat);
        lam1 = feat(1);
        lam2 = feat(2);
        lam3 = feat(3);

        planarity = (lam2-lam3)/lam1;
        linearity = (lam1-lam2)/lam1;
        surface_variantion = lam3/(lam1+lam2+lam3);

        figure(fig_feature_space);

        f = [planarity, surface_variantion, linearity];
        scatter_handle = plot3(f(1), f(2), f(3), '.', 'MarkerSize', 10, 'Color', 'r');
        
        % 鼠标单击时绘制对应的voxel
        scatter_handle.UserData = [scatter_handle.UserData; f(1), f(2), f(3), index]; % 将原始数据和索引存储在 UserData 中    
        scatter_handle.ButtonDownFcn = @(src, event) displayPointInfo(src, event, fig_voxel, pts_norm);

        fprintf("index: %d \n", index);
    end
end



% 点击回调函数，用于显示点击点的信息
function displayPointInfo(src, event, fig, pts)
    % 获取点击位置
    click_position = event.IntersectionPoint;
    
    % 从 UserData 中提取数据
    data_with_index = src.UserData;
    
    % 查找与点击位置最接近的点
    distances = vecnorm(data_with_index(:,1:3) - click_position, 2, 2);
    [~, closest_index] = min(distances);
    
    % 提取该点的索引和坐标
    point_coords = data_with_index(closest_index, 1:3);
    point_index = data_with_index(closest_index, 4);
    
    % 显示该点的索引和坐标
    disp(['点击的点信息：']);
    disp(['坐标: (', num2str(point_coords(1)), ', ', num2str(point_coords(2)), ', ', num2str(point_coords(3)), ')']);
    disp(['索引: ', num2str(point_index)]);

    % 显示这个voxel
    
    figure(fig);
    clf(fig);
    
    hold on;
    % plot3(pts(:,1), pts(:,2), pts(:,3), 'r.', 'MarkerSize', 10, 'Color', 'k');
    plotVoxel(fig, pts);

end

