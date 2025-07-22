# Gaussian Mixture Model Clustering & Density Analysis in R

This project demonstrates the simulation, clustering, and visualization of a two-component Gaussian Mixture Model (GMM) using R. It covers the following:

- Simulating a dataset from a Gaussian mixture with known parameters.
- Visualizing the data with true cluster labels.
- Performing model-based clustering using the `mclust` package.
- Visualizing estimated clusters from the model.
- Computing the analytical intersection point of the component densities.
- Plotting the true and estimated mixture densities along with the intersection point.

---

## Overview of the Analysis

### Part i: Data Simulation and Clustering
- Generated a sample of 200 points from a mixture of two Gaussians with parameters:
  - Mixing proportion: **p = 0.4**  
  - Means: **μ₁ = 0**, **μ₂ = −2**  
  - Standard deviations: **σ₁ = 1**, **σ₂ = 4**
- Plotted the histogram colored by the true cluster assignments.
- Applied `Mclust` from the `mclust` package to estimate clusters.
- Visualized the histogram colored by the estimated cluster assignments.

### Part ii: Intersection Point Computation
- Defined a function representing the difference between the weighted densities of the two Gaussian components.
- Used `uniroot` to find the intersection point analytically where the two component densities are equal.

### Part iii: Density Plotting
- Plotted the mixture density along with individual cluster densities for both true and estimated parameters.
- Marked the analytically computed intersection point on the density plot.

---

## 🚀 How to Use

1. Make sure you have R installed on your system.
2. Install the required R packages:
   ```R
   install.packages("mclust")
   install.packages("ggplot2")
3. Clone this repository and run the gmm_clustering_density.R script in RStudio or any R environment.

4. Run the script to:
- Generate simulated data.
- Perform clustering.
- Compute intersection points.
- Visualize results via histograms and density plots.

Modify parameters (e.g., mixture proportions, means, standard deviations) in the script as needed for experimentation.

## Visualizations

- Histogram with True Clusters: Displays the density distribution of simulated data colored by actual component membership.
- Histogram with Estimated Clusters: Shows clustering results as estimated by the Mclust algorithm.
- Density Plot: Overlays true and estimated mixture densities, individual cluster densities, and marks the intersection point between the component densities.

## Notes
- This project is intended for educational purposes.
- The code is original and inspired by academic coursework.
- Contributions and feedback are welcome.
> ⚠️ This repository includes academic work completed as part of coursework at Philipps-Universität Marburg. All code is original and shared for educational and demonstration purposes only.

## 🙋‍♀️ About Me

Chaitrika Mohan Bhat<br>
Feel free to connect or reach out:
- [LinkedIn](https://www.linkedin.com/in/chaitrika-m-bhat/)
- [Email](chaitrikambhat@gmail.com)

