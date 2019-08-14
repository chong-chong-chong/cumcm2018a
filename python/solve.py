import numpy as np
import matplotlib.pyplot as plt
class lineArea:
    alpha = 0.0
    dx = 0.0001
    dt = 0.00001
    start = 0.0
    end = 0.0
    time = 0.0
    ul = 37.0
    ur = 37.0
    x = np.array([])
    u = np.array([])
    def __init__(self, start,end,alpha):
        self.start = start
        self.end = end
        self.alpha = alpha
        self.x = np.arange(self.start+self.dx,self.end,self.dx)
        self.u = 37*np.ones(len(self.x))


    def setAlpha(self, alpha):
        self.alpha = alpha

    def setDt(self, dt):
        self.dt = dt

    def setDx(self, dx):
        self.dx = dx

    def region(self,start,end):
        self.start = start
        self.end = end
        self.x = np.arange(self.start+self.dx,self.end,self.dx)

    def autoSet(self):
        self.dt = self.alpha*50
        self.dx = self.alpha*5

    def timeIncrease(self):
        self.time += self.dt

a4 = lineArea(0,0.005,2.361075976051944e-05)
a4.setDt(0.000001)
a4.setDx(0.001)
a3 = lineArea(0.005,0.0086,3.441935316092042e-07)
a2 = lineArea(0.0086,0.0146,2.043973041652856e-07)
a1 = lineArea(0.0146,0.0152,1.984991527475188e-07)
a4.ul = 37
a1.ur = 75
lineSpace = [a4,a3,a2,a1]
timeSpace = np.arange(0,3600,0.1)
drawPoint = 600
for timePoint in timeSpace:
    if timePoint>drawPoint:
        allx = np.array([])
        allu = np.array([])
        for a in lineSpace:
            allx = np.append(allx,a.x)
            allu = np.append(allu,a.u)
        
        
        plt.plot(allx,allu)
        plt.show()
        drawPoint += 600

    for index_a in range(len(lineSpace)):
        a = lineSpace[index_a]

        if a.time<timePoint:
            L = len(a.u)
            du = np.zeros(L)
            for index in range(L):
                if index==0:
                    up = a.ul
                    un = a.u[index+1]
                    if index_a==0:
                        dx1 = lineSpace[0].dx
                    else:
                        dx1 = a.x[0]-lineSpace[index_a-1].x[-1]

                    dx2 = a.dx
                elif index==L-1:
                    up = a.u[index-1]
                    un = a.ur
                    if index_a==3:
                        dx1 = a.dx
                        dx2 = a.dx
                    else:
                        dx1 = a.dx
                        dx2 = -a.x[0]+lineSpace[index_a+1].x[0]
                else:
                    up = a.u[index-1]
                    un = a.u[index+1]
                    dx1 = a.dx
                    dx2 = a.dx

                uh = a.u[index]
                du[index] = a.alpha*((un-uh)/dx2-(uh-up)/dx1)/(0.5*dx1+0.5*dx2)
                #du[index] = a.alpha*((un+up-2*uh)/(a.dx*a.dx))
            a.u = du*a.dt + a.u
            a.timeIncrease()
        
        a4.ur = a3.u[0]
        a3.ul = a4.u[-1]
        a3.ur = a2.u[0]
        a2.ul = a3.u[-1]
        a2.ur = a1.u[0]
        a1.ul = a2.u[-1]


print(allx,allu)