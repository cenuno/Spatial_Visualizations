# Create `get_poly_matrix_coord` function to 
# access coordinate values within multiple polygons 
# inside a spatial data frame.

get_poly_matrix_coord <- function( spatial_poly_df ) {
  # start counter
  i <- 1
  # create empty list
  empty_list <- list()
  # start while loop
  while( nrow( spatial_poly_df ) >= i ) {
    # fill the empty list with one set of coordinates
    empty_list[[i]] <- spatial_poly_df@polygons[[i]]@Polygons[[1]]@coords
    # add 1 to the counter
    i <- i + 1
  } # end of while loop
  return( empty_list )
} # end of function
