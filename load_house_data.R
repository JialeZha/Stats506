library(stringr)

# Fields of Interest
field_list <- c("FIELD19", "FIELD20", "FIELD22", 'FIELD45', 'FIELD64', 
                'FIELD65')

# Meaning of the above Fields
field_name <- c('household_wealth', 'household_income', 'home_valuation',
                'state', 'county_code', 'census_tract')

load_house_data <- function(path) {
  # Read House Data
  house_table <- read.csv(path, colClasses = rep('character', 66))[, field_list]
  
  # Rename Fields of Interest
  colnames(house_table) <- field_name
  
  # Get Unique Census Tract Code
  house_table$census_tract <- paste('01', house_table$county_code, 
                                    house_table$census_tract, sep='')
  
  # Numeric Fields
  numeric_field <- c('household_wealth', 'household_income', 'home_valuation')
  house_table[, numeric_field] <- sapply(house_table[, numeric_field], 
                                         as.numeric)
  
  # Result
  return(house_table[house_table$home_valuation != 0, ])
}