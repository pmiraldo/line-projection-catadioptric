
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



Code for ECCV 2010 Paper 

Analytical Forward Projection for Axial Non-Central  Dioptric and Catadioptric Cameras, Amit Agrawal, Yuichi Taguchi and Srikumar Ramalingam, ECCV 2010

The Matlab code presented here is tested on Windows XP 32 bit and 64 bit with Matlab 7.9.0 (R2010b). 

For questions and bugs email agrawal at merl dot com

=========================================================
FPAxial.mat

Mat file contains the forward projection equation FP


================================================================

VisualizeSolutionAxial.m

Running this file will visualize the incoming, reflected and normal rays for a given COP and a 3D point P.
The normal to the mirror is drawn at computed mirror intersection point.


================================================================

TestForwardProjectionAxial.m

This code is to test the accuracy of Forward projection. 1000 pixels are randomly generated. The rays corresponding to these pixels are intersected and reflected from the mirror and a point on each ray is chosen. Then forward projection of the point is computed and check with the mirror intersection point. The error should be zero.


================================================================
ComputeForwardProjectionAxial.m

Main code to compute the forward projection given a 3D point, COP and mirror parameters


==========================================================
ComputeForwardProjectionAxialMex.m

The majority of time in above code is spent in computing the coeffecients. This can be speed up by mexing it. In your machine

>>mex MexComputeForwardProjectionAxial.c

This will generate the mex version. Then use ComputeForwardProjectionAxialMex.m instead of ComputeForwardProjectionAxial.m


=================================================
MexComputeForwardProjectionAxial.c

C code to compute the coeffecients only. This can be mexed.










