---
  title: "Roulette Simulation"
author: "Aayan"
date: "2025-05-16"
output: 
  pdf_document:
  keep_tex: true
---
  knitr::opts_chunk$set(
    echo    = TRUE,
    warning = FALSE,
    message = FALSE
  )
set.seed(123)

# Parameters
p_win_american <- 18/38
n_spins1       <- 200

# Initialize wallet vector
wallet <- numeric(n_spins1 + 1)
wallet[1] <- 200

# Run simulation
for (i in seq_len(n_spins1)) {
  win <- runif(1) < p_win_american
  wallet[i + 1] <- wallet[i] + ifelse(win, +1, -1)
}

# Plot results
plot(
  wallet,
  type = "l",
  xlab = "Spin Number",
  ylab = "Wallet Balance ($)",
  main = "Wallet over 200 American Roulette Spins"
)
grid()


# European win probability
p_win_european <- 18/37

# Expected value per spin
ev  <- p_win_european * 1 + (1 - p_win_european) * (-1)

# Variance per spin = E[X^2] - (E[X])^2; here X=±1 so E[X^2]=1
var <- 1 - ev^2

cat(sprintf("Analytical EV per spin:     %.6f\n", ev))
cat(sprintf("Analytical variance per spin: %.6f\n", var))


n_spins2 <- 10000

# Simulate outcomes: +1 for win, -1 for loss
outcomes <- ifelse(runif(n_spins2) < p_win_european, 1, -1)

# Print simulated metrics
cat(sprintf("Simulated EV (mean profit):  %.6f\n", mean(outcomes)))
cat(sprintf("Simulated variance:           %.6f\n", var(outcomes)))

