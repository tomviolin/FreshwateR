#  This is a much simpler way to get maps started in R
#  We will revisit the leaflet map once we get this going.
#   - Dr. Tom Hansen
# Load libraries, install if needed
if (!require(osmdata)) install.packages("osmdata") ; library(osmdata)
if (!require(maptiles)) install.packages("maptiles") ; library(maptiles)
shipd = read.csv("shipdata2025-09-20.csv") ## Read in the ship data
# Establish the bounding box (the coordinates of a rectangle that defines the map)  +/- 0.001 for margin
bbox = sf::st_bbox(c(xmax=max(shipd$GPS_Long)+0.001,xmin=min(shipd$GPS_Long)-0.001,ymax=max(shipd$GPS_Lat)+0.001,ymin=min(shipd$GPS_Lat))-0.0001,crs=4623)
#get tiles
tiles_map <- get_tiles(x = bbox, provider = "CartoDB.Voyager",zoom=14, crop=TRUE)
pdf("shipmap.pdf")  # also jpg() png()  pdf() ## IF you want to save map to file
#plot_tiles(tiles_map) # Plot the tiles
lines(shipd$GPS_Long,shipd$GPS_Lat,lwd=2,col=c("blue")) # ship track
#dev.off() # only if saving to file
#system2("open","shipmap.pdf")
# get_credit("Esri.NatGeoWorldMap")
# [1] "Tiles © Esri - National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC"
##sf_polygon <- getbb("Milwaukee, WI", format_out = "sf_polygon") # this is useful!
