library(ncdf)
library(maptools)

library(RColorBrewer)
library(lattice)
library(raster)
library(rasterVis)


url='http://opendap.renci.org:1935/thredds/dodsC/oedata/SSH.1440x720.20140917.nc'

nc=open.ncdf(url)

lon=get.var.ncdf(nc, "LONGITUDE_T") 
lon <- lon-180

lat=get.var.ncdf(nc, "LATITUDE_T") 


ssh=get.var.ncdf(nc, "SSH") 
temp11 <- ssh[ , ] 

% plot as image
image(lon,lat,temp11) 
data(wrld_simpl)
plot(wrld_simpl,add=TRUE)



grid <- expand.grid(xlon=lon, ylat=lat)
xyz <- cbind(grid, temp11)
pj <- "+proj=lcc +lat_1=25.00 +lat_2=60.00 +lat_0=42.5 +lon_0=-100.00 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs"


rast.ssh <- rasterFromXYZ(xyz, crs=pj) 
