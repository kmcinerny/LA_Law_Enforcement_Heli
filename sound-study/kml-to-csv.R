install.packages("xml2")
install.packages("rgdal", type="source")
install.packages("xslt")

# install XSLT and extension packages
library(xml2)
library(xslt)

# Parse XML and XSLT
# How can I make this a loop to read them all in at once but keep them separate in the output?
doc <- read_xml("Documents/UCLA/Carceral_ecologies/heli-analysis/sound-data/sound-flight-trajectories/003_trajectory_N228LA_58CA_20220917.kml")

# I don't get what would go here
style <- read_xml()