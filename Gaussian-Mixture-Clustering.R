library(mclust)
library(ggplot2)

set.seed(123)

# Part i: Simulate data
n <- 200
p <- 0.4
mu1 <- 0
mu2 <- -2
sigma1 <- 1
sigma2 <- 4

# Generate mixture data
component <- rbinom(n, 1, p)
data <- ifelse(component == 1,
               rnorm(n, mu1, sigma1),
               rnorm(n, mu2, sigma2))
true_cluster <- ifelse(component == 1, "Cluster 1", "Cluster 2")

# Plot histogram with true clusters
df <- data.frame(Value = data, Cluster = true_cluster)

ggplot(df, aes(x = Value, fill = Cluster)) +
  geom_histogram(aes(y = ..density..), bins = 30, position = "identity", alpha = 0.5) +
  labs(title = "Histogram of Simulated Data with True Clusters") +
  theme_minimal()

# Apply Mclust
mclust_fit <- Mclust(data, G = 2)
summary(mclust_fit)

# Add estimated clusters to data
df$EstimatedCluster <- factor(mclust_fit$classification)

# Plot histogram with estimated clusters
ggplot(df, aes(x = Value, fill = EstimatedCluster)) +
  geom_histogram(aes(y = ..density..), bins = 30, position = "identity", alpha = 0.5) +
  labs(title = "Histogram with Estimated Clusters (Mclust)") +
  theme_minimal()

# Part ii: Compute intersection analytically
# Define mixture density difference function
f_diff <- function(x) {
  p * dnorm(x, mu1, sigma1) - (1 - p) * dnorm(x, mu2, sigma2)
}

f_diff(-20)
f_diff(0)

# Use uniroot to find intersection
intersection <- uniroot(f_diff, lower = -20, upper =0)$root
intersection

# Part iii: Plot density with intersection point
# True mixture density function
mixture_density <- function(x) {
  p * dnorm(x, mu1, sigma1) + (1 - p) * dnorm(x, mu2, sigma2)
}

# Estimated parameters
p_hat <- mclust_fit$parameters$pro[1]
mu_hat <- mclust_fit$parameters$mean
sigma_hat <- sqrt(mclust_fit$parameters$variance$sigmasq)

# Estimated mixture density function
mixture_density_hat <- function(x) {
  p_hat * dnorm(x, mu_hat[1], sigma_hat[1]) + (1 - p_hat) * dnorm(x, mu_hat[2], sigma_hat[2])
}

x_grid <- seq(min(data)-3, max(data)+3, length.out = 1000)

df_density <- data.frame(
  x = x_grid,
  TrueMixture = mixture_density(x_grid),
  TrueCluster1 = p * dnorm(x_grid, mu1, sigma1),
  TrueCluster2 = (1 - p) * dnorm(x_grid, mu2, sigma2),
  EstimatedMixture = mixture_density_hat(x_grid),
  EstimatedCluster1 = p_hat * dnorm(x_grid, mu_hat[1], sigma_hat[1]),
  EstimatedCluster2 = (1 - p_hat) * dnorm(x_grid, mu_hat[2], sigma_hat[2])
)

ggplot(df_density, aes(x = x)) +
  geom_line(aes(y = TrueMixture), color = "black", size = 1, linetype = "solid") +
  geom_line(aes(y = TrueCluster1), color = "blue", linetype = "dashed") +
  geom_line(aes(y = TrueCluster2), color = "red", linetype = "dashed") +
  geom_line(aes(y = EstimatedMixture), color = "green", size = 1, linetype = "solid") +
  geom_line(aes(y = EstimatedCluster1), color = "cyan", linetype = "dotted") +
  geom_line(aes(y = EstimatedCluster2), color = "magenta", linetype = "dotted") +
  geom_vline(xintercept = intersection, color = "orange", linetype = "dotdash") +
  labs(title = "Density Plot with True and Estimated Parameters") +
  theme_minimal()
