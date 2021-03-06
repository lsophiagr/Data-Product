
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
    
    output$grafica_base_r <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,xlab="wt",ylab="Miles/Galon")
    })
    
    output$grafica_ggplot <- renderPlot({
        diamonds %>% 
            ggplot(aes(x=carat,y=price, color=color))+
            geom_point()+
            ylab("Precio")+
            xlab("Kilates")+
            ggtitle("Precio diamantes")
    })
    
    
    output$click_base_plot <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,xlab="wt",ylab="Miles/Galon")
        
    })
    
    output$click_base_plot_xy <- renderPrint({
        c(input$plot_click$x, input$plot_click$y)
    })
    
    
    output$click_ggplot <- renderPlot({
        diamonds %>% 
            ggplot(aes(x=carat,y=price, color=color))+
            geom_point()+
            ylab("Precio")+
            xlab("Kilates")+
            ggtitle("Precio diamantes")
    })
    
    output$ggplot_click_xy <- renderPrint({
        c(input$ggplot_click$x, input$ggplot_click$y)
    })
    
    output$plot_click_option <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,xlab="wt",ylab="Miles/Galon") 
    })
    
    
    output$all_click_options <- renderPrint({
        if(!is.null(input$clk$x)){
            click <- paste0(c('(',round(input$clk$x,2),',',round(input$clk$y,2),')'),collapse = '')
            click <- paste0("Coordenada del click : ", click,collapse='')
        } else {click<-NULL}
        
        
        if(!is.null(input$dblclick$x)){
            dblclick <- paste0(c('(',round(input$dblclick$x,2),',',round(input$dblclick$y,2),')'),collapse = '')
            dblclick <- paste0("Coordenada del doble click : ", dblclick,collapse='')
            
        } else{dblclick<-NULL}
        
        
        if(!is.null(input$hover$x)){
            hover <- paste0(c('(',round(input$hover$x,2),',',round(input$hover$y,2),')'),collapse = '')
            hover <- paste0("Coordenada del cursor : ", hover,collapse='')
            
        } else {hover=NULL}
        
        
        if(!is.null(input$brush$xmin)){
            brushx <- paste0(c('(',round(input$brush$xmin,2),',',round(input$brush$xmax,2),')'),collapse = '')
            brushy <- paste0(c('(',round(input$brush$ymin,2),',',round(input$brush$ymax,2),')'),collapse = '')
            brush <- cat('\t rango en x: ', brushx,'\n','\t rango en y: ', brushy)
            
        } else {brush<-NULL}
        
        cat( click,dblclick,hover,brush,sep = "\n" )
    })
    
    output$plot <- renderPlot({
        color <- rep("black",length(mtcars$wt))
        mtcars$color <- color
        mtcars$id <- c(1:32)
        plot(mtcars$wt, mtcars$mpg, xlab="Weight", ylab="Miles/gallon") 
    })
    
    output$one <- renderPrint({
        brushedPoints(mtcars, input$plot_brush, xvar = "wt", yvar = "mpg")
        
    })
    
    output$multiple <- renderPrint({
        var = nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = "mpg")
        mtcars$color[mtcars$id == var$id] = 'red'
        paste0(var)
    })
    
    output$one <- renderPrint({
        brushedPoints(mtcars, input$plot_brush, xvar = "wt", yvar = "mpg")
        
    })
    
})
