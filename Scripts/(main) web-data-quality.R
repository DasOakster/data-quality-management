# Main Program v1.0
# See ReadMe for details

#------------------------------------------------------------------------------------------------------

# Set up libraries, working directory and source files

      library(dplyr)

      setwd("C:/Users/oakleya/Desktop/R Projects/data-quality-management")
      
      setwd("./Scripts")
      
            source("build-web-product-data.R")  
            source("tidy-attributes.R")
            source("score-product-data-quality.R")
            source("build-output-files.R") 
            source("build-psa-files.R")
            source("build-attribute-reports.R")
            source("export-output-files.R")
      
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
# Source:  tidy-attributes 
      
      attribute <- unique(web.attribute$Attribute)
      
      for (i in 1:length(attribute)) {
            
            check.missing(attribute[i])
            default.redundant.attribute(attribute[i])
      }

# Score products with data quality scores
# Source:  score-product-data-quality
      
      score.data.quality()
 
# Summarise Performance
      
      dq.summarise.results()
      
# Export Web Data Files
      
      export.product.files()

# Tidy up the environment
      
      score.files <- ls(pattern = ".score")
      rm(list=ls()[! ls() %in% c("web.product.data","report.data","gtin.issue",score.files)])     