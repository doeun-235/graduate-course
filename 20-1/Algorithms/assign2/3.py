import numpy as np

def stmul(A,B) :
    # 에러 처리 부분은 생략하겠습니다. (e.g len(A)!=2^k)

    n=len(A)

    if 2<n :
        A11=A[0:n//2,0:n//2]
        A12=A[0:n//2,n//2:n]
        A21=A[n//2:n,0:n//2]
        A22=A[n//2:n,n//2:n]

        B11=B[0:n//2,0:n//2]
        B12=B[0:n//2,n//2:n]
        B21=B[n//2:n,0:n//2]
        B22=B[n//2:n,n//2:n]

        M1=stmul(A11+A22,B11+B22)
        M2=stmul(A21+A22,B11)
        M3=stmul(A11,B12-B22)
        M4=stmul(A22,B21-B11)
        M5=stmul(A11+A12,B22)
        M6=stmul(A21-A11,B11+B12)
        M7=stmul(A12-A22,B21+B22)

  
        C11=M1+M4-M5+M7
        C12=M3+M5
        C21=M2+M4
        C22=M1-M2+M3+M6

        C=np.zeros((n,n))

        C[0:n//2,0:n//2]=C11
        C[0:n//2,n//2:n]=C12
        C[n//2:n,0:n//2]=C21
        C[n//2:n,n//2:n]=C22
    
    else :
    
        A11=A[0,0]
        A12=A[0,1]
        A21=A[1,0]
        A22=A[1,1]

        B11=B[0,0]
        B12=B[0,1]
        B21=B[1,0]
        B22=B[1,1]

        M1=(A11+A22)*(B11+B22)
        M2=(A21+A22)*(B11)
        M3=(A11)*(B12-B22)
        M4=(A22)*(B21-B11)
        M5=(A11+A12)*(B22)
        M6=(A21-A11)*(B11+B12)
        M7=(A12-A22)*(B21+B22)

        C11=M1+M4-M5+M7
        C12=M3+M5
        C21=M2+M4
        C22=M1-M2+M3+M6

        C=np.zeros((n,n))

        C[0,0]=C11
        C[0,1]=C12
        C[1,0]=C21
        C[1,1]=C22

    return C


if __name__ == '__main__':
    A=np.array([[1,0,2,1],[4,1,1,0],[0,1,3,0],[5,0,2,1]])
    B=np.array([[0,1,0,1],[2,1,1,4],[2,0,1,1],[1,3,5,0]])

    C=stmul(A,B)
    print(C)

    D=np.matmul(A,B)
    print(D) #numpy 내장함수를 통해 행렬 A,B를 곱한 것이 strassen formula를 통해 구한 것과 동일함을 알 수 있다.
