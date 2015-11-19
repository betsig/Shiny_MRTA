library(reshape2)
library(shiny)
library(pheatmap)
library(stringr)
lncRNAs_expressed_EMP1_ATT1 <- read.csv("data/lncRNAs_expressed_EMP1_ATT1.csv", stringsAsFactors=FALSE)
rownames(lncRNAs_expressed_EMP1_ATT1) <- lncRNAs_expressed_EMP1_ATT1$X

filterTableGene=function(table,input){
  data <- table
  if(input$SEMT0_SEEMT3 !="All"){
    data <- data[data$SEMT0_SEEMT3 == input$SEMT0_SEEMT3,]
  }
  if(input$SEEMT3_SEEMT5 !="All"){
    data <- data[data$SEEMT3_SEEMT5 == input$SEEMT3_SEEMT5,]
  }
  if(input$SEEMT5_SMET3 !="All"){
    data <- data[data$SEEMT5_SMET3 == input$SEEMT5_SMET3,]
  }
  if(input$SMET3_SMET5 !="All"){
    data <- data[data$SMET3_SMET5 == input$SMET3_SMET5,]
  }
  if(input$SMET5_SMET10!="All"){
    data <- data[data$SMET5_SMET10 == input$SMET5_SMET10,]
  }
  if(input$SMET10_SMET20 !="All"){
    data <- data[data$SMET10_SMET20 == input$SMET10_SMET20,]
  }
  
  if(input$PC1_EarlyEMT !="All"){
    data <- data[data$PC1_EarlyEMT == input$PC1_EarlyEMT,]
  }
  if(input$PC2_EarlyMET !="All"){
    data <- data[data$PC2_EarlyMET == input$PC2_EarlyMET ,]
  }
  if(input$PC3_LateMET!="All"){
    data <- data[data$PC3_LateMET == input$PC3_LateMET,]
  }
  
  if(input$BIC_ENZ!="All"){
    data <- data[data$BIC_ENZ == input$BIC_ENZ,]
  }
  if(input$Treat_DHTeffect!="All"){
    data <- data[data$Treat_DHTeffect == input$Treat_DHTeffect,]
  }
  if(input$BIC_N!="All"){
    data <- data[data$BIC_N == input$BIC_N,]
  }
  if(input$ENZ_N!="All"){
    data <- data[data$ENZ_N == input$ENZ_N,]
  }
  if(input$PC1_DHT!="All"){
    data <- data[data$PC1_DHT == input$PC1_DHT,]
  }
  if(input$PC2_ENZ_BIC!="All"){
    data <- data[data$PC2_ENZ_BIC == input$PC2_ENZ_BIC,]
  }
  if(input$PC3_ETOH!="All"){
    data <- data[data$PC3_ETOH == input$PC3_ETOH,]
  }
  return(data)
}
filterTableCond=function(table,input){
  data <- table
  df=data.frame(colN=colnames(data)[2:29], selection=c(0,0,0,0,0,0,1,1,0,0,2,2,3,3,6,6,7,7,4,4,5,5,9,8,12,11,10,13))
  df=arrange(df, selection)
  keep=c(input$checkGroupE, input$checkGroupA)
  selected=as.character(df$colN[df$selection %in% keep])
  data[,match(selected, colnames(data))]
}



shinyServer(function(input, output){

  output$table <- renderDataTable({
    data <- filterTableGene(lncRNAs_expressed_EMP1_ATT1, input)
    data[,c(46:48)]
  })
  
  output$plot1 <- renderPlot({
    data <- filterTableGene(lncRNAs_expressed_EMP1_ATT1, input)
    data <- filterTableCond(data, input)
    condition <- unique(str_sub(colnames(data), 1,-3))
    condition <- condition[grep("EMP", condition)]
    for(i in 1:length(condition)){
      mean_expr=rowMeans(data[,grep(condition[i], colnames(data))])
      if(i !=1){
        df2=cbind(df2, mean_expr)
      }else{
        df2=data.frame(mean_expr=mean_expr)
      }
    }
    colnames(df2) <- condition
    
    df=cbind(df2, gene_id=rownames(data))
    
    df_m=melt(df, id.vars = "gene_id")
    ggplot(df_m, aes(x=variable, y=value, group=gene_id,col=gene_id)) + geom_line()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$plot3 <- renderPlot({
    data <- filterTableGene(lncRNAs_expressed_EMP1_ATT1, input)
    data <- filterTableCond(data, input)
    data=data[,-grep("EMP", colnames(data))]
    df=cbind(data, gene_id=rownames(data))
    
    df_m=melt(df, id.vars = "gene_id")
    ggplot(df_m, aes(x=variable, y=value, group=gene_id,col=gene_id)) + geom_line()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  output$plot2 <- renderPlot({
    data <- filterTable(lncRNAs_expressed_EMP1_ATT1, input)
    data <- filterTableCond(data, input)
    data=data[,grep("EMP", colnames(data))]
    pheatmap(data)  
  })
  
  output$plot4<- renderPlot({
    data <- filterTable(lncRNAs_expressed_EMP1_ATT1, input)
    data <- filterTableCond(data, input)
    data=data[,-grep("EMP", colnames(data))]
    pheatmap(data)  
  })
  
  
})
