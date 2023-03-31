
library(tidyverse)
#install.packages("remotes")
#remotes::install_github("davidsjoberg/ggsankey")
library(ggsankey)

#Just goofing around here trying to see how the df needs to be ######
#example taken from: https://rpubs.com/techanswers88/sankey-with-own-data-in-ggplot
# Create a data frame with the data for the Sankey diagram
set.seed(111)

# Create the data 
t1 <- sample(x = c("Hosp A", "Hosp B", "Hosp C","Hosp D") , size = 100, replace=TRUE)
t2 <- sample(x = c("Male", "Female")   , size = 100, replace=TRUE)
t3 <- sample(x = c("Survived", "Died") , size = 100, replace=TRUE)

d <- data.frame(cbind(t1,t2,t3))
names(d) <- c('Hospital', 'Gender',  'Outcome')

head(d)

#Transform the df
df <- d %>%
  make_long(Hospital, Gender, Outcome)
df
# Chart 1
pl <- ggplot(df, aes(x = x
                     , next_x = next_x
                     , node = node
                     , next_node = next_node
                     , fill = factor(node)
                     , label = node)
)
pl <- pl +geom_sankey(flow.alpha = 0.5
                      , node.color = "black"
                        ,show.legend = FALSE)
pl <- pl +geom_sankey_label(size = 3, color = "black", fill= "white", hjust = -0.5)
pl <- pl +  theme_bw()
pl <- pl + theme(legend.position = "none")
pl <- pl +  theme(axis.title = element_blank()
                  , axis.text.y = element_blank()
                  , axis.ticks = element_blank()  
                  , panel.grid = element_blank())
pl <- pl + scale_fill_viridis_d(option = "inferno")
pl <- pl + labs(title = "Sankey diagram using ggplot")
pl <- pl + labs(subtitle = "using  David Sjoberg's ggsankey package")
pl <- pl + labs(caption = "@techanswers88")
pl <- pl + labs(fill = 'Nodes')
pl



##Now with our own data... let's see #########
#Load Data #
data <- read.csv("SharkBibliometricData.csv")
Sankeydata <- subset(data, select=c("Área.de.Estudio", "Especie", "Método", "Tema", "Publication.Year"))

#Gráfica de Area de estudio, Metodo, Tema
Sandat <- Sankeydata %>%
  make_long(Área.de.Estudio, Método, Tema)
head(Sandat)

###Cuando corro la gráfica, hay una porción del Sankey completamente negra, 
# asumo que esos son los valores de NAs pero no tengo idea de como quitarlos o 
#intentar asignarlos como 0s para ver que pasa. ¿Qué se te ocurre? 

#Sandat[(is.na(Sandat))]=0
#head(Sandat)

#Graph 
pl <- ggplot(Sandat, aes(x = x
                     , next_x = next_x
                     , node = node
                     , next_node = next_node
                     , fill = factor(node)
                     , label = node)
)
pl <- pl +geom_sankey(flow.alpha = 0.5
                      , node.color = "black"
                        ,show.legend = FALSE)
pl <- pl +geom_sankey_label(size = 3, color = "black", fill= "white", hjust = -0.5)
pl <- pl +  theme_bw()
pl <- pl + theme(legend.position = "none")
pl <- pl +  theme(axis.title = element_blank()
                  , axis.text.y = element_blank()
                  , axis.ticks = element_blank()  
                  , panel.grid = element_blank())
pl <- pl + scale_fill_viridis_d(option = "inferno")
pl

#Gráfica de Año de Publicación, Temática, Métodos
Sansan <- Sankeydata %>%
  make_long(Publication.Year, Tema, Método)
head(Sansan)

###Cuando corro la gráfica, hay una porción del Sankey completamente negra, 
# asumo que esos son los valores de NAs pero no tengo idea de como quitarlos o 
#intentar asignarlos como 0s para ver que pasa. ¿Qué se te ocurre? 

#Sandat[(is.na(Sandat))]=0
#head(Sandat)

#Graph 
plo <- ggplot(Sansan, aes(x = x
                         , next_x = next_x
                         , node = node
                         , next_node = next_node
                         , fill = factor(node)
                         , label = node)
)
plo <- plo +geom_sankey(flow.alpha = 0.5
                      , node.color = "black"
                        ,show.legend = FALSE)
plo <- plo +geom_sankey_label(size = 3, color = "black", fill= "white", hjust = -0.5)
plo <- plo +  theme_bw()
plo <- plo + theme(legend.position = "none")
plo <- plo +  theme(axis.title = element_blank()
                  , axis.text.y = element_blank()
                  , axis.ticks = element_blank()  
                  , panel.grid = element_blank())
plo <- plo + scale_fill_viridis_d(option = "inferno")
plo

#Yo sé, yo sé que se ve horrenda... pero ¿cómo podemos agrupar los años?
 #  