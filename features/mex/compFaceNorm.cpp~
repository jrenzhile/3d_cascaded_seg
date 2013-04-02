#include <math.h>

#include "mex.h"
#define IS_REAL_2D_FULL_DOUBLE(P) (!mxIsComplex(P) && mxGetNumberOfDimensions(P) == 2 && !mxIsSparse(P) && mxIsDouble(P))
#define IS_REAL_SCALAR(P) (IS_REAL_2D_FULL_DOUBLE(P) && mxGetNumberOfElements(P) == 1)


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

   #define FACENORM_OUT plhs[0]
   #define VERTEX_IN prhs[0]
   #define FACE_IN prhs[1]
  
   
    double *FACE, *VERTEX, *FACENORM;
    int M_FACE, N_FACE, M_VERTEX, N_VERTEX;
    double v1[3], v2[3];
    int face_ind[3];
    int i,n;
    double tmp;
    
    if(nrhs < 1 || nrhs > 2) 
        mexErrMsgTxt("Wrong number of input arguments.");
    else if(nlhs > 1)
        mexErrMsgTxt("Too many output arguments.");
    if(!IS_REAL_2D_FULL_DOUBLE(FACE_IN)) 
        mexErrMsgTxt("FACE must be a real 2D full double array.");
    if(!IS_REAL_2D_FULL_DOUBLE(VERTEX_IN)) 
        mexErrMsgTxt("VERTEX must be a real 2D full double array.");
    
   
    M_FACE = mxGetM(FACE_IN); 
    N_FACE = mxGetN(FACE_IN);
    M_VERTEX = mxGetM(VERTEX_IN); 
    N_VERTEX = mxGetN(VERTEX_IN);
    
    FACE = mxGetPr(FACE_IN);
    VERTEX = mxGetPr(VERTEX_IN);
    FACENORM_OUT = mxCreateDoubleMatrix(M_FACE, N_FACE, mxREAL); 
    FACENORM = mxGetPr(FACENORM_OUT); 
    
    
    for(n = 0; n < N_FACE; n++) 
    {
        for(i = 0; i<3; i++)
	{
            face_ind[i] = FACE[i+M_FACE*n] -1;
	}
        for(i=0;i<3;i++)
        {
            v1[i] = VERTEX[i+M_VERTEX*face_ind[1]]-VERTEX[i+M_VERTEX*face_ind[0]];
            v2[i] = VERTEX[i+M_VERTEX*face_ind[2]]-VERTEX[i+M_VERTEX*face_ind[0]];
        }
        
        FACENORM[0+M_VERTEX*n] = v1[1]*v2[2]-v1[2]*v2[1];
        FACENORM[1+M_VERTEX*n] = v1[2]*v2[0]-v1[0]*v2[2];
        FACENORM[2+M_VERTEX*n] = v1[0]*v2[1]-v1[1]*v2[0]; 
    }
    
    return;
}
