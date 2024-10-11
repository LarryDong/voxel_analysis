
function [voxel_1, voxel_2] = eraseVoxelPosition(fig, voxel_1, voxel_2)
    if ~isempty(voxel_1) && isvalid(voxel_1)
        delete(voxel_1);
        voxel_1 = [];
    end

    if ~isempty(voxel_2) && isvalid(voxel_2)
        delete(voxel_2);
        voxel_2 = [];
    end
end
