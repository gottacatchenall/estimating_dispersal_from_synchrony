library(tidyverse)
library(ggthemr)
lambda_vals = seq(1,50,by=0.5)
m_vals = seq(0,1, by=0.01)
lattice_size = length(m_vals)*length(lambda_vals)

df = data.frame(matrix(ncol=3, nrow=lattice_size)) 
colnames(df) = c("m", "lambda", "val")

row = 1
for (lambda in lambda_vals){
    for (m in m_vals){
        this_row = c(m, lambda, runif(1))
        df[row,] = this_row
        row = row + 1
        
    }
}


ggthemr(spacing=2)


NLMR::nlm_mpd(ncol = 50, nrow = 50, roughness = 0.2) %>% 
    rasterVis::gplot() + 
    geom_tile(aes(fill=value), color="#353945",size=0.8) +
    theme_minimal() + 
    theme(aspect.ratio=1.0, 
          panel.border = element_rect(fill=NA,color="#101010", size=3),
          
          ) + 
    scale_fill_gradientn(colors=c("#353945","#394d56", "#1fa9c6","#30ca96", "#f38844","#fc5e39")) +
    scale_y_continuous(expand = c(0,0)) + scale_x_continuous(expand = c(0,0))

