
#### name:dat1 ####
library(raster)
library(ncdf4)

projdir <- "~/projects/CSIRO-ACCESS-NSW-past-and-future-2100"
setwd(projdir)
dir()
indir <- "data_provided"
dir(indir)
infile <- "NSW_pr_Amon_ACCESS1-3_rcp85_r1i1p1_200601-210012.nc"

in_nc <- file.path(indir, infile)

nc <- nc_open(in_nc)
nc
nc_close(nc)
## [1] "     3 dimensions:"
## [1] "        longitude  Size:9"
## [1] "            units: degrees_east"
## [1] "            long_name: longitude"
## [1] "        latitude  Size:8"
## [1] "            units: degrees_north"
## [1] "            long_name: latitude"
## [1] "        value  Size:1140   *** is unlimited ***"
## [1] "            units: unknown"
## [1] "            long_name: value"
## [1] ""
## [1] "    3 global attributes:"
## [1] "        Conventions: CF-1.4"
## [1] "        created_by: R, packages ncdf and raster (version 2.3-12)"
## [1] "        date: 2015-11-10 11:04:03"

png("graphs/qc_future_values.png", width = 1200, height = 800)
par(mfrow = c(4,12))
for(i in 1:(12*4)){
#  i = 1
r <- raster(in_nc, band = i)
  ## str(r)
  ## ..@ crs     :Formal class 'CRS' [package "sp"] with 1 slot
  ## .. .. ..@ projargs: chr "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0" 
plot(r)
title(i)
}
dev.off()
#r
#r@data

#### name:dat2 historical ####
library(raster)
library(ncdf4)

projdir <- "~/projects/CSIRO-ACCESS-NSW-past-and-future-2100"
setwd(projdir)
indir <- "data_provided"
dir(indir)
infile <- "NSW_pr_Amon_ACCESS1-3_historical_r1i1p1_185001-200512.nc"
in_nc <- file.path(indir, infile)


# NSW SDs
indir_shp  <- "/home/ivan_hanigan/projects/opensoftware-restricteddata.github.com/report1_high_level/data"
dir(indir_shp)
infile_shp <- "nswsd07"
shp <- readOGR(indir_shp, infile_shp)
shp@proj4string
# CRS arguments: +proj=longlat +ellps=GRS80 +no_defs 


nc <- nc_open(in_nc)
nc
nc_close(nc)
## [1] "File data_provided/NSW_pr_Amon_ACCESS1-3_historical_r1i1p1_185001-200512.nc (NC_FORMAT_CLASSIC):"
## [1] ""
## [1] "     1 variables (excluding dimension variables):"
## [1] "        float time[longitude,latitude,value]   "
## [1] "            _FillValue: -3.4e+38"
## [1] "            missing_value: -3.4e+38"
## [1] "            long_name: time"
## [1] "            projection: +proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
## [1] "            projection_format: PROJ.4"
## [1] "            min: 3.53837185684824e-06"
## [2] "            min: 2.6450557015778e-06" 
# [snip...]
## [1871] "            max: 0.000108075561001897"
## [1872] "            max: 7.84636431490071e-05"
## [1] "     3 dimensions:"
## [1] "        longitude  Size:9"
## [1] "            units: degrees_east"
## [1] "            long_name: longitude"
## [1] "        latitude  Size:8"
## [1] "            units: degrees_north"
## [1] "            long_name: latitude"
## [1] "        value  Size:1872   *** is unlimited ***"
## [1] "            units: unknown"
## [1] "            long_name: value"
## [1] ""
## [1] "    3 global attributes:"
## [1] "        Conventions: CF-1.4"
## [1] "        created_by: R, packages ncdf and raster (version 2.3-12)"
## [1] "        date: 2015-11-10 11:04:37"

r
# So you gave me
#extent      : 141.5625, 158.4375, -38.125, -28.125  (xmin, xmax, ymin, ymax)
# BUT THE NSW SHAPFILE HAS MORE WEST
shp@bbox
##         min       max
## x 140.99928 159.10922
## y -37.50506 -28.15702

#r@data

png("graphs/qc_historic_values.png", width = 1200, height = 800)
par(mfrow = c(2,6))
for(i in 1:12){
r <- raster(in_nc, band = i)
plot(shp)
plot(r, add = T)
plot(shp, add = T)
title(i)
}
dev.off()
