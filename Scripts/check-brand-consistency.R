

check_brand_consistency <- function() {

web_product_file$`DQ Brand Consistency` <<- NA
      
for(i in 1:NROW(web_product_file)) {
      
      
      if(is.na(web_product_file$`Brand`[i])) {
            
            web_product_file$`DQ Brand Consistency`[i] <<- NA
      }
      
      
      else {
            
            if(grepl(toupper(web_product_file$Brand[i]),toupper(web_product_file$`Web Description 1`[i])) == FALSE) {
                  
                  web_product_file$`DQ Brand Consistency`[i] <<- -0.5 
            }
            
      }      
      
}
      
}
