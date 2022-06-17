
/*
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
*/




#include "mex.h"
#include <math.h>


void mexFunction(int nlhs, mxArray *plhs[],
	int nrhs, const mxArray *prhs[])
	/*nlhs    number of expected mxArrays.
	plhs    pointer to an array of NULL pointers.
	nrhs    number of input mxArrays.
	prhs    pointer to an array of input mxArrays.    */
{

	double *EE, *MM;

	double d, u, v, A, B, C;
	double B2, B3, B4, B5;
	double C2, C3;
	double A2, A3, A4;
	double u2, v2;
	double d2;
	double s1, s2, s3, s4, s5, s6, s7;
	double Am12;

	EE = mxGetPr( prhs[0] )  ;

	d = EE[0];
	u = EE[1];
	v = EE[2];
	A = EE[3];
	B = EE[4];
	C = EE[5];

	u2 = u*u;
	v2 = v*v;

	A2 = A*A;
	A3 = A2*A;
	A4 = A3*A;

	C2 = C*C;
	C3 = C2*C;

	B2 = B*B;
	B3 = B2*B;
	B4 = B3*B;
	B5 = B4*B;

	d2 = d*d;


	Am12 = (A-1)*(A-1);


	if(A == 0)
	{
		plhs[0] = mxCreateDoubleMatrix(6 ,1  , mxREAL);
		MM  = mxGetPr( plhs[0]);

		s1 = 16*B3;
		s2 = -16*B2*(B2 - u2 + 5*C);
		s3 = 4*B*(20*B2*C - 2*B3*d - 8*C*u2 - 2*B3*v + B4 + 32*C2 - 6*B2*u2 + 8*B*C*d + 8*B*C*v - 8*B*d*u2 - 8*B2*d*v);
		s4 = 4*B5*d + 4*v*B5 - 20*B4*C + 16*v*B4*d + 9*B4*u2 + 8*B3*C*d + 8*v*B3*C + 16*B3*d*u2 - 128*B2*C2 + 96*v*B2*C*d + 56*B2*C*u2 + 16*B2*d2*u2 - 96*B*C2*d - 96*v*B*C2 + 64*B*C*d*u2 - 64*C3 + 16*C2*u2;
		s5 = B5*d2 + 2*B5*d*v + B5*v2 - 12*B4*C*d - 12*B4*C*v + 8*B4*d2*v + 6*B4*d*u2 + 8*B4*d*v2 + 32*B3*C2 - 8*B3*C*d2 - 64*B3*C*d*v - 24*B3*C*u2 - 8*B3*C*v2 + 8*B3*d2*u2 + 16*B3*d2*v2 + 32*B2*C2*d + 32*B2*C2*v - 32*B2*C*d2*v - 48*B2*C*d*u2 - 32*B2*C*d*v2 + 64*B*C3 + 16*B*C2*d2 - 32*B*C2*d*v - 32*B*C2*u2 + 16*B*C2*v2 - 32*B*C*d2*u2 + 64*C3*d + 64*C3*v - 32*C2*d*u2;
		s6 = - B4*C*d2 - 2*B4*C*d*v - B4*C*v2 + B4*d2*u2 + 8*B3*C2*d + 8*B3*C2*v - 8*B3*C*d2*v - 8*B3*C*d*u2 - 8*B3*C*d*v2 - 16*B2*C3 + 8*B2*C2*d2 + 48*B2*C2*d*v + 16*B2*C2*u2 + 8*B2*C2*v2 - 8*B2*C*d2*u2 - 16*B2*C*d2*v2 - 32*B*C3*d - 32*B*C3*v + 32*B*C2*d2*v + 32*B*C2*d*u2 + 32*B*C2*d*v2 - 16*C3*d2 - 32*C3*d*v - 16*C3*v2 + 16*C2*d2*u2;

		MM[0] = s1;
		MM[1] = s2;
		MM[2] = s3;
		MM[3] = s4;
		MM[4] = s5;
		MM[5] = s6;

	}
	else
	{
		plhs[0] = mxCreateDoubleMatrix(7 ,1  , mxREAL);
		MM  = mxGetPr( plhs[0]);

		s1 = 16*A*Am12*(A2*d2 + 2*A2*d*v + A2*v2 + 2*A*B*d + 2*A*B*v + A*u2 + B2);
		s2 = 16*(A - 1)*(3*A3*B*d2 + 6*A3*B*d*v + 3*A3*B*v2 + 4*A3*d2*v + 2*A3*d*u2 + 4*A3*d*v2 - 4*C*A3*d - 4*C*A3*v + 5*A2*B2*d + 5*A2*B2*v - A2*B*d2 + 2*A2*B*d*v + 4*A2*B*u2 - A2*B*v2 - 4*C*A2*B + 2*A2*d*u2 + 4*C*A2*d + 4*C*A2*v + 2*A*B3 - 2*A*B2*d - 2*A*B2*v - 2*A*B*u2 + 4*C*A*B - B3);
		s3 = -4*(4*A4*C*d2 + 8*A4*C*d*v + 4*A4*C*v2 - 4*A4*d2*u2 - 14*A3*B2*d2 - 28*A3*B2*d*v - 14*A3*B2*v2 + 48*A3*B*C*d + 48*A3*B*C*v - 40*A3*B*d2*v - 24*A3*B*d*u2 - 40*A3*B*d*v2 - 16*A3*C2 + 32*A3*C*d*v + 16*A3*C*u2 - 8*A3*d2*u2 - 16*A3*d2*v2 - 18*A2*B3*d - 18*A2*B3*v + 36*A2*B2*C + 10*A2*B2*d2 - 12*A2*B2*d*v - 22*A2*B2*u2 + 10*A2*B2*v2 - 64*A2*B*C*d - 64*A2*B*C*v + 24*A2*B*d2*v - 8*A2*B*d*u2 + 24*A2*B*d*v2 + 32*A2*C2 - 4*A2*C*d2 - 40*A2*C*d*v - 24*A2*C*u2 - 4*A2*C*v2 - 4*A2*d2*u2 - 5*A*B4 + 14*A*B3*d + 14*A*B3*v - 56*A*B2*C + 24*A*B2*d*v + 22*A*B2*u2 + 16*A*B*C*d + 16*A*B*C*v + 16*A*B*d*u2 - 16*A*C2 + 8*A*C*u2 + 4*B4 + 20*B2*C - 4*B2*u2);
		s4 = -4*(8*A3*B*C*d2 + 16*A3*B*C*d*v + 8*A3*B*C*v2 - 8*A3*B*d2*u2 - 16*A3*C2*d - 16*A3*C2*v + 16*A3*C*d2*v + 16*A3*C*d*u2 + 16*A3*C*d*v2 - 8*A2*B3*d2 - 16*A2*B3*d*v - 8*A2*B3*v2 + 48*A2*B2*C*d + 48*A2*B2*C*v - 36*A2*B2*d2*v - 24*A2*B2*d*u2 - 36*A2*B2*d*v2 - 48*A2*B*C2 + 8*A2*B*C*d2 + 96*A2*B*C*d*v + 40*A2*B*C*u2 + 8*A2*B*C*v2 - 16*A2*B*d2*u2 - 32*A2*B*d2*v2 + 16*A2*C2*d + 16*A2*C2*v + 16*A2*C*d*u2 - 7*A*B4*d - 7*A*B4*v + 24*A*B3*C + 2*A*B3*d2 - 16*A*B3*d*v - 12*A*B3*u2 + 2*A*B3*v2 - 28*A*B2*C*d - 28*A*B2*C*v + 8*A*B2*d2*v - 12*A*B2*d*u2 + 8*A*B2*d*v2 + 80*A*B*C2 - 8*A*B*C*d2 - 80*A*B*C*d*v - 40*A*B*C*u2 - 8*A*B*C*v2 - 8*A*B*d2*u2 - 16*A*C*d*u2 - B5 + 2*B4*d + 2*B4*v - 20*B3*C + 8*B3*d*v + 6*B3*u2 - 8*B2*C*d - 8*B2*C*v + 8*B2*d*u2 - 32*B*C2 + 8*B*C*u2);
		s5 = - 24*A2*B2*C*d2 - 48*A2*B2*C*d*v - 24*A2*B2*C*v2 + 24*A2*B2*d2*u2 + 96*A2*B*C2*d + 96*A2*B*C2*v - 96*A2*B*C*d2*v - 96*A2*B*C*d*u2 - 96*A2*B*C*d*v2 - 64*A2*C3 + 32*A2*C2*d2 + 192*A2*C2*d*v + 64*A2*C2*u2 + 32*A2*C2*v2 - 32*A2*C*d2*u2 - 64*A2*C*d2*v2 + 9*A*B4*d2 + 18*A*B4*d*v + 9*A*B4*v2 - 80*A*B3*C*d - 80*A*B3*C*v + 56*A*B3*d2*v + 40*A*B3*d*u2 + 56*A*B3*d*v2 + 144*A*B2*C2 - 32*A*B2*C*d2 - 288*A*B2*C*d*v - 112*A*B2*C*u2 - 32*A*B2*C*v2 + 40*A*B2*d2*u2 + 80*A*B2*d2*v2 + 32*A*B*C2*d + 32*A*B*C2*v - 64*A*B*C*d2*v - 128*A*B*C*d*u2 - 64*A*B*C*d*v2 + 128*A*C3 - 16*A*C2*d2 - 160*A*C2*d*v - 64*A*C2*u2 - 16*A*C2*v2 - 32*A*C*d2*u2 + 4*B5*d + 4*B5*v - 20*B4*C + 16*B4*d*v + 9*B4*u2 + 8*B3*C*d + 8*B3*C*v + 16*B3*d*u2 - 128*B2*C2 + 96*B2*C*d*v + 56*B2*C*u2 + 16*B2*d2*u2 - 96*B*C2*d - 96*B*C2*v + 64*B*C*d*u2 - 64*C3 + 16*C2*u2;
		s6 = 64*B*C3 + 64*C3*d + 64*C3*v + 32*B3*C2 + B5*d2 + B5*v2 + 16*B*C2*d2 + 32*B2*C2*d - 8*B3*C*d2 - 32*B*C2*u2 - 24*B3*C*u2 + 16*B*C2*v2 + 32*B2*C2*v - 8*B3*C*v2 + 6*B4*d*u2 - 32*C2*d*u2 + 8*B4*d*v2 + 8*B4*d2*v - 64*A*B*C3 + 8*B3*d2*u2 + 16*B3*d2*v2 - 64*A*C3*d - 12*B4*C*d - 64*A*C3*v - 12*B4*C*v + 2*B5*d*v - 32*B*C2*d*v - 64*B3*C*d*v + 32*A*B*C2*d2 + 48*A*B2*C2*d - 8*A*B3*C*d2 + 64*A*B*C2*u2 + 32*A*B*C2*v2 + 48*A*B2*C2*v - 8*A*B3*C*v2 + 64*A*C2*d*u2 + 64*A*C2*d*v2 + 64*A*C2*d2*v - 32*B*C*d2*u2 - 48*B2*C*d*u2 - 32*B2*C*d*v2 - 32*B2*C*d2*v + 8*A*B3*d2*u2 + 192*A*B*C2*d*v - 16*A*B3*C*d*v - 32*A*B*C*d2*u2 - 48*A*B2*C*d*u2 - 64*A*B*C*d2*v2 - 48*A*B2*C*d*v2 - 48*A*B2*C*d2*v;
		s7 = - B4*C*d2 - 2*B4*C*d*v - B4*C*v2 + B4*d2*u2 + 8*B3*C2*d + 8*B3*C2*v - 8*B3*C*d2*v - 8*B3*C*d*u2 - 8*B3*C*d*v2 - 16*B2*C3 + 8*B2*C2*d2 + 48*B2*C2*d*v + 16*B2*C2*u2 + 8*B2*C2*v2 - 8*B2*C*d2*u2 - 16*B2*C*d2*v2 - 32*B*C3*d - 32*B*C3*v + 32*B*C2*d2*v + 32*B*C2*d*u2 + 32*B*C2*d*v2 - 16*C3*d2 - 32*C3*d*v - 16*C3*v2 + 16*C2*d2*u2;

		MM[0] = s1;
		MM[1] = s2;
		MM[2] = s3;
		MM[3] = s4;
		MM[4] = s5;
		MM[5] = s6;
		MM[6] = s7;


	}













}


