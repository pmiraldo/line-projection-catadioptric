
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

% Test forward projection for spherical mirror based catadioptric system
% Sphere equation x^2 + y^2 + z^2 - C = 0;

clear all;close all;clc;
format compact;

r = 12; % radius of sphere
C = r^2;

SpherePos = [1.1;2.3;0.5];  % location of sphere

% generate COP of camera
disp('Center of Projection (COP)');
COP = [2.7359  -1.5017    r + 6.7419]';
COP'


N = 1000
count = 0;

tic

for trial = 1:N
    
    %randmply generate a ray and intersect with the mirror
    x = (rand(1,1) - 0.5)*0.2;
    y = (rand(1,1) - 0.5)*0.2;
    
    % ray from camera. Camera is on top
    v = [x;y;-1];
    
    %find intersection with mirror. COP + k*v should intersect the mirror
    % norm of COP + k*v - SpherePos should be r
    aa = v'*v;
    bb = 2*(COP - SpherePos)'*v;
    cc = (COP - SpherePos)'*(COP - SpherePos) - C;
    
    kk = bb^2 - 4*aa*cc;
    
    if(kk < 0)
        % no intersection with mirror
        continue;
    end
    
    s1 = (-bb + sqrt(kk))/(2*aa);
    s2 = (-bb - sqrt(kk))/(2*aa);
    
    % take first intersection
    s = min(s1,s2);
    
    
    M = COP + s*v; % M is the point on mirror
    
    %check M should lie on the mirror
    count = count + 1;
    ee(count,1) = (M - SpherePos)'*(M - SpherePos) - C;
    
    %find normal at M
    n = M - SpherePos;
    n = n/norm(n);
    
    % find reflected ray
    vr = v - 2*n*(v'*n);
    vr = vr/norm(vr);
    
    % choose a point on this ray
    P = M + 20*vr;
    
    % now compute forward projection using given point P
    solMirrorPoint = SolveSphereReflectionPoint(SpherePos,COP,P,r);
    
    
    %check the obtained mirror point with M
    tt = abs(solMirrorPoint - M);
    ee2(count,1) = sum(tt(:));
    
    
    
end

toc


figure;plot(ee,'r*-');title('error in mirror equation');

figure;plot(ee2,'r*-');title('error in mirror interesection point computed using FP');



