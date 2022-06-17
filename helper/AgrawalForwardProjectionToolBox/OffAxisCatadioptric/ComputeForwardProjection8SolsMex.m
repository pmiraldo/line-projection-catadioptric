
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


% Compute the point on the mirror where reflection happens
% Given:
% MirrorEq = A*z^2 + B*z + x^2 + y^2 - C
% camera at COP (3 by 1 vector)
% 3D point at XYZ (3 by 1 vector)
% Output: Mirror Point where reflection happens



function [p,thetaerror] = ComputeForwardProjection8SolsMex(COP,XYZ,A,B,C,maxZ)

p = [];
thetaerror = [];

%first rotate the COP so that its x becomes zero; rotate to nearest y axis
s = sqrt(COP(1)^2 + COP(2)^2);
Rmat = [COP(2)/s -COP(1)/s 0 ; COP(1)/s COP(2)/s 0 ; 0 0 1];
clear s

COP1 = Rmat*COP;
XYZ1 = Rmat*XYZ;

% check
if(abs(COP1(1)>1e-8))
    error('Correct rotation is not done');
end


d1 = COP1(2);
d2 = COP1(3);

u = XYZ1(1);
v = XYZ1(2);
w = XYZ1(3);




EE = [d1 ; d2 ; u; v; w; A ; B ; C];
c = MexComputeForwardProjection8Sols(EE);

c = double(c);

sol = roots(c);

%get real solutions
idx = find(abs(imag(sol)) < 1e-8);

if(isempty(idx))
    disp('no solution found');
    return
end


sol1 = sol(idx);

nn = size(sol1,1);
count = 0;
solMirrorPoint = [];

% find x, y for each solution
for ii = 1:nn
    
    zval = sol1(ii,1);
    
    if(zval > maxZ)
        continue;
    end
    
    c1used = (u*(B/2 + d2 - zval + A*zval))/(v*(B/2 + d2 - zval + A*zval) - d1*(B/2 + w - zval + A*zval));
    c2used = -(d1*u*(B/2 - zval + A*zval) + d1*u*zval)/(v*(B/2 + d2 - zval + A*zval) - d1*(B/2 + w - zval + A*zval));
    
    constantterm = A*zval^2 + B*zval - C;
    
    % substitue in mirror eq to get aa *y ^2  + bb*y + cc = 0
    aa = 1 + c1used^2;
    bb = 2*c1used*c2used;
    cc = c2used^2 + constantterm;
    
    kk = bb^2 - 4*aa*cc;
    
    if(kk >= 0)
        
        count = count + 1;
        y1 = (-bb + sqrt(kk))/(2*aa);
        x1 = c1used*y1 + c2used;
        
        tt = [x1; y1 ; zval];
        solMirrorPoint(:,count) = tt;
        
        count = count + 1;
        y2 = (-bb - sqrt(kk))/(2*aa);
        x2 = c1used*y2 + c2used;
        
        tt = [x2; y2 ; zval];
        solMirrorPoint(:,count) = tt;
        
    end
    
end



if(isempty(solMirrorPoint))
    disp('no real solution found');
    return
end


nn = size(solMirrorPoint,2);

id = [];
thetaerror = [];


% Check for Law of reflection for each solution
for ii = 1:nn
    
    
    tt = Rmat'*solMirrorPoint(:,ii);
    
    x = tt(1);
    y = tt(2);
    z = tt(3);
    
    
    vi = COP - [x;y;z];
    vr = XYZ - [x;y;z];
    normalVec = [x;y;B/2 + A*z];
    normalVec = normalVec/norm(normalVec);
    
    %     %verify coplanarity
    %     ePlane = cross(vi,vr)'*normalVec;
    
    
    theta1 = acos(vi'*normalVec/norm(vi))*180/pi;
    theta2 = acos(vr'*normalVec/norm(vr))*180/pi;
    
    if(abs(theta1-theta2) <= 1e-6)
        %disp(sprintf('coplanar eval = %f, mirror eval = %f, theta1 = %f, theta2 = %f, sign1 = %f, sign2 = %f',ePlane,eval,theta1,theta2,sign1,sign2));
        id = [id ; ii];
        thetaerror = [thetaerror theta1-theta2];
        break;
    end
end

if(~isempty(id))
    tt = Rmat'*solMirrorPoint(:,id);
    p = tt;
else
    disp('no solution found');
end












