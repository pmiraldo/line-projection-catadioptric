
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


function [] = PlotMirrorSurface(A,B,C,xmax,ymax)

xmax = abs(xmax);
ymax = abs(ymax);


Numpoints = 3*round(xmax);
if(mod(Numpoints,2)==1)
    Numpoints = Numpoints + 1;
end


[xx,yy] = meshgrid(-xmax:2*xmax/Numpoints:xmax,-ymax:2*ymax/Numpoints:ymax);
[H,W] = size(xx);

figure;
set(gcf,'Color',[1 1 1]);

MirrorPoints = NaN*ones(H,W);
MirrorPoints1 = NaN*ones(H,W);

count = 0;


for ii = 1:H
    for jj = 1:W
        
        xp = xx(ii,jj);
        yp = yy(ii,jj);
        
        if(A==0)
            z = (C - xp^2 - yp^2)/B;
            
            MirrorPoints(ii,jj) = z;
            
            count = count + 1;
            xxused(count,1) = xp;
            yyused(count,1) = xp;
            
            
        else
            
            aa = A;
            bb = B;
            cc = xp^2 + yp^2 - C;
            
            if(bb^2 >= 4*aa*cc)
                
                %                 z = (-bb - sqrt(bb^2 - 4*aa*cc))/(2*aa);
                %                 MirrorPoints(ii,jj) = z;
                %
                %                 z = (-bb + sqrt(bb^2 - 4*aa*cc))/(2*aa);
                %                 MirrorPoints1(ii,jj) = z;
                %
                
                z = (-bb + sqrt(bb^2 - 4*aa*cc))/(2*aa);
                
                %                 if(aa > 0)
                %                     z = (-bb + sqrt(bb^2 - 4*aa*cc))/(2*aa);
                %                 else
                %                     z = (-bb + sqrt(bb^2 - 4*aa*cc))/(2*aa);
                %                 end
                MirrorPoints(ii,jj) = z;
                
                count = count + 1;
                xxused(count,1) = xp;
                yyused(count,1) = xp;
                
                
                
            end
            
        end
        
    end
end


surf(xx,yy,MirrorPoints);hold on;

axis([min(xxused) max(xxused) min(yyused) max(yyused) -20 20]);

