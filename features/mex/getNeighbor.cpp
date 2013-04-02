/*
neighbors = getNeighbor(face);

Given the face of the model, return the neighboring pairs.
Each row j in coloum i represent a neighboring face pair (i,j)

Zhile Ren <jrenzhile@gmail.com>
Mar, 2013
*/

#include <math.h>

#include "mex.h"

// Perform sorting of an array
void IntSort(double A[],int n) 
{
	int i,j;
	double x;
  for(i=1;i<n;i++)
	{
		x = A[i];
		for(j= i-1;j>=0;j--)
		{
			if(x<A[j])
				A[j+1] = A[j];
			else
				break;
		}
		A[j+1] = x;
	} 
} 



void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

  #define NEIGHBOR_OUT plhs[0]
  #define FACE_IN prhs[0]
	int M_FACE, N_FACE;
  double tmp_i[3], tmp_j[3];
  double *FACE, *NEIGHBOR;

  int i,n,ii,jj,j,tmp;
	int count_inters,count;
//  mxArray *NEIGHBOR_OUT_TMP;
    
  if(nrhs != 1) 
      mexErrMsgTxt("Wrong number of input arguments.");

  
   
  M_FACE = mxGetM(FACE_IN); 
  N_FACE = mxGetN(FACE_IN);
    
  FACE = mxGetPr(FACE_IN);
	
//  NEIGHBOR_OUT_TMP = mxDuplicateArray(FACE_IN); /* Create B as a copy of A */

//  NEIGHBOR_OUT_TMP = mxCreateNumericMatrix(0, 0, mxINT32_CLASS, mxREAL);
	// mxSetDimensions(NEIGHBOR_OUT_TMP, mxGetDimensions(FACE_IN), mxGetNumberOfDimensions(FACE_IN));
	// mxSetData(NEIGHBOR_OUT_TMP, mxMalloc(4*mxGetNumberOfElements(FACE_IN)));
  NEIGHBOR_OUT = mxCreateDoubleMatrix(M_FACE, N_FACE, mxREAL);
	//NEIGHBOR_OUT = NEIGHBOR_OUT_TMP;
  NEIGHBOR = mxGetPr(NEIGHBOR_OUT);   

	
	for(i = 0;i<N_FACE;i++)
	{
		count = 0;
		for(ii = 0;ii<3;ii++)
			tmp_i[ii] = FACE[ii+i*M_FACE];
    IntSort(tmp_i, 3);
		
		for(j = 0;j<N_FACE;j++)
		{

			if(j==i)
				continue;
			count_inters = 0;
			for(ii = 0;ii<3;ii++)
				tmp_j[ii] = FACE[ii+j*M_FACE];
			IntSort(tmp_j,3);

			ii = 0;jj= 0;
			while((ii<3)&&(jj<3))
			{
				if(tmp_i[ii]==tmp_j[jj])
				{
					count_inters++;
					ii++;jj++;
				}
				else if(tmp_i[ii]>tmp_j[jj])
					jj++;
				else
					ii++;
			}
 
			if(count_inters ==2)
			{
				NEIGHBOR[count+i*M_FACE]=j+1;
				
				count++;
				if(count>=3)
					break;
			}
		
		}
	}
	
  return;
}
