
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



function [pp] = ComputeForwardProjectionAxial(COP,XYZ,A,B,C,maxZ)


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

% precompute powers of known quantities
u2 = u^2;
v2 = v^2;

A2 = A^2;
A3 = A^3;
A4 = A^4;

C2 = C^2;
C3 = C^3;

B2 = B^2;
B3 = B^3;
B4 = B^4;
B5 = B^5;

d2 = d^2;

if(A == 0)
    
    %get coeffs. 5th degree equation need to be solved
    s1 = 16*B3;
    s2 = -16*B2*(B2 - u2 + 5*C);
    s3 = 4*B*(20*B2*C - 2*B3*d - 8*C*u2 - 2*B3*v + B4 + 32*C2 - 6*B2*u2 + 8*B*C*d + 8*B*C*v - 8*B*d*u2 - 8*B2*d*v);
    s4 = 4*B5*d + 4*v*B5 - 20*B4*C + 16*v*B4*d + 9*B4*u2 + 8*B3*C*d + 8*v*B3*C + 16*B3*d*u2 - 128*B2*C2 + 96*v*B2*C*d + 56*B2*C*u2 + 16*B2*d2*u2 - 96*B*C2*d - 96*v*B*C2 + 64*B*C*d*u2 - 64*C3 + 16*C2*u2;
    s5 = B5*d2 + 2*B5*d*v + B5*v2 - 12*B4*C*d - 12*B4*C*v + 8*B4*d2*v + 6*B4*d*u2 + 8*B4*d*v2 + 32*B3*C2 - 8*B3*C*d2 - 64*B3*C*d*v - 24*B3*C*u2 - 8*B3*C*v2 + 8*B3*d2*u2 + 16*B3*d2*v2 + 32*B2*C2*d + 32*B2*C2*v - 32*B2*C*d2*v - 48*B2*C*d*u2 - 32*B2*C*d*v2 + 64*B*C3 + 16*B*C2*d2 - 32*B*C2*d*v - 32*B*C2*u2 + 16*B*C2*v2 - 32*B*C*d2*u2 + 64*C3*d + 64*C3*v - 32*C2*d*u2;
    s6 = - B4*C*d2 - 2*B4*C*d*v - B4*C*v2 + B4*d2*u2 + 8*B3*C2*d + 8*B3*C2*v - 8*B3*C*d2*v - 8*B3*C*d*u2 - 8*B3*C*d*v2 - 16*B2*C3 + 8*B2*C2*d2 + 48*B2*C2*d*v + 16*B2*C2*u2 + 8*B2*C2*v2 - 8*B2*C*d2*u2 - 16*B2*C*d2*v2 - 32*B*C3*d - 32*B*C3*v + 32*B*C2*d2*v + 32*B*C2*d*u2 + 32*B*C2*d*v2 - 16*C3*d2 - 32*C3*d*v - 16*C3*v2 + 16*C2*d2*u2;
    
    s = [s1;s2;s3;s4;s5;s6];
else
    
    %get coeffs. 6th degree equation need to be solved
    s1 = 16*A*(A - 1)^2*(A2*d2 + 2*A2*d*v + A2*v2 + 2*A*B*d + 2*A*B*v + A*u2 + B2);
    s2 = 16*(A - 1)*(3*A3*B*d2 + 6*A3*B*d*v + 3*A3*B*v2 + 4*A3*d2*v + 2*A3*d*u2 + 4*A3*d*v2 - 4*C*A3*d - 4*C*A3*v + 5*A2*B2*d + 5*A2*B2*v - A2*B*d2 + 2*A2*B*d*v + 4*A2*B*u2 - A2*B*v2 - 4*C*A2*B + 2*A2*d*u2 + 4*C*A2*d + 4*C*A2*v + 2*A*B3 - 2*A*B2*d - 2*A*B2*v - 2*A*B*u2 + 4*C*A*B - B3);
    s3 = -4*(4*A4*C*d2 + 8*A4*C*d*v + 4*A4*C*v2 - 4*A4*d2*u2 - 14*A3*B2*d2 - 28*A3*B2*d*v - 14*A3*B2*v2 + 48*A3*B*C*d + 48*A3*B*C*v - 40*A3*B*d2*v - 24*A3*B*d*u2 - 40*A3*B*d*v2 - 16*A3*C2 + 32*A3*C*d*v + 16*A3*C*u2 - 8*A3*d2*u2 - 16*A3*d2*v2 - 18*A2*B3*d - 18*A2*B3*v + 36*A2*B2*C + 10*A2*B2*d2 - 12*A2*B2*d*v - 22*A2*B2*u2 + 10*A2*B2*v2 - 64*A2*B*C*d - 64*A2*B*C*v + 24*A2*B*d2*v - 8*A2*B*d*u2 + 24*A2*B*d*v2 + 32*A2*C2 - 4*A2*C*d2 - 40*A2*C*d*v - 24*A2*C*u2 - 4*A2*C*v2 - 4*A2*d2*u2 - 5*A*B4 + 14*A*B3*d + 14*A*B3*v - 56*A*B2*C + 24*A*B2*d*v + 22*A*B2*u2 + 16*A*B*C*d + 16*A*B*C*v + 16*A*B*d*u2 - 16*A*C2 + 8*A*C*u2 + 4*B4 + 20*B2*C - 4*B2*u2);
    s4 = -4*(8*A3*B*C*d2 + 16*A3*B*C*d*v + 8*A3*B*C*v2 - 8*A3*B*d2*u2 - 16*A3*C2*d - 16*A3*C2*v + 16*A3*C*d2*v + 16*A3*C*d*u2 + 16*A3*C*d*v2 - 8*A2*B3*d2 - 16*A2*B3*d*v - 8*A2*B3*v2 + 48*A2*B2*C*d + 48*A2*B2*C*v - 36*A2*B2*d2*v - 24*A2*B2*d*u2 - 36*A2*B2*d*v2 - 48*A2*B*C2 + 8*A2*B*C*d2 + 96*A2*B*C*d*v + 40*A2*B*C*u2 + 8*A2*B*C*v2 - 16*A2*B*d2*u2 - 32*A2*B*d2*v2 + 16*A2*C2*d + 16*A2*C2*v + 16*A2*C*d*u2 - 7*A*B4*d - 7*A*B4*v + 24*A*B3*C + 2*A*B3*d2 - 16*A*B3*d*v - 12*A*B3*u2 + 2*A*B3*v2 - 28*A*B2*C*d - 28*A*B2*C*v + 8*A*B2*d2*v - 12*A*B2*d*u2 + 8*A*B2*d*v2 + 80*A*B*C2 - 8*A*B*C*d2 - 80*A*B*C*d*v - 40*A*B*C*u2 - 8*A*B*C*v2 - 8*A*B*d2*u2 - 16*A*C*d*u2 - B5 + 2*B4*d + 2*B4*v - 20*B3*C + 8*B3*d*v + 6*B3*u2 - 8*B2*C*d - 8*B2*C*v + 8*B2*d*u2 - 32*B*C2 + 8*B*C*u2);
    s5 = - 24*A2*B2*C*d2 - 48*A2*B2*C*d*v - 24*A2*B2*C*v2 + 24*A2*B2*d2*u2 + 96*A2*B*C2*d + 96*A2*B*C2*v - 96*A2*B*C*d2*v - 96*A2*B*C*d*u2 - 96*A2*B*C*d*v2 - 64*A2*C3 + 32*A2*C2*d2 + 192*A2*C2*d*v + 64*A2*C2*u2 + 32*A2*C2*v2 - 32*A2*C*d2*u2 - 64*A2*C*d2*v2 + 9*A*B4*d2 + 18*A*B4*d*v + 9*A*B4*v2 - 80*A*B3*C*d - 80*A*B3*C*v + 56*A*B3*d2*v + 40*A*B3*d*u2 + 56*A*B3*d*v2 + 144*A*B2*C2 - 32*A*B2*C*d2 - 288*A*B2*C*d*v - 112*A*B2*C*u2 - 32*A*B2*C*v2 + 40*A*B2*d2*u2 + 80*A*B2*d2*v2 + 32*A*B*C2*d + 32*A*B*C2*v - 64*A*B*C*d2*v - 128*A*B*C*d*u2 - 64*A*B*C*d*v2 + 128*A*C3 - 16*A*C2*d2 - 160*A*C2*d*v - 64*A*C2*u2 - 16*A*C2*v2 - 32*A*C*d2*u2 + 4*B5*d + 4*B5*v - 20*B4*C + 16*B4*d*v + 9*B4*u2 + 8*B3*C*d + 8*B3*C*v + 16*B3*d*u2 - 128*B2*C2 + 96*B2*C*d*v + 56*B2*C*u2 + 16*B2*d2*u2 - 96*B*C2*d - 96*B*C2*v + 64*B*C*d*u2 - 64*C3 + 16*C2*u2;
    s6 = 64*B*C3 + 64*C3*d + 64*C3*v + 32*B3*C2 + B5*d2 + B5*v2 + 16*B*C2*d2 + 32*B2*C2*d - 8*B3*C*d2 - 32*B*C2*u2 - 24*B3*C*u2 + 16*B*C2*v2 + 32*B2*C2*v - 8*B3*C*v2 + 6*B4*d*u2 - 32*C2*d*u2 + 8*B4*d*v2 + 8*B4*d2*v - 64*A*B*C3 + 8*B3*d2*u2 + 16*B3*d2*v2 - 64*A*C3*d - 12*B4*C*d - 64*A*C3*v - 12*B4*C*v + 2*B5*d*v - 32*B*C2*d*v - 64*B3*C*d*v + 32*A*B*C2*d2 + 48*A*B2*C2*d - 8*A*B3*C*d2 + 64*A*B*C2*u2 + 32*A*B*C2*v2 + 48*A*B2*C2*v - 8*A*B3*C*v2 + 64*A*C2*d*u2 + 64*A*C2*d*v2 + 64*A*C2*d2*v - 32*B*C*d2*u2 - 48*B2*C*d*u2 - 32*B2*C*d*v2 - 32*B2*C*d2*v + 8*A*B3*d2*u2 + 192*A*B*C2*d*v - 16*A*B3*C*d*v - 32*A*B*C*d2*u2 - 48*A*B2*C*d*u2 - 64*A*B*C*d2*v2 - 48*A*B2*C*d*v2 - 48*A*B2*C*d2*v;
    s7 = - B4*C*d2 - 2*B4*C*d*v - B4*C*v2 + B4*d2*u2 + 8*B3*C2*d + 8*B3*C2*v - 8*B3*C*d2*v - 8*B3*C*d*u2 - 8*B3*C*d*v2 - 16*B2*C3 + 8*B2*C2*d2 + 48*B2*C2*d*v + 16*B2*C2*u2 + 8*B2*C2*v2 - 8*B2*C*d2*u2 - 16*B2*C*d2*v2 - 32*B*C3*d - 32*B*C3*v + 32*B*C2*d2*v + 32*B*C2*d*u2 + 32*B*C2*d*v2 - 16*C3*d2 - 32*C3*d*v - 16*C3*v2 + 16*C2*d2*u2;
    
    s = [s1;s2;s3;s4;s5;s6;s7];
    
end


sol = roots(s);




%get real solutions
idx = find(abs(imag(sol)) < 1e-8);

if(isempty(idx))
    disp('no solution found in forward projection');
    pp = [0;0;0]
    return
end

sol1 = sol(idx);

nn = size(sol1,1);

pp = zeros(3,nn*2);

% disp(['from the solver: ' , num2str(nn*2)])

% find x, y for each solution
i = 1;
for iii = 1:2
    for ii = 1:nn


        y = sol1(ii,1);

        % if(y > maxZ)
        %     continue;
        % end

        if iii == 1
            x = sqrt(C - A*y^2 - B*y) ;
        else
            x = -sqrt(C - A*y^2 - B*y) ;
        end


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


        if abs(t1-t2) < 1e-6
            pp(:,i) = M;
            i = i+1;
        %     return
        end


    end
    
end




