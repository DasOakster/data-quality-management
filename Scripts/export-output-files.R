      
export.files <- function() {

# Exports thw data quality management reports
      
      setwd("..")
      setwd("./Output Files")
      
# Output the lists of unmatched web skus and web skus with missing web descriptions
      
      message("Outputting Web Product File")
      setwd("./Data Processing")
      write.csv(web.product.data,"Web Product File.csv",row.names = FALSE)
      write.csv(unmatched,"Unmatched Web Articles.csv",row.names = FALSE)
      write.csv(undefined.web.category,"Undefined Web Category.csv",row.names = FALSE)
      setwd("..")
      
      message("Outputting Missing Web Descriptions")
      setwd("./Missing Web Description")
      output.psa1.missing.web.lists()
      setwd("..")
      
      message("Outputting Buyer Lists")
      setwd("./Assistant Buyer")
      output.buyer.lists()
      setwd("..")
      
      message("Outputting Supplier Lists")
      setwd("./Supplier")
      output.supplier.lists()
      setwd("..")
      
      message("Outputting Brand Lists")
      setwd("./Brand")
      output.brand.lists()
      setwd("..")
      
      message("Outputting Web Category Lists")
      setwd("./Web Category")
      output.web.dq.reports()
      setwd("..")
      
      message("Outputting Report Data")
      setwd("..")
      setwd("./Reports/Report Data Files")
      
      asst.buyer <- asst.buyer[order(-asst.buyer$`Avg Data Quality Score`),]
      psa1.rank <- psa1.rank[order(-psa1.rank$`Avg Data Quality Score`),]
      psa2.rank <- psa2.rank[order(-psa2.rank$`Avg Data Quality Score`),]
      
      write.csv(psa1.rank,"PSA1 Data Quality Ranking.csv", row.names = FALSE)
      write.csv(psa2.rank,"PSA2 Data Quality Ranking.csv", row.names = FALSE)
      write.csv(asst.buyer,"Assistant Buyer Data Quality Ranking.csv", row.names = FALSE)
}