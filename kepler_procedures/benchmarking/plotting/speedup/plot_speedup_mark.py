#!/usr/bin/python
# -*- coding: utf-8 -*-
# File: plot_speedup.py
# Created: 2014-04-24 by gks 
"""
Description: Plot speedup
"""
import numpy as np
from pylab import *
from scipy import *
import matplotlib.pyplot as plt
import scipy.constants as const
from scipy import optimize
#import matplotlib.pyplot as plt
#from mpl_toolkits.mplot3d import Axes3D
#from matplotlib import cm

#---------------------FONT and other graphics------------------------
font = {'family'         : 'serif',
	'weight'         : 'bold',
	'size'	         : 16}
matplotlib.rc('font',**font)
matplotlib.rc('grid',linewidth=1)
matplotlib.rc('xtick.major',width=2)
matplotlib.rc('xtick.major',size=7)
matplotlib.rc('xtick.minor',width=2)
matplotlib.rc('xtick.minor',size=4)
matplotlib.rc('ytick.major',width=2)
matplotlib.rc('ytick.major',size=7)
matplotlib.rc('ytick.minor',width=2)
matplotlib.rc('ytick.minor',size=4)

#-------------------------------------------------

#plotall

#---------------------DATA------------------------
name='mark_par_times.txt'
data = loadtxt(name,comments="#",usecols=(0,1))

procs= data[:,0]
time = data[:,1]

time_ser = 689.328393643

speedup = time_ser / time

#-------------------------------------------------

#------------Figure Layout--------------
#twofig
##One Figure
fig = plt.figure()
ax = fig.add_subplot(111)
adjustprops = dict(left=0.19,bottom=0.15,right=0.92,top=0.9,wspace=0.,hspace=0.2)
fig.subplots_adjust(**adjustprops)    

ax.set_xlabel(r'Procs',size="x-large")
ax.set_ylabel(r'Speedup = $T_{Serial}/T_{Parallel}$',size="x-large")

ax.set_xlim(0,10)
ax.set_ylim(0,7)

ax.minorticks_on()
ax.grid()

serial_times = ones(100)
x = linspace(0,10,100)

#PLOT
#ax.plot(procs,speedup,color="black",marker="o", markersize=10,linewidth=1,linestyle="-",label="Speedup")
#ax.plot(procs,serial_times,color="red",marker="o", markersize=10,linewidth=1,linestyle="-",label="Serial")
ax.plot(procs,speedup,color="black",linewidth=4,linestyle="-",label="Speedup")
ax.plot(x,serial_times,color="red",linewidth=4,linestyle="-",label="Serial")

#fig21
#fig12
#fig13
#---------------------------------------


#FITTING------------------------------------------
#polyfit
#optimize

#-------------------------GRAPHICS
legend(loc='upper left')
#legend
#changeticks
#tickRotate
#intTick

#MISC
#plt.ticklabel_format(style="sci",scilimits=(1,2),axis="y")

#ANNOTATE
#ax.annotate(r'$M_r$', xy=(0, 2),  xycoords='data',
#                xytext=(-50, 30), textcoords='data',
#                arrowprops=dict(arrowstyle="->"))
#bx.annotate(r'$\chi^2=0.46$', xy=(750, 0.03),xytext=None, textcoords='data',arrowprops=None)




#SAVING
fig.show()
fig.savefig("speedup_mark.png")


