data("MASchools")

schools_dt = as.data.table(MASchools)

# Create group variable by student expenditure
schools_dt[exptot >= 6000, expgroup := TRUE]
schools_dt[exptot < 6000, expgroup := FALSE]
schools_dt[expgroup == TRUE, score4 := score4 + 30]
schools_dt = schools_dt[!(expgroup == TRUE & score4 < 722)]

ggplot(data = schools_dt, aes(x = stratio, y = score4)) +
  geom_point(color = hi) +
  labs(
    title = "Relationship between test scores and class size",
    subtitle = "Test scores are aggregated math, reading, and science scores among 4th graders",
    y = "Test scores",
    x = "Class size"
  ) +
  mytheme

ggplot(data = schools_dt, aes(x = stratio, y = score4, group = expgroup, color = expgroup)) +
  geom_point() +
  scale_color_manual(values = c(hp, hi), labels = c("Per student expenditure > $6,000", "Per student expenditure < $6,000")) +
  labs(
    title = "Relationship between test scores and class size",
    subtitle = "Test scores are aggregated math, reading, and science scores among 4th graders",
    y = "Test scores",
    x = "Class size",
    color = NULL
  ) +
  mytheme +
  theme(
    legend.position = c(0.8, 0.9),
    legend.text = element_text(size = 12),
    legend.background = element_rect(color = hi, size = 0.5)
  )

library(data.table)
library(ggplot2)
library(gganimate)

# Create the group means for each W
schools_dt[, `:=`(mean_stratio = mean(stratio), mean_score4 = mean(score4)), by = expgroup]

# Create six different data tables for the animation steps
dt_list <- list(
  #Step 1: Raw data only
  copy(schools_dt)[, c("mean_stratio", "mean_score4") := NA],
  #Step 2: Add x-lines
  copy(schools_dt)[, mean_score4 := NA],
  #Step 3: X de-meaned 
  copy(schools_dt)[, `:=`(stratio = stratio - mean_stratio, mean_stratio = 0, mean_score4 = NA)],
  #Step 4: Remove X lines, add Y
  copy(schools_dt)[, `:=`(stratio = stratio - mean_stratio, mean_stratio = NA)],
  #Step 5: Y de-meaned
  copy(schools_dt)[, `:=`(stratio = stratio - mean_stratio, score4 = score4 - mean_score4, mean_stratio = NA, mean_score4 = 0)],
  #Step 6: Raw demeaned data only
  copy(schools_dt)[, `:=`(stratio = stratio - mean_stratio, score4 = score4 - mean_score4, mean_stratio = NA, mean_score4 = NA)]
)

# Add time column and rbind all data tables together
time_labels <- c("1. Before correction", "2. Figure out what differences in stratio are explained by expgroup",
                 "3. Remove differences in stratio explained by expgroup", "4. Figure out what differences in score4 are explained by expgroup",
                 "5. Remove differences in score4 explained by expgroup", "6. After correction")

for (i in seq_along(dt_list)) {
  dt_list[[i]][, time := time_labels[i]]
}

# Combine all data tables into one
schools_dt_full <- rbindlist(dt_list)

# Create the animation
p <- ggplot(schools_dt_full, aes(x = stratio, y = score4, color = as.factor(expgroup))) +
  geom_point() +
  geom_vline(aes(xintercept = mean_stratio, color = as.factor(expgroup))) +
  geom_hline(aes(yintercept = mean_score4, color = as.factor(expgroup))) +
  guides(color = guide_legend(title = "expgroup")) +
  labs(title = 'The Relationship between score4 and stratio, Controlling for a Binary Variable expgroup \n{closest_state}') +
  transition_states(time, transition_length = 2, state_length = 1) +
  ease_aes('sine-in-out')

anim_save(
  animation = p,
  filename = "~/Desktop/control.gif",
  path = ".",  # change this to your desired directory
  width = 10.5,
  height = 7,
  units = "in",
  res = 150,
  nframes = 200
)

library(ggridges)

ggplot(data = schools_dt, aes(x = exptot, y = as.factor(cut(stratio, breaks = seq(11,24,1))))) +
    geom_density_ridges_gradient(
      aes(fill = ..x..),
      color = "white",
      scale = 2.5,
      size = 0.2
    ) +
    # geom_vline(xintercept = 0, alpha = 0.3) +
    scale_fill_viridis(option = "magma") +
    xlab("School funding") +
    ylab("Class size") +
    mytheme +
    theme(
      legend.position = "none",
      axis.title.y = element_text(vjust = 0.5, size = 22, color = hi),
      axis.title.x = element_text(size = 22, color = hi)
    )

library(microbenchmark) ## For high-precision timing
library(parallel)
library(parallelly)
n_cores = availableCores()


tictoc::tic()
mclapply(1:1e3, function(i) { 
      fit = coef(.lm.fit(x[, 1:(i + 1)], y)) 
      }, mc.cores = n_cores 
  )
tictoc::toc()

tictoc::tic()
mclapply(1:1e3, function(i) { 
        tmp_reg <- lm(y ~ x[,1:(i + 1)]) %>% summary()
        data.frame(
          k = i + 1,
          r2 = tmp_reg$r.squared,
          r2_adj = tmp_reg$adj.r.squared
          )
      }, mc.cores = n_cores 
  )
tictoc::toc()


microbenchmark(
  
  # sims_sequential = lapply(1:1e5, 
  #                          function(i) {
  #                           fit = coef(.lm.fit(x[, 1:(i + 1)], y))
  #                           }),

  # slow_sequential = lapply(1:1e5,
  #                          function(i) {
  #                           tmp_reg <- lm(y ~ x[,1:(i + 1)]) %>% summary()
                            
  #                           data.frame(
  #                             k = i + 1,
  #                             r2 = tmp_reg$r.squared,
  #                             r2_adj = tmp_reg$adj.r.squared
  #                             )
  #               })
  
  slow_parallel = mclapply(1:1e3, 
                           function(i) {
                            tmp_reg <- lm(y ~ x[,1:(i + 1)]) %>% summary()
                            data.frame(
                              k = i + 1,
                              r2 = tmp_reg$r.squared,
                              r2_adj = tmp_reg$adj.r.squared
                              )
                             }, 
                           mc.cores = n_cores
                           ),

  fast_parallel = mclapply(1:1e3, 
                        function(i) {
                            fit = coef(.lm.fit(x[, 1:(i + 1)], y))
                            },
                        mc.cores = n_cores
                        ),

  times = 1
  )