
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


% For a given 3D point and camera location, find the point on a spherical
% mirror where reflection happens. This code is for visualization


clear all;close all;clc;

r = 5;  %radius of the sphere


% define COP of the camera
COP = [0;0;10];
% COP = randn(3,1);
% COP(3) = abs(COP(3));


%location of 3d point
XYZ = 25*randn(3,1);
%XYZ(3) = -abs(XYZ(3)) - 2*r; %place it below the camera
XYZ(3) = abs(XYZ(3));


% location of spherical mirror
% SpherePos = randn(3,1);
% SpherePos = 5*r*SpherePos/norm(SpherePos);
% SpherePos(3) = abs(SpherePos(3));  %place it above the camera
SpherePos = [0;0;0];

disp(sprintf('COP of camera = %f, %f, %f',COP(1),COP(2),COP(3)));
disp(sprintf('3D Point = %f, %f, %f',XYZ(1),XYZ(2),XYZ(3)));
disp(sprintf('Center of Spherical mirror = %f, %f, %f',SpherePos(1),SpherePos(2),SpherePos(3)));


disp('Solving for reflection point on the spherical mirror');
solMirrorPoint = SolveSphereReflectionPoint(SpherePos,COP,XYZ,r);


disp(sprintf('Mirror reflection Point = %f, %f, %f',solMirrorPoint(1),solMirrorPoint(2),solMirrorPoint(3)));


% plot sphere
[X,Y,Z] = sphere(25);
mesh(r*X+SpherePos(1),r*Y+SpherePos(2),r*Z+SpherePos(3));hold on;

%plot z axis
%line([0;0],[0;0],[-30;30]); hold on;
plot3(COP(1),COP(2),COP(3),'r*','MarkerSize',10);hold on;
plot3(XYZ(1),XYZ(2),XYZ(3),'k*','MarkerSize',10);hold on;

axis equal


nn = size(solMirrorPoint,2);

for ii = 1:nn
    
    x = solMirrorPoint(1,ii);
    y = solMirrorPoint(2,ii);
    z = solMirrorPoint(3,ii);
    
    vi = COP - [x;y;z];
    vr = XYZ - [x;y;z];
    
    normalVec = solMirrorPoint - SpherePos;
    normalVec = normalVec/norm(normalVec);
    
    plot3(x,y,z,'g*','MarkerSize',5);hold on;
    
    t =[x;y;z] + 20*normalVec;
    
    line([COP(1);x],[COP(2);y],[COP(3);z],'LineWidth',2,'Color',[1;0.6;0.4;]);hold on;
    text(COP(1),COP(2)-2,COP(3),'COP','FontSize',16);hold on;
    line([XYZ(1);x],[XYZ(2);y],[XYZ(3);z],'LineWidth',2,'Color',[0.4;0.6;1]);hold on;
    text(XYZ(1)-2,XYZ(2)-2,XYZ(3)-2,'P','FontSize',16);hold on;
    
    line([t(1);x],[t(2);y],[t(3);z],'LineWidth',2,'Color',[0;0;0]);hold on;
    text(t(1)-5,t(2)-2,t(3)+4,'Normal','FontSize',16);hold on;
    
end

