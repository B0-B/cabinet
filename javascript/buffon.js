// buffon monte-carlo-simulation to estimate pi | github.com/B0-B
B=U=F=1;O=Math.random;while(1){(O()**2+O()**2)**.5<1&&B++||U++;F++;F%5e6||console.log(4/(1+U/B))}