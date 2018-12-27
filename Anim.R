---
  title: "Animated Histogram using Plotly"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

library(plotly)
library(tweenr)

set.seed(12)
x <- round(rnorm(50, 10, 2))
df <- data.frame(x = x, y = 17)
dfs <- list(df)
for(i in seq_len(nrow(df))) {
  dftemp <- tail(dfs, 1)
  dftemp[[1]]$y[i] <- sum(dftemp[[1]]$x[seq_len(i)] == dftemp[[1]]$x[i])
  dfs <- append(dfs, dftemp)
}
dfs <- append(dfs, dfs[rep(length(dfs), 3)])
dft <- tween_states(dfs, 10, 1, 'cubic-in', 600)
dft$y <- dft$y - 0.5
dft <- dft[dft$y != 17, ]
dft$type <- 'Animate'

p <- dft %>%
  plot_ly(
    x = ~x, 
    y = ~y,
    frame = ~.frame, 
    marker = list(size = 20,
                  color = 'rgba(250, 180, 70, .9)',
                  line = list(color = 'rgba(152, 0, 0, .8)',
                              width = 4))
  ) %>% 
  layout(
    xaxis = list(range=c(3,17),
                 title = "Teacup Giraffe heights",
                 zeroline = F
    ),
    yaxis = list(range=c(-0.5,15),
                 title = "Frequency",
                 zeroline = F
    )
  ) %>% 
  animation_opts(
    frame = 30, 
    transition = 0, 
    redraw = FALSE
  ) %>%
  animation_slider(
    hide = T
  ) %>%
  animation_button(
    x = 1, xanchor = "right", y = 0, yanchor = "bottom"
  )
p
htmltools::save_html(p, file="flea_anim.html")
```
<div style="margin-bottom:50px;">
  </div>
  <center>
  <iframe src="flea_anim.html" width="600" height="550" scrolling="yes" seamless="seamless" frameBorder="0"> </iframe>