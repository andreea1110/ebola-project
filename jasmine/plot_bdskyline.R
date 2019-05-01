library(bdskytools)

#load file
fname <- "/Users/Jasmine/Documents/ETH/S2 Bayesian Phylodynamics/Project/conakry2_x4/conakry2.log"
lf    <- readLogfile(fname, burnin=0.1)

#extract HPDs
Re_sky    <- getSkylineSubset(lf, "reproductiveNumber")
Re_hpd    <- getMatrixHPD(Re_sky)
delta_hpd <- getHPD(lf$becomeUninfectiousRate)

#plot raw intervals for Re
plotSkyline(1:10, Re_hpd, type='step', ylab="R")

#extract HPDs for finer timegrid
timegrid <- seq(1,2,length.out=100)
Re_gridded     <- gridSkyline(Re_sky, lf$origin, timegrid)
Re_gridded_hpd <- getMatrixHPD(Re_gridded)

#plot smooth skyline
times     <- 2015.78-timegrid
plotSkyline(times, Re_gridded_hpd, type='smooth', xlab="Time", ylab="R")

#plot overlapping intervals
plotSkyline(times, Re_gridded, type='steplines', traces=10, col=pal.dark(cblue,0.5),ylims=c(0,5), xlab="Time", ylab="R")
plotSkyline(times, Re_gridded, type='steplines', traces=100, col=pal.dark(cblue,0.5),ylims=c(0,5), xlab="Time", ylab="R")
plotSkyline(times, Re_gridded, type='steplines', traces=1000, col=pal.dark(cblue,0.1),ylims=c(0,5), xlab="Time", ylab="R")

#plot Re and becommingNonInfectiousRate
par(mar=c(5,4,4,4)+0.1)
plotSkylinePretty(range(times), as.matrix(delta_hpd), type='step', axispadding=0.0, col=pal.dark(cblue), fill=pal.dark(cblue, 0.5), col.axis=pal.dark(cblue), ylab=expression(delta), side=4, yline=2, ylims=c(0,1), xaxis=FALSE)
plotSkylinePretty(times, Re_gridded_hpd, type='smooth', axispadding=0.0, col=pal.dark(corange), fill=pal.dark(corange, 0.5), col.axis=pal.dark(corange), xlab="Time", ylab=expression("R"[e]), side=2, yline=2.5, xline=2, xgrid=TRUE, ygrid=TRUE, gridcol=pal.dark(cgray), ylims=c(0,3), new=TRUE, add=TRUE)



