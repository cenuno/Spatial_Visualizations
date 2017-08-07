# Spatial_Visualizations
Tips and tricks regarding spatial visualization.
*****************
## Call "Spatial Analysis of Points-in-Polygons" R script

Copy and paste the following code to run the script from your R console. 
```
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
## Import data from github function
```
source_github <- function( url ) {
  # load package
  require(RCurl)
  
  # read script lines from website and evaluate
  script <- getURL(url, ssl.verifypeer = FALSE)
  eval(parse(text = script), envir=.GlobalEnv)
} 
```
*****************
## How to Import RDS files into RStudio

Step 1: ID a .rds file inside a GitHub repository (https://github.com/DataCapstone/Data-Capstone/tree/master/Drafts/ceuno)

Step 2: Once .rds file is found, ID the phrase "View Raw"

Step 3: Right-click on "View Raw"

Step 4: Click on "Copy Link Address" option from the menu

Step 5: Paste the link address into a character vector

```
rds_url <- "https://github.com/DataCapstone/Data-Capstone/blob/master/Drafts/ceuno/chi_hou_philly_projectgrants_fy17.rds?
```

Step 6: Nest the character vector into the following functions: 

```
rds.df <- readRDS( gzcon(url( rds_url ) ) )
```

Step 7: Congratulations!

You now know how to import .rds files into RStudio!
*****************
