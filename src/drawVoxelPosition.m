
function [voxel_real, voxel_large] = drawVoxelPosition(fig, ix,iy,iz,min_x,min_y,min_z,voxel_size)
    figure(fig);

    x = ix * voxel_size + min_x;
    y = iy * voxel_size + min_y;
    z = iz * voxel_size + min_z;
    d = voxel_size / 2;
    vertices = [x-d, y-d, z-d;
                x+d, y-d, z-d;
                x+d, y+d, z-d;
                x-d, y+d, z-d;
                x-d, y-d, z+d;
                x+d, y-d, z+d;
                x+d, y+d, z+d;
                x-d, y+d, z+d];
    
    % 定义立方体的面
    faces = [1, 2, 3, 4;
             5, 6, 7, 8;
             1, 5, 8, 4;
             2, 6, 7, 3;
             1, 2, 6, 5;
             4, 3, 7, 8];
    
    voxel_real = patch('Vertices', vertices, 'Faces', faces, ...
                        'FaceColor', 'none', 'EdgeColor', 'r', 'LineWidth', 1);
    
    % 绘制一个更大的，看起来更清楚
    d = voxel_size * 10;
    vertices = [x-d, y-d, z-d;
                x+d, y-d, z-d;
                x+d, y+d, z-d;
                x-d, y+d, z-d;
                x-d, y-d, z+d;
                x+d, y-d, z+d;
                x+d, y+d, z+d;
                x-d, y+d, z+d];
    faces = [1, 2, 3, 4;
             5, 6, 7, 8;
             1, 5, 8, 4;
             2, 6, 7, 3;
             1, 2, 6, 5;
             4, 3, 7, 8];
    
    voxel_large = patch('Vertices', vertices, 'Faces', faces, ...
                        'FaceColor', 'none', 'EdgeColor', 'r', 'LineWidth', 2);
end
