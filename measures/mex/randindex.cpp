
#include <math.h>
#include "mex.h"




void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

   #define RI_OUT plhs[0]
   #define SEGINFO_IN prhs[0]
   #define GTINFO_IN prhs[1]
  
   
	double *SEGINFO, *GTINFO, *RI,*N_COUNT;
	 
	double *tmpSEGINFO, *tmpGTINFO, *N_U, *N_V;

    int M_SEG, N_SEG;
	 int seg_max, gt_max;
    int i,n,j;
	 int u,v;
	 int flag;
	 double N, N_choose_2;

    
    if(nrhs < 1 || nrhs > 2) 
        mexErrMsgTxt("Wrong number of input arguments.");
    else if(nlhs > 1)
        mexErrMsgTxt("Too many output arguments.");

    
   
    M_SEG = mxGetM(SEGINFO_IN); 
    N_SEG = mxGetN(SEGINFO_IN);

    
    SEGINFO = mxGetPr(SEGINFO_IN);
    GTINFO = mxGetPr(GTINFO_IN);

	 RI_OUT = mxCreateDoubleMatrix(1,1,mxREAL);
	 RI = mxGetPr(RI_OUT);


	 flag = 0;
	 for(i=0;i<M_SEG;i++)
		 if(SEGINFO[i]==0)
		 {
			 flag = 1;break;
		 }
	 if(flag)
		 for(i=0;i<M_SEG;i++)
			 SEGINFO[i]++;

	 flag = 0;
	 for(i=0;i<M_SEG;i++)
		 if(GTINFO[i]==0)
		 {
			 flag = 1;break;
		 }
	 if(flag)
		 for(i=0;i<M_SEG;i++)
			 GTINFO[i]++;
	 

	 seg_max = 0;
	 gt_max = 0;
	 
	 for(i = 0;i<M_SEG;i++)
	 {
		 if(SEGINFO[i]>seg_max)
			 seg_max = SEGINFO[i];
		 if(GTINFO[i]>gt_max)
			 gt_max = GTINFO[i];
	 }

	 mxArray *N_COUNT_MX;
	 N_COUNT_MX = mxCreateDoubleMatrix(seg_max,gt_max, mxREAL); 
	 mxSetData(N_COUNT_MX, mxMalloc(sizeof(double)*seg_max*gt_max));
    N_COUNT = mxGetPr(N_COUNT_MX);

	 for(i=0;i<seg_max;i++)
		 for(j=0;j<gt_max;j++)
			 N_COUNT[i+seg_max*j] = 0;
	 
	 for(i=0;i<M_SEG;i++)
	 {
		 u = SEGINFO[i];
		 v = GTINFO[i];
		 N_COUNT[(u-1)+seg_max*(v-1)]++;
	 }	

	 N = 0;
	 for(i=0;i<seg_max;i++)
		 for(j=0;j<gt_max;j++)
			 N += N_COUNT[i+seg_max*j];

    mxArray *N_U_MX;
	 N_U_MX = mxCreateDoubleMatrix(seg_max, 1, mxREAL);
	 mxSetData(N_U_MX, mxMalloc(sizeof(double)*seg_max));
	 N_U = mxGetPr(N_U_MX);


	 mxArray *N_V_MX;
	 N_V_MX = mxCreateDoubleMatrix(1, gt_max, mxREAL);
	 mxSetData(N_V_MX, mxMalloc(sizeof(double)*gt_max));
	 N_V = mxGetPr(N_V_MX);

	 
	 for(i = 0;i<seg_max;i++)
	 {
		 N_U[i] = 0;
		 for(j=0;j<gt_max;j++)
			 N_U[i] += N_COUNT[i+seg_max*j];
	 }

	 for(i = 0;i<gt_max;i++)
	 {
		 N_V[i] = 0;
		 for(j=0;j<seg_max;j++)
			 N_V[i] += N_COUNT[j+seg_max*i];
	 }
	 
	 N_choose_2 = N*(N-1)/2;

	 
	 double nu2, nv2;
	 long nc2;
	 nu2 = 0;
	 for(i=0;i<seg_max;i++)
		 nu2 += N_U[i]*N_U[i];
	 
	 nv2 = 0;
	 for(i=0;i<gt_max;i++)
		 nv2 += N_V[i]*N_V[i];
	 
	 nc2 = 0;
	 for(i=0;i<seg_max;i++)
		 for(j=0;j<gt_max;j++)
			 nc2 += N_COUNT[i+seg_max*j]*N_COUNT[i+seg_max*j];
	 RI[0] = 1-(nu2/2+nv2/2-nc2)/N_choose_2;
	 // RI[0]= N_COUNT[0];

	 
    return;
}
