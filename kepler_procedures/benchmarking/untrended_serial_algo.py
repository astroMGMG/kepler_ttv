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
name='952.01.csv'
data = loadtxt(name,comments="#",delimiter=",",usecols=(0,1,2,3))

time= data[:,0]
flux_de= data[:,1]
flux_un= data[:,2]

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
ax.plot(time,flux_un,color="blue",marker=".",markersize=5,linewidth=0,linestyle="-",label="Untrended Flux")

ax.set_xlim(0,1050)
#ax.set_ylim(0.985,1.015)

#ax.set_xlim(220,275)
#ax.set_ylim(0.985,1.015)

#
#fig12

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
fig.savefig("untrended_serial_algo.png")


