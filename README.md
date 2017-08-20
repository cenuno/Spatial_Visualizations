# Spatial_Visualizations

Tutorials regarding spatial visualization and analysis.

*****************

## Mapping the CTA

[![](https://github.com/cenuno/Spatial_Visualizations/raw/master/Images/MapCTA.png)](https://rpubs.com/cenuno/Mapping_CTA)

[Tutorial](https://rpubs.com/cenuno/Mapping_CTA) on how to plot the Chicago Transportation Authority (CTA) 'L' Rail Line, Rail Stations, Bus Routes, and Bus Stops for the City of Chicago.
******************
# Point-n-Polygon

[![](https://github.com/cenuno/Spatial_Visualizations/raw/master/Images/PointNPolygon.png)](https://rpubs.com/cenuno/spatial_analysis_pts_poly)

What follows is a [tutorial](https://rpubs.com/cenuno/spatial_analysis_pts_poly) on the key spatial elements needed to understand how to identify points which reside in specific polygons.
*******************

## Querying USAspending API data from RStudio

[![](https://github.com/cenuno/Spatial_Visualizations/raw/master/Images/QueryUSA.png)](https://rpubs.com/cenuno/USAspendingAPI)

[USAspending API](https://api.usaspending.gov/) offers an interactive way for active citizens to query relevant federal spending data on a variety of fields. People can query data by geography, type of federal spending, CFDA program number, and much more. [Click here a tutorial](https://rpubs.com/cenuno/USAspendingAPI) on querying the data for FY17 Austin, Texas.

## Call "Spatial Analysis of Points-in-Polygons" R script

Copy and paste the following code to run the script from your R console. 
```R
# install necessary packages
install.packages( c("dplyr", "splancs"
                     , "rgdal", "magrittr"
                     , "pander" 
                     )
                 )

# import necessary packages
library( dplyr ) # manipulate data frames
library( splancs ) # conduct spatial point-in-polygon analysis
library( rgdal ) # import GeoJSON files
library( magrittr ) # use the %>% pipeline operator
library( pander ) # make tables pretty in HTML

# run code from GitHub function
source_github <- function( url ) {
  # load package
  require(RCurl)
  
  # read script lines from website and evaluate
  script <- getURL(url, ssl.verifypeer = FALSE)
  eval(parse(text = script), envir=.GlobalEnv)
} 

# Spatial Point and Polygon Analysis Raw URL
raw_url <- "https://raw.githubusercontent.com/cenuno/Spatial_Visualizations/master/spatial_point_polygon_analysis.r"

# run code from GitHub
source_github( raw_url )

```
## Run R Scripts from GitHub and Enable R Objects with 'source_github' function
```R
source_github <- function( url ) {
  # load package
  require(RCurl)
  
  # read script lines from website and evaluate
  script <- getURL(url, ssl.verifypeer = FALSE)
  eval(parse(text = script), envir=.GlobalEnv)
} 
```
*****************
## Import RDS files into RStudio

Step 1: ID a .rds file inside a GitHub repository (https://github.com/DataCapstone/Data-Capstone/tree/master/Drafts/ceuno)

Step 2: Once .rds file is found, ID the phrase "View Raw"

Step 3: Right-click on "View Raw"

Step 4: Click on "Copy Link Address" option from the menu

Step 5: Paste the link address into a character vector

```R
rds_url <- "https://github.com/DataCapstone/Data-Capstone/blob/master/Drafts/ceuno/chi_hou_philly_projectgrants_fy17.rds?
```

Step 6: Nest the character vector into the following functions: 

```R
rds.df <- readRDS( gzcon(url( rds_url ) ) )
```

Step 7: Congratulations!

You now know how to import .rds files into RStudio!
*****************
