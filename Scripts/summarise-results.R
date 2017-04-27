
summarise.psa1 <- function() {
      
      psa1.rank <<- aggregate(web.product.data$`DQ Score`,list(web.product.data$PSA_1),mean)
      colnames(psa1.rank) <<- c("PSA 1","Avg Data Quality Score")
      psa1.rank$'Avg Data Quality Score' <<- signif(psa1.rank$'Avg Data Quality Score',2)
      
}

#------------------------------------------------------------------------------------------------------------------

summarise.psa2 <- function() {

      psa2.rank <<- aggregate(web.product.data$`DQ Score`,list(web.product.data$PSA_2),mean)
      colnames(psa2.rank) <<- c("PSA 2","Avg Data Quality Score")
      psa2.rank$'Avg Data Quality Score' <<- signif(psa2.rank$'Avg Data Quality Score',2) 
}

#------------------------------------------------------------------------------------------------------------------

summarise.asst.buyer <- function() {
      
      asst.buyer <<- aggregate(web.product.data$`DQ Score`,list(web.product.data$`Asst Buyer`),mean)
      asst.buyer <<- cbind(asst.buyer,aggregate(web.product.data$`DQ Score`,list(web.product.data$`Asst Buyer`),length))
      asst.buyer <<- asst.buyer[,c(1,2,4)]
      colnames(asst.buyer) <<- c("Assistant Buyer","Avg Data Quality Score", "Num Articles")
      asst.buyer$'Avg Data Quality Score' <<- signif(asst.buyer$'Avg Data Quality Score',2) 
      
}

#------------------------------------------------------------------------------------------------------------------

summarise.web.category <- function() {
      
      web.category <<- aggregate(web.product.data$`DQ Score`,list(web.product.data$`Web Category`),mean)
      web.category <<- cbind(web.category,aggregate(web.product.data$`DQ Score`,list(web.product.data$`Web Category`),length))
      web.category <<- web.category[,c(1,2,4)]
      colnames(web.category) <<- c("Web Category","Avg Data Quality Score", "Num Articles")
      web.category$'Avg Data Quality Score' <<- signif(web.category$'Avg Data Quality Score',2) 
      
}

#------------------------------------------------------------------------------------------------------------------

summarise.results <- function() {
      
      summarise.psa1()
      summarise.psa2()
      summarise.asst.buyer()
      summarise.web.category()
      
}