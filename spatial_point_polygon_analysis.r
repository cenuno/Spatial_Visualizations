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
