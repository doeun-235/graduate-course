import numpy as np
import matplotlib.pyplot as plt 
import matplotlib as mpl 
import time

def angle (A,B,C) : #밑변 AB 로 주어졌을 때 CAB 각도 구하기
    r=0

    if P[A,0] != P[B,0] and P[C,0] != P[A,0]:
        b=(P[B,1]-P[A,1])/(P[B,0]-P[A,0])
        c=(P[C,1]-P[A,1])/(P[C,0]-P[A,0])
        
        if c*b != -1:
            ang=(c-b)/(1+c*b) #직각이 아닌 경우는 tan 차 공식 이용
        else :
            r=np.sign(b*(P[B,1]-P[A,1])*(P[C,1]-P[A,1]))

    elif P[A,0]==P[B,0] and P[C,0]==P[A,0]:
        ang = 0
    elif P[A,0]==P[B,0] and P[C,1]!=P[A,1]:
        ang = -(P[C,0]-P[A,0])/(P[C,1]-P[A,1])
    elif P[A,0]==P[B,0] and P[C,1]==P[A,1]:
        r=np.sign((P[B,1]-P[A,1])*(-P[C,0]+P[A,0]))
    elif P[C,0]==P[A,0] and P[B,1]!=P[A,1]:
        ang = (P[B,0]-P[A,0])/(P[B,1]-P[A,1])
    else :
        r=np.sign((P[C,1]-P[A,1])*(P[B,0]-P[A,0]))

    if r!=0:
        ang=r*1.799*1e308 #직각인 경우 float64범위에서 최대 혹은 최소를 줌

    return ang


def findH(a,b,s) : #선분 AB기준으로 높이가 제일 높은(혹은 낮은) P 구하기. s=1 이면 위 s=-1이면 아래 
#    print(a,b)
    Hmax=0
    pH=a
    for c in range(a+1,b) :
        ang=angle(a,b,c)
        if np.inner(P[b]-P[a],P[c]-P[a])*ang*s > Hmax :
            pH=c
            Hmax=ang*s
    if pH!=a:
        findH(a,pH,s)
    else :
        return
    
    findH(pH,b,s)

if __name__ == '__main__':
    
    trial=7
    N=np.array([1000,3000,5000,7000,9000])
    OptimeD=np.zeros((5,trial))

    for ind in range(len(N)) :
        
        print(N[ind])

        for t in range(trial) :
            
            n=N[ind]
            P=np.random.rand(n,2)*10-5

            P=P[np.argsort(P[:,0])] # P를 x 좌표 순서로 정렬

            #doing divide and conquer
            start=time.time()

            findH(0,n-1,1)
            findH(0,n-1,-1)

            OptimeD[ind,t]=time.time()-start
            print(t)


    #make average

    OptmeanD=np.mean(OptimeD,axis=1)

   
    # find best aproximation for each algorithms : a n + b ,

    vD=np.zeros((5,2))
    vD[:,1]=1
    vD[:,0]=N

    bD=np.inner(vD.T,OptmeanD)

    #making gram matrix
    gD=np.inner(vD.T,vD.T)

    coD=np.matmul(np.linalg.inv(gD),bD)

    #making graph

    fig=plt.figure()
    ax = fig.add_subplot(111)

    Domain=np.linspace(N[0],N[4],10)
    ax.plot(Domain,coD[0]*Domain+coD[1])
    ax.plot(N,OptimeD,marker='.',ls='')
    ax.plot(N,OptmeanD,marker='D',ls='') #다이아몬드 점으로 평균 시행시간 찍음
    ax.set_title("2-a) Solving by D&C")
    ax.set_xlabel('T=%fn+(%f)' %(coD[0],coD[1]))
  

    plt.show()



            



