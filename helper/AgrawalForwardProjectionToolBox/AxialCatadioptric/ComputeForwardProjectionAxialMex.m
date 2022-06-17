
% Copyright 2012 Mitsubishi Electric Research Laboratories All Rights
% Reserved.

% Permission to use copy and modify this software and its
% documentation without fee for educational, research and non-profit
% purposes is hereby granted, provided that the above copyright notice and
% the following three paragraphs appear in all copies. To request
% permission to incorporate this software into commercial products contact:
% Vice President of Marketing and Business Development; Mitsubishi Electric
% Research Laboratories (MERL), 201 Broadway, Cambridge, MA 02139 or
% <license@merl.com>.

% In no event shall MERL be liable to any party for
% direct, indirect, special, incidental, or consequential damages,
% including lost profits, arising out of the use of this software and its
% documentation, even if MERL has been advised of the possibility of such
% damages. MERL specifically disclaims any warranties, including, but not
% limited to, the implied warranties of merchantability and fitness for a
% particular purpose. The software provided hereunder is on an "as is"
% basis, and MERL has no obligations to provide maintenance, support,
% updates, enhancements or modifications.


% Compute the point on the mirror where reflection happens for axial
% catadioptric cameras
% Given:
% MirrorEq = A*z^2 + B*z + x^2 + y^2 - C
% camera at COP (3 by 1 vector), should be on axis
% 3D point at XYZ (3 by 1 vector)
% Output: Mirror Point where reflection happens
% Axial Setup: Axis is aligned with vertical


function [pp] = ComputeForwardProjectionAxialMex(COP,XYZ,A,B,C,maxZ)


pp = zeros(3,1);
pp(3) = 1;

% COP should be on axis
COP(1) = 0;
COP(2) = 0;
d = COP(3);

%Make z2 along axis
z2 = [0;0;1];

% find z1 orthogonal to z2 in the plane containing the 3D Point and axis
z1 = cross(z2,cross(z2,XYZ));
z1 = z1/norm(z1);


% find projection of 3D point on the plane of reflection
u = z1'*XYZ;
v = z2'*XYZ;

EE = [d ; u ; v; A; B; C];

s = MexComputeForwardProjectionAxial(EE);
s = double(s);

sol = roots(s);




%get real solutions
idx = find(abs(imag(sol)) < 1e-8);

if(isempty(idx))
    disp('no solution found in forward projection');
    return
end


sol1 = sol(idx);

nn = size(sol1,1);

% find x, y for each solution
for ii = 1:nn
    
    
    y = sol1(ii,1);
    
    if(y > maxZ)
        continue;
    end
    
    
    x = sign(u)*sqrt(C - A*y^2 - B*y) ;
    
    
    M = x*z1 + y*z2;
    
    
    vi = COP - M;
    vi = vi/norm(vi);
    
    vr = XYZ - M;
    vr = vr/norm(vr);
    
    % find normal
    pn = [2*M(1) ; 2*M(2); 2*A*M(3) + B];
    pn = pn/norm(pn);
    
    
    % check for angle of reflection
    t1 = acos(vi'*pn)*180/pi;
    t2 = acos(vr'*pn)*180/pi;
    
    if(abs(t1-t2) < 1e-6)
        pp = M;
        return
    end
    
    
    
end




