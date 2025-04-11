


# Simulated methylation data analysis
library(ggplot2)
library(dplyr)
library(pheatmap)

# Simulated dataset (gene, region, sample1, sample2, ...)
meth_data <- data.frame(
  Gene = paste0("Gene", 1:10),
  Region = rep(c("Island", "Shore", "Shelf"), length.out = 10),
  Tumor1 = runif(10, 0.2, 0.9),
  Tumor2 = runif(10, 0.3, 0.85),
  Normal1 = runif(10, 0.1, 0.6),
  Normal2 = runif(10, 0.15, 0.65)
)

# Melt for ggplot2
library(reshape2)
meth_melt <- melt(meth_data, id.vars = c("Gene", "Region"), variable.name = "Sample", value.name = "Methylation")

# Boxplot by region and condition
meth_melt$Condition <- ifelse(grepl("Tumor", meth_melt$Sample), "Tumor", "Normal")
ggplot(meth_melt, aes(x=Region, y=Methylation, fill=Condition)) +
  geom_boxplot() + theme_minimal() + ggtitle("Methylation by Region and Condition")

# Heatmap
meth_matrix <- meth_data[, 3:6]
rownames(meth_matrix) <- meth_data$Gene
pheatmap(meth_matrix, main = "Methylation Heatmap")