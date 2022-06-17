%% CVPR 2022 Submission #11316. CONFIDENTIAL REVIEW COPY. DO NOT DISTRIBUTE.
% MATLAB R2020b/R2021a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: plotMirror - prints a quadric mirror surface
%   input: 
%       A,B,C - mirror parameters (x^2 + y^2 + Az^2 + Bz - C = 0)
%       xymax,zmin,zmax - valid region of the mirror in the cartesian space 
%       step_xyz - resolution of the plotted mirror
%   output:
%       []
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_mirror(A, B, C, xymax, zmin, zmax, step_xyz)

    c2 = A; c1 = B; c0 = -C;
    if c1^2 - 4*c0*c2 < 0
        error('Mirror parameters invalid! Try again.');
    end
    [X,Y,Z] = meshgrid(-xymax:step_xyz:xymax,-xymax:step_xyz:xymax,zmin:step_xyz:zmax);
    F = X.^2 + Y.^2 + A*Z.^2 + B*Z - C;
    
    grey = [0.7,0.7,0.7];
    p = patch(isosurface(X, Y, Z, F, 0));
    p.FaceColor = grey;
    p.EdgeColor = 'none';
    p.FaceAlpha = 1;
    lightangle(gca,-45,30)
    
end