
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyUI(
  navbarPage("MRTA - Prostate RNA-Seq expression",
  tabPanel("T1",
  
  fluidRow(
    h3("EMP EdgeR Differential Expression"),
    column(1, selectInput("SEMT0_SEEMT3", "S0 v SE3", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SEMT0_SEEMT3))))),
    column(1, selectInput("SEEMT3_SEEMT5", "SE3 v SE5", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SEEMT3_SEEMT5))))),
    column(1, selectInput("SEEMT5_SMET3", "SE5 v M3", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SEEMT5_SMET3))))),
    column(1, selectInput("SMET3_SMET5", "M3 v M5", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SMET3_SMET5))))),
    column(1, selectInput("SMET5_SMET10", "M5 v M10", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SMET5_SMET10))))),
    column(1, selectInput("SMET10_SMET20", "M10 v M20", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$SMET10_SMET20)))))
    
    
  ),
  fluidRow(
    h3("EMP PCA gene contribution"),
    column(1, selectInput("PC1_EarlyEMT", "PC1: Early EMT", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC1_EarlyEMT))))),
    column(1, selectInput("PC2_EarlyMET", "PC2: Early MET", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC2_EarlyMET))))),
    column(1, selectInput("PC3_LateMET", "PC3: Late MET", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC3_LateMET))), selected = "1"))
    
  ),
  fluidRow(
    h3("ATT1 Differential Expression & PCA contribution"),
    column(1, selectInput("BIC_ENZ", "Bic v Enz", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$BIC_ENZ))))),
    column(1, selectInput("Treat_DHTeffect", "Bic&Enz + DHT v w/oDHT", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$Treat_DHTeffect))))),
    column(1, selectInput("BIC_N", "Bic v N(DHT&EtOH)", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$BIC_N))))),
    column(1, selectInput("ENZ_N", "Enz v N(DHT&EtOH)", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$ENZ_N))))),
    column(1, selectInput("PC1_DHT", "PC1: DHT", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC1_DHT))))),
    column(1, selectInput("PC2_ENZ_BIC", "PC2: ENZvBIC", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC2_ENZ_BIC))))),
    column(1, selectInput("PC3_ETOH", "PC3: ETOH", 
                          c("All", unique(as.character(lncRNAs_expressed_EMP1_ATT1$PC3_ETOH)))))
    
  ),
  
  
  fluidRow(
    h3("Show expression in:"),
    column(3, 
           checkboxGroupInput("checkGroupE",label="",
                              
                              choices=list("EMP S0" = 1, 
                                          "EMP SE3" = 2, 
                                          "EMP SE5" = 3,
                                          "EMP M3" = 4,
                                          "EMP M5" = 5,
                                          "EMP M10" =6,
                                          "EMP M20" = 7),
                              selected = c(1,2,3,4,5,6,7))),
    column(3, 
           checkboxGroupInput("checkGroupA",
                              label="",
                              choices=list("ATT BIC" = 8, 
                                           "ATT BIC-DHT" = 9, 
                                           "ATT ENZ" = 10,
                                           "ATT ENZ-DHT" = 11,
                                           "ATT DHT" = 12,
                                           "ATT ETOH" =13),
                              selected = c(8:13)))
  ),
  
  fluidRow(
    column(6,
    dataTableOutput(outputId="table"))
  ),
  fluidRow(
    column(6, plotOutput("plot1")),
    column(6, plotOutput("plot3")),
    column(6, plotOutput("plot2")),
    column(6, plotOutput("plot4"))
  )
  ),
  tabPanel("T2")
  )
  )

