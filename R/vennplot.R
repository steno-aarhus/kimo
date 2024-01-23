
# Create a new data frame with binary columns for each condition
venn_data <- data.frame(
    cvd = as.numeric(data$cvd_diag_yesno == "Yes"),
    diabetes = as.numeric(data$diabetes_diag_yesno == "Yes"),
    cancer = as.numeric(data$cancer_diag_yesno == "Yes"),
    bloodclot = as.numeric(data$bloodclot_diag_yesno == "Yes"),
    othercondition = as.numeric(data$othercondition_yesno == "Yes")
)

# Display the first few rows of the new data frame
head(venn_data)
venn_data <- venn_data[1:nrow(data), ]

library(VennDiagram)

library(VennDiagram)

# Assuming you have a data frame named 'data' with the specified columns
venn.plot <- venn.diagram(
    x = list(
        CVD = data$cvd_diag_yesno == "Yes",
        Diabetes = data$diabetes_diag_yesno == "Yes",
        Cancer = data$cancer_diag_yesno == "Yes",
        BloodClot = data$bloodclot_diag_yesno == "Yes",
        OtherCondition = data$othercondition_yesno == "Yes"
    ),
    category.names = c("CVD", "Diabetes", "Cancer", "Blood Clot", "Other Condition"),
    filename = NULL,
    output = TRUE,
    category.col = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"),
    output.filename = "venn_diagram.png"
)

# Display the Venn diagram
grid.draw(venn.plot)


library(VennDiagram)

# Assuming you have a data frame named 'data' with the specified columns
venn.plot <- venn.diagram(
    x = list(
        CVD = data$cvd_diag_yesno == "Yes",
        Diabetes = data$diabetes_diag_yesno == "Yes",
        Cancer = data$cancer_diag_yesno == "Yes",
        BloodClot = data$bloodclot_diag_yesno == "Yes",
        OtherCondition = data$othercondition_yesno == "Yes"
    ),
    category.names = c("CVD", "Diabetes", "Cancer", "Blood Clot", "Other Condition"),
    filename = NULL,
    output = TRUE,
    category.col = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"),
    output.filename = "venn_diagram.png",
    euler.d = TRUE,
    scaled = TRUE,
    fontface = "bold",
    cat.col = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"),
    cat.fontfamily = "sans",
    cat.fontface = "bold",
    cat.cex = 1.2,
    margin = 0.1,
    main = "Overlap of Health Conditions",
    sub = "Based on Your Data",
    main.cex = 1.5,
    sub.cex = 1.2,
    col = "transparent"
)

# Display the Venn diagram
grid.draw(venn.plot)


library(VennDiagram)
library(VennDiagram)

# Assuming you have a data frame named 'data' with the specified disease columns
disease_intersections <- list(
    CVD = sum(data$cvd_diag_yesno == "Yes"),
    Diabetes = sum(data$diabetes_diag_yesno == "Yes"),
    Cancer = sum(data$cancer_diag_yesno == "Yes"),
    BloodClot = sum(data$bloodclot_diag_yesno == "Yes")
)



library(VennDiagram)

# Assuming you have a data frame named 'data' with the specified disease columns
disease_overlap <- list(
    CVD = data$cvd_diag_yesno == "Yes",
    Diabetes = data$diabetes_diag_yesno == "Yes",
    Cancer = data$cancer_diag_yesno == "Yes",
    BloodClot = data$bloodclot_diag_yesno == "Yes"
)

# Create a Venn diagram
venn.plot <- venn.diagram(
    x = disease_overlap,
    category.names = c("CVD", "Diabetes", "Cancer", "Blood Clot"),
    filename = NULL,
    output = TRUE,
    category.col = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3"),
    output.filename = "disease_overlap_venn_diagram.png",
    euler.d = TRUE,
    scaled = TRUE,
    fontface = "bold",
    cat.col = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3"),
    cat.fontfamily = "sans",
    cat.fontface = "bold",
    cat.cex = 1.2,
    margin = 0.1,
    main = "Overlap of Diseases",
    sub = "Based on Your Data",
    main.cex = 1.5,
    sub.cex = 1.2,
    col = "transparent"
)

# Display the Venn diagram
grid.draw(venn.plot)
