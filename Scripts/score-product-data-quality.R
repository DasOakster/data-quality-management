
score.data.quality <- function() {

# Set score components
      
      web.description.score <- 6.5
      attribute.score <- 10 - web.description.score

# Work out how many attributes are required for the Article
# The DQ Attribute fields have already been set to either 1: Populated, 0: Empty, NA: Not required
# Divides the attribute weight by the number of attributes required to calculate a score for each individual attribute

      dq.attribute.fields <- c(37:49)
      
      attribute.required <- rowSums(!is.na(web.product.data[dq.attribute.fields]))
      
      attribute.actual <- rowSums(web.product.data[,dq.attribute.fields],na.rm = TRUE)
      
      attribute.value <- (attribute.score / attribute.required) 
      attribute.score <- attribute.actual * attribute.value

# Sets the attribute score to zero if NA
      
      web.product.data$'DQ Attribute Score' <<- attribute.score
      
# Check 100 Character Field
      
      web.product.data$'DQ Web Description Score' <<- 0
      web.product.data$'DQ Web Description Score'[web.product.data$`Web Description 1`!=""] <<- web.description.score
      
# Set Score field to Zero
      
      web.product.data$'DQ Score' <<- 0

# Add the two components of the score together and round to 1 decimal place
      
      dq.score.columns <<- c("DQ Web Description Score","DQ Attribute Score","DQ Brand Consistency Score")
      
      web.product.data$`DQ Score` <<- rowSums(web.product.data[,dq.score.columns],na.rm = TRUE)
      web.product.data$`DQ Score` <<- signif(web.product.data$`DQ Score`,2)
      web.product.data$`DQ Score` <<- web.product.data$`DQ Score` * 10
}



