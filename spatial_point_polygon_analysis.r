# import necessary packages
library( dplyr )
library( magrittr )
library( rgdal )
library( splancs )

# save copied link as a character vector
geojson_comarea_url <- "https://data.cityofchicago.org/api/geospatial/cauq-8yn6?method=export&format=GeoJSON"

# transform vector into spatial dataframe
comarea606 <- readOGR( dsn = geojson_comarea_url
                       , layer = "OGRGeoJSON"
                       , stringsAsFactors = FALSE
)

# import cps school data for SY1617
cps_sy1617_url <- "https://data.cityofchicago.org/api/views/8i6r-et8s/rows.csv?accessType=DOWNLOAD"

# transform URL into a data frame using the base `read.csv` function
cps_sy1617 <- read.csv( file = cps_sy1617_url
                                , header = TRUE
                                , stringsAsFactors = FALSE
)

# create placeholder variable for Community Area
cps_sy1617$Community_Area <- NA

# Source GitHub function
source_github <- function( url ) {
  # load package
  require(RCurl)
  
  # read script lines from website and evaluate
  script <- getURL(url, ssl.verifypeer = FALSE)
  eval(parse(text = script), envir=.GlobalEnv)
} 

# `get_poly_matrix_coord` function URL from GitHub
gpmc_url <- "https://raw.githubusercontent.com/cenuno/Spatial_Visualizations/master/get_poly_matrix_coord.r"

# call the function
source_github( gpmc_url )

# create list of lat. and lon. coordinates that reside
# in each polygon
com_area_polygons <- get_poly_matrix_coord( comarea606 ) # list of 77 matrices

# Assign each list the name of its corresponding Community Area polygon
names( com_area_polygons ) <- comarea606$community

# `get_CA_names` function URL from GitHub
gCAnames_url <- "https://raw.githubusercontent.com/cenuno/Spatial_Visualizations/master/get_CA_names.r"

# call the function
source_github( gCAnames_url )

# Run the `get_CA_names` function
cps_sy1617 <- get_CA_names( a.data.frame = cps_sy1617
                            , a.list_of_matrices = com_area_polygons
                            , a.spatialdf = comarea606
                            )

# As a final test, plot a new map of CPS schools that only reside in any of the three Community Areas:
# * Irving Park
# * South Lawndale
# * Washington Heights

# plot the polygons
plot( comarea606
      , main = "CPS Schools in Selected Community Areas, 2016-2017 School Year"
      ) 

# create a legend
legend( "left"
        , pch = 20
        , pt.cex = 1
        , legend = c("Irving Park"
                     , "South Lawndale"
                     , "Washington Heights"
                     )
        , col = c( "#8F3931"
                  , "#8A9045"
                  , "#155F83"
                  )
        , bty = "n"
        )

# add the points for Irving Park
# assigning them a red color
points( x = cps_sy1617$School_Longitude[ cps_sy1617$Community_Area ==
                                           "IRVING PARK"
                                         ]
        , y = cps_sy1617$School_Latitude[ cps_sy1617$Community_Area ==
                                           "IRVING PARK"
                                         ]
        , col = "#8F3931" # red 
        , pch = 20 # for more information on point type, look at ?par
          )

# add the points for South Lawndale
# assigning them a green color
points( x = cps_sy1617$School_Longitude[ cps_sy1617$Community_Area ==
                                           "SOUTH LAWNDALE"
                                         ]
        , y = cps_sy1617$School_Latitude[ cps_sy1617$Community_Area ==
                                           "SOUTH LAWNDALE"
                                         ]
        , col = "#8A9045" # green
        , pch = 20 # for more information on point type, look at ?par
          )

# add the points for Washington Heights
# assigning them a blue color
points( x = cps_sy1617$School_Longitude[ cps_sy1617$Community_Area ==
                                           "WASHINGTON HEIGHTS"
                                         ]
        , y = cps_sy1617$School_Latitude[ cps_sy1617$Community_Area ==
                                           "WASHINGTON HEIGHTS"
                                         ]
        , col = "#155F83" # blue
        , pch = 20 # for more information on point type, look at ?par
          )

# add source
mtext( side = 1
       , adj = 1
       , line = 2
       , cex = 0.5
       , text = "Source:  https://data.cityofchicago.org/Education/Chicago-Public-Schools-School-Profile-Information-/8i6r-et8s/data")

# add source
mtext( side = 1
       , adj = 1
       , line = 3
       , cex = 0.5
       , text = "Author: Cristian E. Nuno")

# add source
mtext( side = 1
       , adj = 1
       , line = 4
       , cex = 0.5
       , text = "Date: August 6, 2017")





