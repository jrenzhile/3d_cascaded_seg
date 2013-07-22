
#include <math.h>
#include "mex.h"




void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

   #define DISTANCE_OUT plhs[0]
   #define P1_IN prhs[0]
   #define P2_IN prhs[1]
   #define P3_IN prhs[2]
   #define P4_IN prhs[3]
   #define SMALL_NUM 0.00000001
   
	double *P1, *P2, *P3, *P4, *DISTANCE;
	double u[3], v[3], w[3];
    double a,b,c,d,e,D,sN, sD, tD, tN;
	
    int i,j,k;
    
    if(nrhs < 1 || nrhs > 4) 
        mexErrMsgTxt("Wrong number of input arguments.");
    else if(nlhs > 1)
        mexErrMsgTxt("Too many output arguments.");

    P1 = mxGetPr(P1_IN);
    P2 = mxGetPr(P2_IN);
    P3 = mxGetPr(P3_IN);
    P4 = mxGetPr(P4_IN);
    
    DISTANCE_OUT = mxCreateDoubleMatrix(1,1,mxREAL);
    DISTANCE = mxGetPr(DISTANCE_OUT);

    for(i=0;i<3;i++)
        u[i] = P1[i]-P2[i];
    for(i=0;i<3;i++)
        v[i] = P3[i]-P4[i];
    for(i=0;i<3;i++)
        w[i] = P2[i]-P4[i];
    
    a=b=c=d=e=0;
    for(i=0;i<3;i++)
        a += u[i]*u[i];
    for(i=0;i<3;i++)
        b += u[i]*v[i];
    for(i=0;i<3;i++)
        c += v[i]*v[i];
    for(i=0;i<3;i++)
        d += u[i]*w[i];
    for(i=0;i<3;i++)
        e += v[i]*w[i];
    
    D = a*c - b*b;
    sD = D;
    tD = D;
    
    if(D<SMALL_N UM)
    {
        sN = 0.0;
        sD = 1.0;
        tN = e;
        tD = c;
    }
    else
    {
        sN = b*e - c*d;
        tN = a*e - b*d;
        
    }
    
    
    
//	 mxArray *N_COUNT_MX;
//	 N_COUNT_MX = mxCreateDoubleMatrix(seg_max,gt_max, mxREAL); 
//	 mxSetData(N_COUNT_MX, mxMalloc(sizeof(double)*seg_max*gt_max));
//    N_COUNT = mxGetPr(N_COUNT_MX);

	

	 
    return;
}
