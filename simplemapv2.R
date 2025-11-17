#  This is a much simpler way to get maps started in R
#  We will revisit the leaflet map once we get this going.
#   - Dr. Tom Hansen
# Load libraries, install if needed
loadlibrary(osmdata)
loadlibrary(maptiles)
loadlibrary(RColorBrewer)
data = read.csv("shipdata2025-09-20.csv") ## Read in the ship data
# Establish the bounding box (the coordinates of a rectangle that defines the map)  +/- 0.001 for margin
bbox = sf::st_bbox(c(xmax=max(data$GPS_Long)+0.001,xmin=min(data$GPS_Long)-0.001,ymax=max(data$GPS_Lat)+0.001,ymin=min(data$GPS_Lat))-0.0001,crs=4623)
#get tiles
tiles_map <- get_tiles(x = bbox, provider = "CartoDB.Voyager",zoom=14, crop=TRUE)
pdf("shipmap.pdf")  # also jpg() png()  pdf() ## IF you want to save map to file
plot_tiles(tiles_map) # Plot the tiles
lines(data$GPS_Long,data$GPS_Lat,lwd=0.5,col=c("blue")) # ship track

iswarm = (data$Temp_C > 21.0) + 1
trackcolor  = c("blue","red")
trackcolors = trackcolor[iswarm]
points(data$GPS_Long,data$GPS_Lat,cex=1,pch='.',col=trackcolors)
dev.off() # only if saving to file
system2("open","shipmap.pdf")
# get_credit("Esri.NatGeoWorldMap")
# [1] "Tiles © Esri - National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC"
##sf_polygon <- getbb("Milwaukee, WI", format_out = "sf_polygon") # this is useful!
hist(data$Temp_C)
