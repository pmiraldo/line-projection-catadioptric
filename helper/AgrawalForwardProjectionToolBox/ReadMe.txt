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



Matlab Forward Projection Toolbox for Non-Central Catadioptric Cameras

Written by Amit Agrawal, MERL

Email agrawal at merl dot com for bugs, suggestions

=======================================================

This toolbox allows to compute the projection of a 3D point for a calibrated non-central catadioptric camera. Computing the projection allows minimizing the re-projection error in several applications such as calibration and 3D reconstruction. By replacing the perspective projection for standard cameras with this forward projection, one can use their favorite bundle-adjustment algorithm on non-central catadioptric cameras.

This toolbox allows all conic mirrors with camera placed on axis as well as off-axis. For spherical mirror, the FP reduces to a 4th degree equation. For Axial systems, FP is 6th degree in general and for off-axis camera placement, it is 8th degree. Refer to following papers for more details.


Beyond Alhazen's Problem: Analytical Projection Model for Non-Central Catadioptric Cameras with Quadric Mirrors, Amit Agrawal, Yuichi Taguchi and Srikumar Ramalingam, CVPR 2011

Analytical Forward Projection for Axial Non-Central  Dioptric and Catadioptric Cameras, Amit Agrawal, Yuichi Taguchi and Srikumar Ramalingam, ECCV 2010


The above two papers must be referenced if you use this code.


It is important to choose the lowest degree of FP equation for best accuracy and speed. For example, a spherical mirror is a subset of axial catadioptric cameras, but its FP equation is 4th degree instead of 6th degree
.

The code consist of following 3 directories

Spherical Mirror.  Camera with spherical mirror. Note that any camera placement is axial.

Axial Catadioptric.  General axial cameras, camera placed on the axis of conic mirror

Off-Axis. General case with off-axis camera placement with conic mirrors





