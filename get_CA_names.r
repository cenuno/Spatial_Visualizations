# August 15, 2017
# Points reside inside polygons.
# This function assigns community area names
# for points that reside in each polygon
get_CA_names <- function( a.data.frame
                          , a.list_of_matrices
                          , a.spatialdf ) {
  require( splancs )
  require( dplyr )
  # start your counter
  i <- 1
  
  # start your while loop
  while( i <= length( a.list_of_matrices )  ) {
    # 1. df with only long and lat
    df_lon_lat <- select( a.data.frame
                          , School_Longitude # double check
                          , School_Latitude # double check
    )
    # rename long as x and lat as y
    colnames(df_lon_lat)[1] <- "x"
    colnames(df_lon_lat)[2]  <- "y"
    
    # 2. add in.shape to dataframe
    df_lon_lat$in.shape <- 1:nrow( df_lon_lat) %in%
      inpip( df_lon_lat
             ,a.list_of_matrices [[i]]
             )
    
    # 3. give me the elements that are TRUE
    only_true <- df_lon_lat[ df_lon_lat$in.shape == TRUE, ]
    
    # 4. filter the orgs data frame by the row names within step 3
    # 5. and assign the Community Area polygon name
    a.data.frame[ as.numeric( row.names( only_true ) ), ]$Community_Area <- a.spatialdf$community[i]
    
    # 6. repeat until all community areas are given a name
    i <- i + 1
    
  } # end of while loop

# return a new data frame
  return( a.data.frame )
    
} # end of function
