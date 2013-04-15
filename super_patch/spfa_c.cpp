/*function minDist = spfa_c(neighbors, dist, v)
function minDist = spfa_c(neighbors, dist, v)
Given neighbors and distance matrix, 
perform Shortest Path Faster Algorithm(SPFA) algorithm in finding the
shortest path from v to every other faces.

Zhile Ren<jrenzhile@gmail.com>
Apr, 2013
*/

#include <mex.h>
#include <queue>
#include <list>
using namespace std;
typedef queue<int> INTQUEUE;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
   #define NEIGHBOR_IN prhs[0]
   #define DIST_IN prhs[1]
   #define V_IN prhs[2]
   #define MINDIST_OUT plhs[0]
	#define MAX 99999
	
   int M_NEIGHBOR, N_NEIGHBOR;
   double *DIST, *NEIGHBOR, *MINDIST, *V;
	int v,u,w;
	INTQUEUE q;
	
   int i,n,ii,jj,j,tmp;

   if(nrhs != 3) 
       mexErrMsgTxt("Wrong number of input arguments.");
     
   M_NEIGHBOR = mxGetM(NEIGHBOR_IN); 
   N_NEIGHBOR = mxGetN(NEIGHBOR_IN);
	int *in_queue = new int[N_NEIGHBOR];
   for(i=0;i<N_NEIGHBOR;i++)
		in_queue[i]=0;

	
   MINDIST_OUT = mxCreateDoubleMatrix(N_NEIGHBOR, 1, mxREAL);
   MINDIST = mxGetPr(MINDIST_OUT);
	NEIGHBOR = mxGetPr(NEIGHBOR_IN);
   DIST = mxGetPr(DIST_IN);
	
	V = mxGetPr(V_IN);
	v = (int)V[0];
	q.push(v);
	in_queue[v-1]=1;
	
	for(i=0;i<N_NEIGHBOR;i++)
		MINDIST[i]=MAX;
	MINDIST[v-1] = 0;

	while(!q.empty())
	{
		u = q.front();
		q.pop();
		in_queue[u-1]=0;
		for(i=0;i<3;i++)
		{
			w = (int)NEIGHBOR[i+M_NEIGHBOR*(u-1)];
			if(MINDIST[w-1]>MINDIST[u-1]+DIST[i+M_NEIGHBOR*(u-1)])
			{
				MINDIST[w-1] = MINDIST[u-1]+DIST[i+M_NEIGHBOR*(u-1)];
				if(in_queue[w-1]==0)
				{
					q.push(w);
					in_queue[w-1]=1;
				}
			}
		}
	}
   return;
}
