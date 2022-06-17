
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


clear all;close all;clc;format compact;

% Mirror eq: x^2 + y^2 + A*z^2 + B*z - C = 0;

MIRROR_TYPE = 1  % 1 for hyperbolic, 2 for parabolic. Use your parameters for other mirrors

disp('Mirror Parameters');

if(MIRROR_TYPE==1)
    % hyperbolic mirror
    A = -1.2
    B = 3.4
    C = -33.2
elseif(MIRROR_TYPE==2)
    A = 0
    B = 3.4
    C = 33.2
end


% first find z for x=0, y=0
c = [A ; B ; -C];
s = roots(c);
clear c
if(A >= 0)
    %taking upper portion of mirror
    maxZ = max(s);
else
    % hyperbolic mirror
    %taking lower portion of mirror
    maxZ = min(s);
end
clear s


% generate COP
disp('Center of Projection (COP)');
COP = [27.7359  -10.5017    maxZ + 16.7419]';
COP'


N = 1000
count = 0;

tic

for trial = 1:N
    
    %randmply generate a ray and intersect with the mirror
    x = (rand(1,1) - 0.5)*0.2;
    y = (rand(1,1) - 0.5)*0.2;
    
    % ray from camera
    v = [x;y;-1];
    
    %find intersection with mirror. COP + k*v should intersect the mirror
    aa = v(1)^2 + v(2)^2 + A*v(3)^2;
    bb = 2*COP(1)*v(1) + 2*COP(2)*v(2) + 2*A*COP(3)*v(3) + B*v(3);
    cc = COP(1)^2 + COP(2)^2 + A*COP(3)^2 + B*COP(3) - C;
    
    kk = bb^2 - 4*aa*cc;
    
    if(kk < 0)
        % no intersection with mirror
        continue;
    end
    
    s1 = (-bb + sqrt(kk))/(2*aa);
    s2 = (-bb - sqrt(kk))/(2*aa);
    
    if(A >= 0)
        % take first intersection upper portion
        s = min(s1,s2);
    else
        % take second intersection (lower portion of mirror)
        s = max(s1,s2);
    end
    
    
    M = COP + s*v;
    
    %check M should lie on the mirror
    count = count + 1;
    ee(count,1) = M(1)^2 + M(2)^2 + A*M(3)^2 + B*M(3) - C;
    
    %find normal at M
    n = [2*M(1) ; 2*M(2); 2*A*M(3) + B];
    n = n/norm(n);
    
    % find reflected ray
    vr = v - 2*n*(v'*n);
    vr = vr/norm(vr);
    
    % choose a point on this ray
    P = M + 20*vr;
    
    % now compute forward projection using given point P
    
    
    % matlab version
    %[solMirrorPoint,thetaerror] = ComputeForwardProjection8Sols(COP,P,A,B,C,maxZ);
    
    
    % mex version. Can be much faster. To use it mex MexComputeForwardProjection8Sols.c
    % on your machine
    [solMirrorPoint,thetaerror] = ComputeForwardProjection8SolsMex(COP,P,A,B,C,maxZ);
    
    %check the obtained mirror point with M
    tt = abs(solMirrorPoint - M);
    ee2(count,1) = sum(tt(:));
    
    
    
end

toc


figure;plot(ee,'r*-');title('error in mirror equation');

figure;plot(ee2,'r*-');title('error in mirror interesection point computed using FP');



