
function plotVoxel(fig, filename)
    figure(fig);
    load(filename);
    pts_norm = pts - [ix-0.5, iy-0.5, iz-0.5]*voxel_size - [min_x, min_y, min_z];
    plot3(pts_norm(:,1), pts_norm(:,2), pts_norm(:,3), 'k.', "MarkerSize", 20);
    
    % title(num2str(planarity));
    axis("equal");
    r = voxel_size;
    xlim([-r, r]);
    ylim([-r, r]);
    zlim([-r, r]);
    grid on;
    view([25,30]);

    % 隐藏坐标轴刻度标签
    set(gca, 'XTickLabel', []); % 隐藏 X 轴标签
    set(gca, 'YTickLabel', []); % 隐藏 Y 轴标签
    set(gca, 'ZTickLabel', []); % 隐藏 Z 轴标签
    
    % lidar_points = pts;
end