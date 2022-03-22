
MM_cgraph <- function(modelfile, nodelfile, figurename) { 
  
  Grand_Banks <- read.csv2(modelfile,as.is=TRUE, dec=".", row.names=1)
  
  SNS_nodes <-  read.csv2(nodefile, dec=".")
  nnodes <- data.table::as.data.table(SNS_nodes)
  
  Grand_Banks_edges <- data.matrix(Grand_Banks)
  colnames(Grand_Banks_edges) <- row.names(Grand_Banks)
  
  activity <- c(nnodes[category=="activity"]$node)
  management <- c(nnodes[category=="management"]$node)
  objective <- c(nnodes[category=="objective"]$node)
  ecosyst <- c(nnodes[category=="ecosyst"]$node)
  pressure <- c(nnodes[category=="pressure"]$node)
  
  #GB_C <- brewer.pal(5,"Set1")
  
  #GB_Colors <- data.frame(row.names(Grand_Banks_edges))
 # colnames(GB_Colors) <- "Focus"
 # GB_Colors$Color <- GB_C[2]
  #  GB_Colors$Color[GB_Colors$Focus%in%activity] <- GB_C[5]
 #   GB_Colors$Color[GB_Colors$Focus%in%management] <- GB_C[4]
   # GB_Colors$Color[GB_Colors$Focus%in%objective] <- GB_C[1]
  #  GB_Colors$Color[GB_Colors$Focus%in%ecosyst] <- GB_C[3]
    
    #updated
    GB_C <- brewer.pal(5,"Set1")
    
    GB_Colors <- data.frame(row.names(Grand_Banks))
    colnames(GB_Colors) <- "Focus"
    GB_Colors$Color <- GB_C[2]
    #GB_Colors$Color[GB_Colors$Focus%in%socioeco] <- GB_C[2]
    
    GB_Colors$Color[GB_Colors$Focus%in%activity] <- GB_C[5]
    GB_Colors$Color[GB_Colors$Focus%in%management] <- GB_C[4]
    GB_Colors$Color[GB_Colors$Focus%in%objective] <- GB_C[1]
    GB_Colors$Color[GB_Colors$Focus%in%ecosyst] <- GB_C[3]
  
  
    Grand_Banks_edges <- cbind(Grand_Banks_edges,GB_Colors)
    GB_Colors <- GB_Colors[order(GB_Colors$Color,GB_Colors$Focus),]
    Grand_Banks_edges <-  Grand_Banks_edges[order( Grand_Banks_edges$Color,Grand_Banks_edges$Focus),]
    GB_Colors <- matrix(GB_Colors$Color,dimnames=list(GB_Colors$Focus,"Color"))
    Grand_Banks_edges <- cbind(Grand_Banks_edges,GB_Colors)
    Grand_Banks_edges <- Grand_Banks_edges[order(Grand_Banks_edges$Color,row.names(Grand_Banks_edges)),]
  
    Grand_Banks_edges$Color <- NULL
    Grand_Banks_edges$Color <- NULL
    Grand_Banks_edges$Focus <- NULL
  
  
    Grand_Banks_edges <- data.matrix(Grand_Banks_edges)
    Border_mat <- matrix(1,nrow=nrow(Grand_Banks_edges),ncol=ncol(Grand_Banks_edges))
      rownames(Border_mat) <- rownames(Grand_Banks_edges)
      colnames(Border_mat) <- colnames(Grand_Banks_edges)
    Border_Col <- matrix("white",nrow=nrow(Grand_Banks_edges),ncol=ncol(Grand_Banks_edges))
    rownames(Border_Col) <- rownames(Grand_Banks_edges)
    colnames(Border_Col) <- colnames(Grand_Banks_edges)
    
    Border_w <- matrix(.0001,nrow=nrow(Grand_Banks_edges),ncol=ncol(Grand_Banks_edges))
    rownames(Border_w) <- rownames(Grand_Banks_edges)
    colnames(Border_w) <- colnames(Grand_Banks_edges)
    
    #pdf(paste(figurename, ".pdf", sep=""),width = 6.69291, height=6.69291)
    png(paste(figurename, ".png", sep=""),width = 1400, height=1400)
   print(chordDiagram(Grand_Banks_edges, directional=1, direction.type = c("diffHeight", "arrows"), link.arr.type = "big.arrow",scale=TRUE,
                      transparency = 0.6,
                   grid.col = GB_Colors,
                   row.col = GB_Colors,
                   link.lty = Border_mat,
                   link.lwd = Border_w,
                   link.border = Border_Col,
                   annotationTrackHeight = c(0.03, 0.1),
                   annotationTrack="grid",preAllocateTracks= list(track.height=0.4)))
   
   
      print(circos.trackPlotRegion(track.index=1, panel.fun= function (x,y){
          xlim = get.cell.meta.data("xlim")
          ylim = get.cell.meta.data("ylim")
          sector.name = get.cell.meta.data("sector.index")
          circos.text(mean(xlim),ylim[1],sector.name,facing="clockwise", niceFacing=TRUE, adj =c(0,0.5), cex=2.2)
        }, bg.border=NA) )
      
      print(legend(x=-1.1,y = 1.09,legend = c("Objectives","Pressure","Ecosystem","Activities","Management"),lty= c(1,1,1,1,1), lwd=c(15,15,15,15,15), 
             col =c(GB_C[1],GB_C[2],GB_C[3],GB_C[5],GB_C[4]), ncol=1, cex = 2.5, bg = NULL, box.col=NULL, bty = "n"))
      #print(title(main="Grand Banks", line=-35))

dev.off()

} 
    