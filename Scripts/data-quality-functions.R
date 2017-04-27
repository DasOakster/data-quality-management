
check.missing <- function(attribute) {
      
# Checks for the attribute passed whether which web categories it is required for
# It then checks the products within those web categories and flags them es either 1 or 0
# 1 means there is a value present, 0 means there is NA
# The values are later used as an input into the overall data quality score


      # Find the attribute column in web.product.data
      
      attribute.field <- grep(attribute,colnames(web.product.data))      
      
      # Create a new Data Quality column for the attribute
      
      data.quality.field <- paste("DQ",attribute)                           
      web.product.data[,data.quality.field] <- NA                          
      
      # Create flags for data quality checking
      
      data.quality.issue <- 0                       
      data.quality.ok <- 1                                         
      
      # Create the Web Category look-up table i.e. the web catgories requiring this attribute
      
      web.category <- subset(web.attribute,web.attribute[,1] == attribute)
      
      # Create a missing.attributeorary table of the Articles to update
      
      missing.attribute <- subset(web.product.data,(web.product.data$`Web Category` %in% web.category$Category) & is.na(web.product.data[,attribute.field]))
      populated.attribute <- subset(web.product.data,(web.product.data$`Web Category` %in% web.category$Category) & !is.na(web.product.data[,attribute.field]))
      
      # Update the Articles in the Product table
      
      web.product.data[web.product.data$Article %in% missing.attribute$Article,data.quality.field] <<- data.quality.issue
      web.product.data[web.product.data$Article %in% populated.attribute$Article,data.quality.field] <<- data.quality.ok

      
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

check.brand.consistency <- function(){
      
# Checks if the brand value in the attribute field appears in the product title
      
      # Set data quality issue flag and create column
      
      data.quality.issue <- -0.5
      web.product.data$`DQ Brand Consistency Score` <<-0
      
      # Loop through web.product.data
      
      for(i in 1:NROW(web.product.data)) {
            
            # Check if brand is NA 
            
            if(is.na(web.product.data$`Brand`[i])) {
                  
                  web.product.data$`DQ Brand Consistency Score`[i] <<- NA
                  }
            
            # Convert both attribute and title to uppercase (test is case sensitive) and compare
            
                  else {
                  
                  if(grepl(toupper(web.product.data$Brand[i]),toupper(web.product.data$`Web Description 1`[i])) == FALSE) {
                        
                        web.product.data$`DQ Brand Consistency Score`[i] <<- data.quality.issue
                        }
                  
                  }      
            
            }
}

default.assembly.attribute <- function() {
      
      # Create a list of Web Categories that do not require Assembly
      
      web.category.assembly <- subset(web.attribute,web.attribute[,1] == "Assembly")
      web.category <- web.attribute[!(web.attribute$Category %in% web.category.assembly$Category),]
      web.category <- data.frame(unique(web.category$Category),stringsAsFactors = FALSE)
      colnames(web.category) <- "Category"
      
      # Create a missing.attributeorary table of the Articles to update
      
      populated.attribute <- subset(web.product.data,web.product.data$`Web Category` %in% web.category$Category)
      
      # Update the Articles in the Product table to NA where Assembly is not required
      
      web.product.data[(web.product.data$Article %in% populated.attribute$Article),28] <<- NA
}


default.redundant.attribute <- function(attribute) {
      
# Checks for the attribute passed whether which web categories it is required for
# It then checks the products within those web categories and defaults them to NA
# This is so they can be suppressed from the Data Quality reports
      
      
      # Create a list of Web Categories that do not require a value
      
      web.category.attribute <- subset(web.attribute,web.attribute[,1] == attribute)
      web.category <- web.attribute[!(web.attribute$Category %in% web.category.attribute$Category),]
      web.category <- data.frame(unique(web.category$Category),stringsAsFactors = FALSE)
      colnames(web.category) <- "Category"
      
      # Create a missing.attributeorary table of the Articles to update
      
      populated.attribute <- subset(web.product.data,web.product.data$`Web Category` %in% web.category$Category)
      
      # Update the Articles in the Product table to NA where Assembly is not required
      
      web.product.data[(web.product.data$Article %in% populated.attribute$Article),attribute] <<- NA
      
}
