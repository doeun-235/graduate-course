#include <stdio.h>

//http://www.euroinformatica.ro/documentation/programming/!!!Algorithms_CORMEN!!!/DDU0091.html

int N=7;
float p[8]={-1.0,0.04,0.06,0.08,0.02,0.10,0.12,0.14};
float q[8]={0.06,0.06,0.06,0.05,0.05,0.05,0.05,0.05};

float e[8][8];
float w[8][8];
int root[8][8];

int main(){

    int i,l,j,r;
    float t;

    for (i=1;i<=N+1;i++){
        e[i][i-1]=q[i-1];
        w[i][i-1]=q[i-1];
    }

    for (l=1;l<=N;l++){
        for (i=1;i<=N-l+1;i++){
            j=i+l-1;
            e[i][j]=999;
            w[i][j]=w[i][j-1]+p[j]+q[j];
            for (r=i;r<=j;r++){
                t=e[i][r-1]+e[r+1][j]+w[i][j];
                if (t<e[i][j]){
                    e[i][j]=t;
                    root[i][j]=r;
                }
            }
        }
    }

    printf("main table\n");

    for (i=1;i<=N+1;i++){
        for (j=0;j<=N;j++){
            printf("%f ",e[i][j]);
        }
        printf("\n");
    }

    printf("root table\n");

    for (i=1;i<=N;i++){
        for (j=1;j<=N;j++){
            printf("%d ",root[i][j]);
        }
        printf("\n");
    }


    return 0;
}