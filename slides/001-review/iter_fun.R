my_fun <- function(dt) {
  dt[, s := 0]
  dt[sample(which(s == 0), 25), s := 1]

  list <- c(
    true_summ[group == "beer", mean],
    true_summ[group == "water", mean],
    true_summ[group == "beer", mean] - true_summ[group == "water", mean]
  ) |> round(2)

  return(list)
}

set.seed(987)

iter_fun <- function(iter) {
  # Sample 25 observations
  dt[, s := 0]
  dt[sample(which(s == 0), 25), s := 1]
  # Find mean of both groups and group differences
  summ <- dt[, .(mean = mean(count)), by = s]
  # Create list of means
  table <- data.table(
    i = iter,
    mu1 = summ[s == 1, mean],
    mu0 = summ[s == 0, mean],
    diff = summ[s == 1, mean] - summ[s == 0, mean]
  ) |> round(2)
  # Return list
  return(table)
}

sim_dt <- lapply(1:1e4, iter_fun) %>%
  rbindlist()


ggplot(data = sim_dt, aes(x = diff)) +
  geom_density()
