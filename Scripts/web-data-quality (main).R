
# Main Program v1.0
# See ReadMe for details

#------------------------------------------------------------------------------------------------------

# Set up libraries, working directory and source files

      library(dplyr)

      setwd("C:/Users/oakleya/Desktop/R Projects/data-quality-management")     # Wilko laptop
      #--setwd("D:/OneDrive/R Projects/product-data-quality")           # Personal laptop      
      
      setwd("./Scripts")
      
            source("create-web-product-data.R")  
            source("data-quality-functions.R")
            source("score-product-data-quality.R")
            source("summarise-results.R")
            source("create-product-files.R")      
            source("export-files.R")
      
      setwd("..")
      
# Import the Google Feed, SAP extract, PSA Lookup table and Web Attribute table
# Source:  create-web-product-data.R

      import.web.data()

# Tidy up the files so they can be matched
# Source:  create-web-product-data.R
      
      tidy.web.data()


# Merge files together into web_product_file     
# Source:  create-web-product-data.R
            
      merge.web.data()

# Check attributes for completeness
# Default attribute values to NA if they are not required
# Source:  data-quality-functions  
      
      attribute <- unique(web.attribute$Attribute)
      
      for (i in 1:length(attribute)) {
            
            check.missing(attribute[i])
            default.redundant.attribute(attribute[i])
      }


# Check consistency between brand attribute and product title
# Source:  data-quality-functions  

      check.brand.consistency()

# Score products with data quality scores
# Source:  score-product-data-quality
      
      score.data.quality()
 
# Summarise Performance
      
      summarise.results()
      
# Export Web Data Files
      
      #export.files()

# Tidy up the environment
      
      rm(list=ls()[! ls() %in% c("web.product.data")])     