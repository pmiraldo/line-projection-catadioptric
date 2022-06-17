
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


% Generate a random camera location, random 3D point. Find the mirror
% reflection point and display.

clear all;close all;clc;format compact;

disp('Visualization of Analytical Projection Model for Hyperbolic Mirror');

MIRROR_TYPE = 2  % 1 for hyperbolic, 2 for parabolic. Use your parameters for other mirrors

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
    %taking lower portion of mirror
    maxZ = min(s);
end
clear s


% generate COP and location of 3D point
disp('Center of Projection (COP)');
COP = [0 0 maxZ + 16.7419]';
COP'

disp('3D Point XYZ');
XYZ = [12.9385   19.6540   24.9738]';
XYZ'


% % for random location
% % location of camera
% COP = 10*randn(3,1);
% COP(3) = abs(COP(3)) + 20;

% % location of 3d point
% XYZ = 15*randn(3,1);
% XYZ(3) = abs(XYZ(3)) + 10;


disp('Finding the mirror intersection point using FP equation');

solMirrorPoint = ComputeForwardProjectionAxial(COP,XYZ,A,B,C,maxZ);

disp('Mirror intersection point = ');

solMirrorPoint'


if(isempty(solMirrorPoint))
    disp('no solution found')
    return;
end


disp('Displaying...');

xmax = max(abs(solMirrorPoint(1,:))) + 10;
ymax = max(abs(solMirrorPoint(2,:))) + 10;

PlotMirrorSurface(A,B,C,xmax,ymax);

%plot z axis
line([0;0],[0;0],[-10;20],'LineWidth',2,'Color',[0.8;0.1;0.1]); hold on;
text(-12,-1,22,'Mirror Axis','FontSize',18,'Color',[0.8;0.1;0.1]);hold on;
plot3(COP(1),COP(2),COP(3),'ko','MarkerSize',5);hold on;
plot3(XYZ(1),XYZ(2),XYZ(3),'ko','MarkerSize',5);hold on;

h = gca;
set(h,'box','off')
set(h,'PlotBoxAspectRatioMode','auto')

axis equal
axis off
axis tight


x = solMirrorPoint(1);
y = solMirrorPoint(2);
z = solMirrorPoint(3);

vi = COP - [x;y;z];
vr = XYZ - [x;y;z];
normalVec = [x;y;B/2 + A*z];
normalVec = normalVec/norm(normalVec);

plot3(x,y,z,'g*','MarkerSize',5);hold on;

t =[x;y;z] + 10*normalVec;

line([COP(1);x],[COP(2);y],[COP(3);z],'LineWidth',2,'Color',[1;0.6;0.4;]);hold on;
text(COP(1)+1,COP(2)+1,COP(3)+1,'COP','FontSize',18,'Color',[1;0.6;0.4;]);hold on;

line([XYZ(1);x],[XYZ(2);y],[XYZ(3);z],'LineWidth',2,'Color',[0.4;0.6;1]);hold on;
text(XYZ(1)+2,XYZ(2)+2,XYZ(3)+2,'P','FontSize',18,'Color',[0.4;0.6;1]);hold on;

line([t(1);x],[t(2);y],[t(3);z],'LineWidth',2,'Color',[0.1;0.8;0.1]);hold on;
text(t(1)+1,t(2)+1,t(3)+1,'n','FontSize',18,'Color',[0.1;0.8;0.1]);hold on;


disp('Done...');



