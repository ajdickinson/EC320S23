pacman::p_load(hrbrthemes, fastverse, tidyverse,
               magrittr, wooldridge, here, kableExtra,
               ggdag, nord, latex2exp, dagitty, viridis,
               emoGG)


hi = nord_palettes$polarnight[3]
hii = nord_palettes$frost[3] 
hp = nord_palettes$aurora[5]
higreen = nord_palettes$aurora[4]
hiorange = nord_palettes$aurora[2]
hired = nord_palettes$aurora[1]
higrey = nord_palettes$snowstorm[1]

mytheme = theme_ipsum(base_family = "Fira Sans Book", base_size = 20) +
 theme(panel.grid.minor.x = element_blank(),
       axis.title.x = element_text(size = 18),
       axis.title.y = element_text(size = 18))

mytheme_s = mytheme + 
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.line = element_line(color = hi))

data <- get(data(campus)) %>% 
  mutate(crime = round(crime/enroll*1000, 2),
         police = round(police/enroll*1000, 2)) %>% 
  filter(police < 10) %>% # remove outlier
  select(crime, police)

data2 <- get(data(campus)) %>% 
  mutate(crime = round(crime/enroll*1000, 2),
         police = round(police/enroll*1000, 2)) %>% 
  select(crime, police)


y_hat <- function(x, b0, b1) {b0 + b1 * x}
# Define line's parameters
b0 <- 60
b1 <- -7

b0_range = c(-10, 60)
b1_range = c(-10, 10)

b0_v = runif(1e5, b0_range[1], b0_range[2]) %>% as.list()
b1_v = runif(1e5, b1_range[1], b1_range[2]) %>% as.list()

rss_sim = parallel::mcmapply(FUN = function(x,y) {

    # Calculate residuals
    resid = data$crime - y_hat(data$police, x, y)
    # Square residuals
    resid_sq = resid^2
    # Sum for RSS
    rss = fsum(resid_sq)
    # Create data.table of parameters + rss
    dt = data.table(
      b0 = x,
      b1 = y,
      rss = rss)
    # Return data.table list
    return(dt)

    }, b0_v, b1_v, SIMPLIFY = FALSE, mc.cores = 6
  ) %>% rbindlist()

setorder(rss_sim, rss)
rss_sim[, rank := .I]

min_point <- rss_sim[1]


grid_size <- 100
b0_range <- seq(min(rss_sim$b0), max(rss_sim$b0), length.out = grid_size)
b1_range <- seq(min(rss_sim$b1), max(rss_sim$b1), length.out = grid_size)
b0_b1_grid <- expand.grid(b0 = b0_range, b1 = b1_range)

b0_b1_grid$z <- min_point$rss

# ggplot(data = rss_df, aes(x = b0, y = b1)) +
#   geom_point


plot_ly(
  type = "scatter3d",
  x = rss_sim$b1,
  y = rss_sim$b0,
  z = rss_sim$rss,
  mode = "markers",
  size = 1,
  color = rss_sim$rank,
  colors = colorRamp(viridis::magma(8) %>% rev()),
) %>%
layout(scene = list(
  yaxis = list(title = "b0", range = b0_range),
  xaxis = list(title = "b1", range = b1_range),
  zaxis = list(title = "RSS", range = c(0, 400000))
)) %>% hide_colorbar()


plot_ly(
  type = "scatter3d",
  x = rss_sim$b1,
  y = rss_sim$b0,
  z = rss_sim$rss,
  mode = "markers",
  size = 1,
  color = rss_sim$rank,
  colors = colorRamp(viridis::magma(8) %>% rev()),
) %>%
  add_trace(
    type = "surface",
    x = b1_range,
    y = b0_range,
    z = matrix(b0_b1_grid$z, nrow = grid_size, ncol = grid_size),
    surfacecolor = matrix(higrey, nrow = grid_size, ncol = grid_size),  # Set the color of the plane
    opacity = 0.5,
    name = "Optimal plane"
  ) %>%
  layout(scene = list(
  yaxis = list(title = "b0", range = b0_range),
  xaxis = list(title = "b1", range = b1_range),
  zaxis = list(title = "RSS", range = c(0, 400000))
)) %>% hide_colorbar()
