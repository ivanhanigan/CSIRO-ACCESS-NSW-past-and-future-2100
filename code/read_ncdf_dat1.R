
#### name:dat1 ####
library(raster)
library(ncdf4)

projdir <- "~/projects/CSIRO-ACCESS-NSW-past-and-future-2100"
setwd(projdir)
indir <- "data_provided"
dir(indir)
infile <- "NSW_pr_Amon_ACCESS1-3_rcp85_r1i1p1_200601-210012.nc"

in_nc <- file.path(indir, infile)

nc <- nc_open(in_nc)
nc
nc_close(nc)
par(mfrow = c(4,12))
for(i in 1:(12*4)){
r <- raster(in_nc, band = i)
plot(r)
title(i)
}
dev.off()
r
r@data

#### name:dat2 ####
library(raster)
library(ncdf4)

projdir <- "~/projects/CSIRO-ACCESS-NSW-past-and-future-2100"
setwd(projdir)
indir <- "data_provided"
dir(indir)
infile <- "NSW_pr_Amon_ACCESS1-3_historical_r1i1p1_185001-200512.nc"
in_nc <- file.path(indir, infile)

nc <- nc_open(in_nc)
nc
nc_close(nc)
par(mfrow = c(2,6))
for(i in 1:12){
r <- raster(in_nc, band = i)
plot(r)
title(i)
}
dev.off()
r
r@data
