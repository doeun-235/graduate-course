#include <stdio.h>
#include <math.h>

int Combi (int n, int k) {

    int i, c;

    if (2*k > n) {
        i = n-k;
    } else {
        i = k;
    }

    if (i==0) {
        return 1;
    } else {
        c = Combi(n-1,k-1) + Combi(n-1,k);
        return c;
    }


}

int main (){

    int n, k;
    int ANS;

    printf("n = ? ");
    scanf("%d",&n);
    printf("k = ? ");
    scanf("%d",&k); // 자릿수를 받는 것.

    if ((n<=0) || k<0) {
        printf("You need to input positive n or non-negative k\n");
        return 0;
    }

    ANS = Combi (n,k);

    printf ("Ans : %d\n",ANS);

    return 0;
}