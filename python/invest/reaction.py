from time import time, sleep
from random import uniform, normalvariate

for t in [3,2,1]:
    print(f' start reaction test in {t}',end='\r')
    sleep(1)
print(' Wait for signal to hit enter ...',end='\r')
sleep(abs(normalvariate(uniform(4,6), 2)))
print(' Now!                            ',end='\r')
t=time()
input()
print(f' Reaction time: {time()-t}s\n',end='\r')