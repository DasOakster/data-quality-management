#  Outputs each Asst Buyer's articles

output.buyer.lists <- function() {

all.buyers <- unique(web.product.data$`Asst Buyer`)

for (i in 1:length(all.buyers)) {
      
      buyer <- all.buyers[i]
      product.list.name <- paste(buyer, " Web Products",".csv",sep = "")
      
      column.list <-c(1,2,6,7,8,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51)


      product.list <- subset(web.product.data,web.product.data$`Asst Buyer`== buyer)
      product.list <- product.list[column.list]
      product.list <- product.list[order(product.list[1]),]
      
      write.csv(product.list,product.list.name,row.names = FALSE)
      
      }

}

#  Outputs each Supplier's articles

output.supplier.lists <- function() {
      
      all.suppliers <- unique(web.product.data$Supplier)
      
      for (i in 1:length(all.suppliers)) {
            
            supplier <- all.suppliers[i]
            product.list.name <- paste(supplier, " Web Products",".csv",sep = "")
            
            column.list <- c(1,2,6,7,8,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51)
            
            product.list <- subset(web.product.data,web.product.data$Supplier == supplier)
            product.list <- product.list[column.list]
            product.list <- product.list[order(product.list[1]),]
            
            #--Remove any columns that are all NA
            product.list <- product.list[,colSums(is.na(product.list)) < nrow(product.list)]
            
            write.csv(product.list,product.list.name,row.names = FALSE)
            
      }
      
}


#  Outputs each Brand's articles

output.brand.lists <- function() {
      
      all.brands <- unique(web.product.data$Brand)
      
      for (i in 1:length(all.brands)) {
            
            brand <- all.brands[i]
            product.list.name <- paste(brand, " Web Products",".csv",sep = "")
            
            column.list <- c(1,2,6,7,8,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51)
            
            product.list <- subset(web.product.data,web.product.data$Brand == brand)
            product.list <- product.list[column.list]
            product.list <- product.list[order(product.list[1]),]
            
            #--Remove any columns that are all NA
            product.list <- product.list[,colSums(is.na(product.list))<nrow(product.list)]
            
            write.csv(product.list,product.list.name,row.names = FALSE)
            
      }
      
}


#  Outputs Web Category lists

output.web.cat.lists <- function() {
      
      all.categories <- unique(web.product.data$`Web Category`)
      
      for (i in 1:length(all.categories)) {
            
            category <- all.categories[i]
            product.list.name <- paste(category, ".csv",sep = "")
            
            column.list <- c(1,2,6,7,36,37,38,39,40,41,42,43,44,45,46,47,48,49,53)
            
            product.list <- subset(web.product.data,web.product.data$`Web Category` == category)
            product.list <- product.list[column.list]
            product.list <- product.list[order(product.list[1]),]
            
            #--Remove any columns that are all NA
            product.list <- product.list[,colSums(is.na(product.list))<nrow(product.list)]
            
            #dir.create(product.list.name,showWarnings = FALSE)
            #setwd(product.list.name)
            write.csv(product.list,product.list.name,row.names = FALSE)
            #setwd("..")
      }
      
}


#  Outputs articles with missing web descriptions by PSA1 

output.psa1.missing.web.lists <- function() {
      
      all.psa1 <- unique(web.product.data$PSA_1)
      
      for (i in 1:length(all.psa1)) {
            
            psa1 <- all.psa1[i]
            
            column.list <- c(1,2,4:9,12)
            
            product.list <- subset(web.product.data,web.product.data$'PSA_1' == psa1 && web.product.data$`Web Description 1`=="" )
            product.list <- product.list[column.list]
            product.list <- product.list[order(product.list[1]),]
            
            cases <- NROW(product.list)
            product.list.name <- paste(psa1, " Missing 100 Character Description", " - (",cases," Articles)",".csv",sep = "")
            
            write.csv(product.list,product.list.name,row.names = FALSE)
            
      }
      
}

output.web.dq.reports <- function() {
      
      all.categories <- unique(web.product.data$`Web Category`)
      attribute.list <- c("Brand","Size","Colour","Pack Qty","Material","Assembly","Washable","Power","Capacity","Coverage","Age","Model Number")
      web.product.data <- web.product.data[order(web.product.data$'Brand'),]
      
      for (i in 1:length(all.categories)) {
            
            category <- all.categories[i]
            message(category)
            dir.create(category,showWarnings = FALSE)
            setwd(category)
            
#  Create Output file for products in category that currently score 100%
            
            web.complete <- subset(web.product.data,web.product.data$`DQ Score` == 100 & web.product.data$`Web Category` == category)
            web.complete$'Web Description' <- paste(web.complete[,4],web.complete[,5], sep = "")
            column.list <- c("Article","Web Description",attribute.list,"DQ Score")
            web.complete <- web.complete[column.list]
            
            # Remove any columns that are all NA
            web.complete <- web.complete[,colSums(is.na(web.complete)) < nrow(web.complete)]
            
            # Create the output file
            
            cases <- NROW(web.complete)
            if(NROW(web.complete) >0) write.csv(web.complete,paste(category, " Complete"," (",cases," Articles)",".csv",sep = ""),row.names = FALSE)
            
#  Create Output file for products in category that are missing a Web Description
            
            web.missing.description <- subset(web.product.data, is.na(web.product.data$`DQ Web Description Score`) & web.product.data$`Web Category` == category)
            column.list <- c("Article","Article Description","Web Description 1", "Web Description 2","DQ Score")
            web.missing.description <- web.missing.description[column.list]
            
            # Remove any columns that are all NA and sort by Brand
            cases <- NROW(web.missing.description)
            web.missing.description <- web.missing.description[,colSums(is.na(web.missing.description)) < nrow(web.missing.description)]
            if(NROW(web.missing.description) > 0) write.csv(web.missing.description,paste(category, " Missing Description"," (",cases," Articles)",".csv",sep = ""), row.names = FALSE)

            
#  Create Output file for products in category that are missing Product Attribute values
             
            web.missing.attribute <- subset(web.product.data, web.product.data$`DQ Attribute Score` < 3.5 & web.product.data$`Web Category` == category)
            web.missing.attribute$'Web Description' <- paste(web.missing.attribute[,4],web.missing.attribute[,5], sep = "")
            attribute.list <- subset(web.attribute$Attribute,web.attribute$Category == category)
            column.list <- c("Article","Web Description",attribute.list,"DQ Score")
            web.missing.attribute <- web.missing.attribute[column.list]

            # Remove any columns that are all NA and sort by Brand
            cases <- NROW(web.missing.attribute)
            #web.missing.attribute <- web.missing.attribute[,colSums(is.na(web.missing.attribute)) < nrow(web.missing.attribute)]

            if(NROW(web.missing.attribute) > 0) write.csv(web.missing.attribute,paste(category, " Missing Attribute"," (",cases," Articles)",".csv",sep = ""), row.names = FALSE)

#  Create Output file for products in category that have inconsistent branding
            
            web.inconsistent.brand <- subset(web.product.data, web.product.data$`DQ Brand Consistency Score` == - 0.5 & !is.na(web.product.data$`DQ Web Description Score`) & web.product.data$`Web Category` == category)
            web.inconsistent.brand$'Web Description' <- paste(web.inconsistent.brand[,4],web.inconsistent.brand[,5], sep = "")
            column.list <- c("Article","Web Description","Brand","DQ Score")
            web.inconsistent.brand <- web.inconsistent.brand[column.list]
            
            # Remove any columns that are all NA and sort by Brand
            cases <- NROW(web.inconsistent.brand)
            #web.inconsistent.brand <- web.inconsistent.brand[,colSums(is.na(web.inconsistent.brand)) < nrow(web.inconsistent.brand)]
            
            if(NROW(web.inconsistent.brand) > 0) write.csv(web.inconsistent.brand,paste(category, " Inconsistent Brand"," (",cases," Articles)",".csv",sep = ""), row.names = FALSE)         
            
            
            setwd("..")

                 
      }
      
}


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