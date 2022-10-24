# install GDAL
library(rgdal)

# KML to CSV conversion, from this post by Chris Holbrook: https://gitlab.oceantrack.org/GreatLakes/glatos/blob/192d92108caaf03613c05c1bad5e361288233cbc/R/util-kml_to_csv.r

kml_to_csv <- function(filePath, type) {#filePath = full path to the kml file, type = c('points', 'lines', 'polygons')
  # Function requires the package 'rgdal' for the readOGR function, which is used to parse the kml file.
  
  # Determine the layer name from the kml file.
  a <- readLines(filePath)
  layerLine <- which(grepl("<Folder>", a)) + 1
  layer <- strsplit(strsplit(a[layerLine], ">")[[1]][2], "<")[[1]][1]
  
  # Create a new directory to contain the results.
  dir.create(file.path(paste(dirname(filePath), gsub(".kml", "", basename(filePath)), sep="/")), showWarnings = FALSE) 
  resultsFolder <- file.path(paste(dirname(filePath), gsub(".kml", "", basename(filePath)), sep="/"))
  
  # Use rgdal package function to parse the kml into usable information (NOTE: readOGR cannot handle features with different geometries (e.g., lines and polygons), so each kml file processed with this script can contain only one class of feature.	
  kml <- rgdal::readOGR(filePath, layer = layer)
  
  # Retrieves the names of features in the kml file.
  
  Labels <- kml@data$Name 
  
  
  # Write kml features to csv
  
  if (type == 'points') { # If type = 'points' all points are written to a single csv file.
    coordinates <- as.data.frame(kml@coords)
    coordinates$Labels <- Labels
    coordinates <- coordinates[, c(4, 1, 2, 3)]
    names(coordinates) <- c('Label', 'Longitude', 'Latitude', 'Altitude')
    write.csv(coordinates, file = file.path(paste0(resultsFolder, "/CoordinatesFromKML.csv")), row.names=FALSE)	
    
  } else if (type == 'polygons') { # Separate csv file written for each polygon			
    
    for (i in 1:length(Labels)) {
      label <- Labels[i]		
      coordinates <- as.data.frame(kml@polygons[[i]]@Polygons[[1]]@coords)
      names(coordinates) <- c('Longitude', 'Latitude')
      write.csv(coordinates, file = file.path(paste0(resultsFolder, "/", paste0("Polygon_", Labels[i], ".csv"))), row.names=FALSE)
    }	
    
  } else if (type == 'lines') {	
    
    for (i in 1:length(Labels)) { # Separate csv written for each line.
      label <- Labels[i]		
      coordinates <- as.data.frame(kml@lines[[i]]@Lines[[1]]@coords)
      names(coordinates) <- c('Longitude', 'Latitude')
      write.csv(coordinates, file = file.path(paste0(paste0(resultsFolder, "/", paste0("Line_", Labels[i], ".csv")))), row.names=FALSE)
    }
    
  }
  return(paste0("Output file(s) are located in a folder named '", gsub(".kml", "", basename(filePath)), "' located in the same directory as the original kml file"))
}


kml_to_csv("Documents/UCLA/Carceral_ecologies/heli-analysis/sound-data/sound-flight-trajectories/011_trajectory_N223LA_58CA_20220927.kml", points)



# This was a second way to do it
# install XSLT and extension packages
library(xml2)
library(xslt)

# Parse XML and XSLT
# How can I make this a loop to read them all in at once but keep them separate in the output?
doc <- read_xml("Documents/UCLA/Carceral_ecologies/heli-analysis/sound-data/sound-flight-trajectories/003_trajectory_N228LA_58CA_20220917.kml")

# I don't get what would go here
style <- read_xml()


