#!/usr/bin/env python3

def compoundCapital (startCapital, months, annualReturn=0.05, monthlyInvest=0, yearlyInvest=0, yearlyDividendReinvest=0):
    ''' Extrapolates the monthly compounded capital. '''
    print('Month\t\tInvestment\tCapital\t\tROI')
    c, i, mr, mi, yi, ydr = startCapital, startCapital, (1 + annualReturn) ** (1./12), monthlyInvest, yearlyInvest, yearlyDividendReinvest
    for m in range(months):
        c *= mr
        if m % 12 == 0 and m > 0:
            c *= (1.+ ydr)
            d = yi + mi
        else:
            d = mi
        c, i = c + d, i + d
        if (i > 0): print(f'{m+1}\t\t${i}\t\t${round(c)}\t\t{round((c/i-1)*100,1)}%')