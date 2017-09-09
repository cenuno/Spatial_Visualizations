# September 9, 2017
# Points reside inside polygons.
# This function assigns community area names
# for points that reside in each polygon
# assigns individual points the name of the polygon they reside in
get_CA_names <- function( a.data.frame
                          , a.list.of.matrices
                          , a.spatial.df ) {
  # ensure necessary packages are imported
  require( splancs )
  require( dplyr )
  
  # Ensure that the row.names of the `cps_sy1617`
  # are ordered 1:nrow( cps_sy1617 )
  row.names( a.data.frame ) <- as.character( 1:nrow( a.data.frame ) )
  
  # Create 'Community_Area' variable inside the data frame
  # and assign it a value of NA
  a.data.frame$Community_Area <- NA
  
  # start your counter
  i <- 1
  
  # start your while loop
  while( i <= length( a.list.of.matrices )  ) {
    # 1. df with only long and lat
    df_lon_lat <- select( a.data.frame
                          ###### CAUTION #####################
                          # More than likely, ################
                          # you will have to replace #########
                          # the column names to represent ####
                          # the longitutde and latitude ######
                          # variables within your data frame #
                          ####################################
                          , School_Longitude # double check
                          , School_Latitude # double check
    )
    # rename long as x and lat as y
    colnames(df_lon_lat)[1] <- "x"
    colnames(df_lon_lat)[2]  <- "y"
    
    # 2. add in.shape to dataframe
    df_lon_lat$in.shape <- 1:nrow( df_lon_lat) %in%
      inpip( df_lon_lat
             , a.list.of.matrices[[i]]
      )
    #### THIS IS WHERE YOU HAVE TO FILTER BASED ON WHETHER
    #### df_lon_lat$in.shape has any TRUE values
    #### if yes, procceed with steps 3-6
    #### if no, tell the counter to increase by 1
    #### and restart the function
    if( any( df_lon_lat$in.shape ) == FALSE ) {
      # add one to counter
      i <- i + 1
    } else{
      # 3. give me the elements that are TRUE
      only_true <- df_lon_lat[ df_lon_lat$in.shape == TRUE, ]
      
      # 4. filter the orgs data frame by the row names within step 3
      # 5. and assign the Community Area polygon name
      a.data.frame[ as.numeric( row.names( only_true ) ), ]$Community_Area <- a.spatial.df$community[i]
      
      # 6. repeat until all community areas are given a name
      i <- i + 1
    } # end of else statement
    
  } # end of while loop
  
  # return a new data frame
  return( a.data.frame )
  
} # end of get_CA function
