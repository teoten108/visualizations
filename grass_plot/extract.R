library(XML)
library(stringr)
library(ggplot2)

doc <- htmlParse('coord_root')

## Extract the coordinates, as strings
p <- xpathSApply(doc, "//path", xmlGetAttr, "d")
## Remove excess of characters
p <- str_remove_all(p, '[MC]')

## Convert them to numbers
points <- lapply(strsplit(p, " "),
                 function(u) 
                     matrix(as.numeric(unlist(strsplit(u, ","))),
                            ncol=2,
                            byrow=TRUE) )

root <- as.data.frame(points)

shoot$part <- 'shoot'
root$part <- 'root'

grass <- rbind(root, shoot)

names(grass) <- c('y', 'x', 'part')


ggplot(grass, aes(x, y)) +
    geom_polygon(aes(fill = part))

write.table(grass, 'grass_coords.csv', sep = ',', row.names = F)
