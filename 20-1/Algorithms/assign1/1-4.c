#include <stdio.h>
#include <math.h>

double sR (double num, double ans, double tol) {
    
    if (fabs(pow(ans,2.0)-num)<tol) {
        return ans;
    } else {
        sR (num,(pow(ans,2.0)+num)/(2.0*ans),tol);
    }

    //x = a-f(a)/f'(a) =a-(a^2-n)/2a = (a^2+n)/2a 
    
}

int main (){


    double num, tol;

    double ANS;
    int err;

    printf("num = ? ");
    scanf("%lf",&num);
    printf("tol = 10^(-x). x = ? ");
    scanf("%d",&err); // 자릿수를 받는 것.

    if (num<0) {
        printf("You need to non-negative num\n");
        return 0;
    }


    tol=pow(0.1,(double)(err));

    ANS = sR (num,num/2.0,tol);

    printf ("Ans : %lf\n",ANS);

    return 0;
}

// math.h 를 썼기 때문에 gcc -o 1-4 1-4.c 뒤에 -lm 을 붙여야 함. 