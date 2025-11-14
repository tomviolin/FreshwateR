
library(leaflet)
data = read.csv("shipdata2025-09-20.csv")


for (i in 1:44) {
	urltempl = (get_providers()[i][[1]]$q)
	provname = (get_providers()[i][[1]]$src) 
	m = leaflet() %>%
	    addTiles(urlTemplate=urltempl) %>%
	    addPolylines(lng=data$GPS_Long, lat=data$GPS_Lat, weight=2, smooth.factor=3)
	print(m)
}


