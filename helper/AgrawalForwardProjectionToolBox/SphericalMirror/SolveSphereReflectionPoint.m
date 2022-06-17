

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

% Solve for spherical mirror reflection point
% r is the radius of the spherical mirror
% spherePos [3 by 1] is 3d location of spherical mirror
% InCamPos is location of pinhole camera
% scenePt is location of scene point

% pp gives the mirror intersection point




function [pp] = SolveSphereReflectionPoint(spherePos,InCamPos,scenePt,r)

pp = [];

% vector from sphere center to camera
z2 = InCamPos - spherePos;
d = norm(z2);

% normalize
z2 = z2/d;

% vector from scene point to sphere center
pDir = scenePt - spherePos;

%find projection on z2
v = z2'*pDir;

%find z1
z1 = pDir - v*z2;

if(norm(z1) < 1e-6)
    %scene point and COP are in the same direction
    pp = r*z2 + spherePos;
    return;
end

u = norm(z1);

% normalize
z1 = z1/u;

%solve
s1 = 4*d^2 * (u^2 + v^2);  % highest order
s2 = -4*d*r^2*(u^2 + v^2 + d*v);
s3 = r^2*(d^2*r^2 - 4*d^2*u^2 - 4*d^2*v^2 + 2*d*r^2*v + r^2*u^2 + r^2*v^2);
s4 = 2*d*r^4*(u^2 + 2*v^2 + 2*d*v);
s5 = -r^4*(d*r + d*u + r*v)*(d*r - d*u + r*v);

s = [s1;s2;s3;s4;s5];

sol = roots(s);

% find real roots
idx = find(imag(sol) < 1e-6);
if(isempty(idx))
    disp('No real roots in solving for sphere reflection');
    return
end
sol = sol(idx);
nn = size(sol,1);



for ii = 1:nn
    
    
    y = sol(ii,1);
    
    x = sqrt(r^2 - y^2);
    
    %find reflection point on mirror in 3D
    p = x*z1 + y*z2 + spherePos;
    
    vi = InCamPos - p;
    vi = vi/norm(vi);
    
    vr = scenePt - p;
    vr = vr/norm(vr);
    
    % find normal
    pn = p - spherePos;
    pn = pn/norm(pn);
    
    % check for angle of reflection
    t1 = acos(vi'*pn)*180/pi;
    t2 = acos(vr'*pn)*180/pi;
    
    if(abs(t1-t2) < 1e-6)
        pp = p;
        return
    end
end




