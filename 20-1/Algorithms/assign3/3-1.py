import numpy as np
import matplotlib.pyplot as plt 
import matplotlib as mpl 
import time


def findans(a,b) :
    D= (P[:,0]<=b) & (P[:,0] >=a)
    cnt=np.sum(D) # x좌표가 [a,b]에 잇는 것들의 개수
    if cnt <= 1:
        return (b-a) #작게 자른 부분에 1개 이하일 경우 그냥 strip 볼 때 반경을 넓혀주면 한번에 볼 수 있기 때문

    dl=findans(a,(a+b)/2)
    dr=findans((a+b)/2,b)

    ds=min(dl,dr)

    mind=ds
    if ds==b-a:
        Ds= (P[:,0]<=(a+b)/2+ds/2) & (P[:,0]>=(a+b)/2-ds/2) #x좌표가 중간 기준선 기준 +-d 만큼 있는 애들만의 indexds/=2
        #strip 확인
    else :
        Ds= (P[:,0]<=(a+b)/2+ds) & (P[:,0]>=(a+b)/2-ds) #x좌표가 중간 기준선 기준 +-d 만큼 있는 애들만의 index
    Ta=P[Ds]

    for po in range(len(Ta)) :
        Dsy= (Ds) & (P[:,1]<=P[po,1]+d) & (P[:,1]>=P[po,1]-d)  #개중에 한 점을 잡고 그 기준점 기준 y좌표가 +-d 이내에 있는 애들 만의 index
        Dsy[po]=False
        if np.sum(Dsy)>=1:
            k=np.min(np.power(P[Dsy,0]-P[po,0],2)+np.power(P[Dsy,1]-P[po,1],2))
            mind=np.min([k,mind])
            
    return mind  



if __name__ == '__main__':

    global minpair


    #각 n별로 trial 번 만큼의 시도를 할 것이고 그들간 평균 값으로 그래프를 그릴 것임.
    trial=2
    N=np.array([1000,3000,5000,7000,9000])
    lenN=len(N)
    OptimeB=np.zeros((lenN,trial))
    OptimeD=np.zeros((lenN,trial))
    minpair=np.zeros(2)

    for ind in range(lenN) :
        
        print(N[ind])

        for t in range(trial) :
            
            n=N[ind]
            P=np.random.rand(n,2)*10-5


            #doing brute force
            start=time.time()

            minlen=1000
            for i in range(n) :
                for j in range(i+1,n) :
                    s=np.power(P[i][0]-P[j][0],2)+np.power(P[i][1]-P[j][1],2)
                    if s < minlen :
                        minlen = s
                        minpair=[i,j]


            OptimeB[ind,t]=time.time()-start

            #doing divide and conquer
            start=time.time()
            
            minpair=[0,0]
            d=20
            d=findans(-5,5)

            OptimeD[ind,t]=time.time()-start
            

    #make average

    OptmeanB=np.mean(OptimeB,axis=1)
    OptmeanD=np.mean(OptimeD,axis=1)
    
    # find best aproximation for each algorithms : a n^2+ b n +c , (a n+ b) log n + c

    vB=np.zeros((lenN,3))
    vB[:,2]=1
    vB[:,1]=N
    vB[:,0]=N*vB[:,1]

    vD=np.zeros((lenN,3))
    vD[:,2]=1
    vD[:,1]=np.log(N)
    vD[:,0]=vD[:,1]*N

    bB=np.inner(vB.T,OptmeanB)
    bD=np.inner(vD.T,OptmeanD)

    #making gram matrix
    gB=np.inner(vB.T,vB.T)
    gD=np.inner(vD.T,vD.T)

    coB=np.matmul(np.linalg.inv(gB),bB)
    coD=np.matmul(np.linalg.inv(gD),bD)

    #making graph

    fig=plt.figure()
    ax = fig.add_subplot(121)
    bx = fig.add_subplot(122)

    Domain=np.linspace(N[0],N[lenN-1],10)
    ax.plot(Domain,(coD[0]*Domain+coD[1])*np.log(Domain)+coD[2])
    ax.plot(N,OptimeD,marker='.',ls='')
    ax.plot(N,OptmeanD,marker='D',ls='') #다이아몬드 점으로 평균 시행시간 찍음
    ax.set_title("1-a) Solving by D&C")
    ax.set_xlabel("T=%fn log n+(%f)log n+(%f)" %(coD[0],coD[1],coD[2]))
    bx.plot(Domain,coB[0]*Domain**2+coB[1]*Domain+coB[2])
    bx.plot(N,OptimeB,marker='.',ls='')
    bx.plot(N,OptmeanB,marker='D',ls='') #다이아몬드 점으로 평균 시행시간 찍음
    bx.set_title("1-b) Solving by BF")
    bx.set_xlabel("T=%fn^2+(%f)n+(%f)" %(coB[0],coB[1],coB[2]))
    

    plt.show()



            



