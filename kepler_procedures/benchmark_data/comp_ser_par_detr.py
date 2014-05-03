#!/usr/bin/python
# -*- coding: utf-8 -*-
# File: detrend_vs_untrend.py
# Created: 2014-04-24 by gks 
"""
Description: Detrend vs untrended data
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
	'size'	         : 15}
matplotlib.rc('font',**font)
matplotlib.rc('grid',linewidth=1)
matplotlib.rc('xtick.major',width=3)
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
name='952_serial.csv'
data = loadtxt(name,comments="#",delimiter=",",usecols=(0,1,2,3))

time= data[:,0]
de_ser= data[:,1]
un_ser= data[:,2]

name='952_9procs.csv'
data = loadtxt(name,comments="#",delimiter=",",usecols=(0,1,2,3))

de_par= data[:,1]
#-------------------------------------------------

#------------Figure Layout--------------
#twofig
##One Figure
fig = plt.figure()
figprops = dict(figsize=(12.,12./2.118), dpi=256)
fig = plt.figure(**figprops)
ax = fig.add_subplot(111)
adjustprops = dict(left=0.19,bottom=0.15,right=0.92,top=0.9,wspace=0.,hspace=0.2)
fig.subplots_adjust(**adjustprops)    


ax.set_xlabel(r'Time (Days)',size="x-large")
ax.set_ylabel(r'Normalized Flux',size="x-large")

ax.minorticks_on()
ax.grid()

#PLOT


#ax.set_xlim(220,275)
#ax.set_ylim(0.985,1.015)

#
#figprops = dict(figsize=(8.,8./2.118), dpi=256)
adjustprops = dict(left=0.13,bottom=0.12,right=0.97,top=0.83,wspace=0.,hspace=0.2)

#fig = plt.figure(**figprops)
fig = plt.figure()
fig.subplots_adjust(**adjustprops)

bx = fig.add_subplot(2,1,2)
ax = fig.add_subplot(2,1,1,sharex=bx)

#ax.set_xlabel(r'$x$',size="x-large")
ax.set_ylabel(r'Norm Flux',size="x-large")
bx.set_xlabel(r'Time (Days)',size="x-large")
bx.set_ylabel(r'Norm Flux',size="x-large")

ax.set_xlim(0,1050)
ax.set_ylim(0.985,1.015)

bx.set_xlim(0,1050)
bx.set_ylim(0.985,1.015)

ax.grid()
bx.grid()
ax.minorticks_on()
bx.minorticks_on()

plt.setp(ax.get_xticklabels(),visible=False)

#PLOT
ax.plot(time,de_ser,color="red",marker=".",markersize=5,linewidth=0,linestyle="-",label="Serial Detrended")
bx.plot(time,de_par,color="blue",marker=".",markersize=5,linewidth=0,linestyle="-",label="Parallel Detrended")



#-------------------------GRAPHICS
ax.legend(loc='upper left')
bx.legend(loc='upper left')
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
fig.savefig("comp_ser_par_detr.png")


