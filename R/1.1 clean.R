
pacman::p_load(
    rio,           # import/export
    here,          # filepaths
    lubridate,     # working with dates
    forcats,       # factors
    aweek,         # create epiweeks with automatic factor levels
    janitor,       # tables
    tidyverse      # data mgmt and viz
)
library(dplyr)
library(tidyverse)
# Install the janitor package (if not already installed)
install.packages("janitor")

# Load the janitor package
library(janitor)

##add ID
data %>% mutate(id = 1:n())


##rename

data<- data %>%
    rename(sex = p31, education = p6138_i0, townsend_index = p22189, ethnicity = p21000_i0, income = p738_i0) %>%
    rename(year_birth=p34, age_baseline=p21022, month_birth=p52, center=p54_i0, date_death=p40000_i0, employment=p6142_i0)  %>%
    rename(smoking = p20116_i0,  drinking = p20117_i0, met = p22040_i0) %>%
    rename(diabetes_diag_baseline=p2443_i0, cancer_selfreport=p134_i0, noncancer_selfreport=p135_i0, cancer_diag=p2453_i0) %>%
    rename(bmi = p21001_i0, medication=p137_i0, operation=p136_i0, othercondition=p2473_i0, gestation_diab=p4041_i0) %>%
    rename(cvd_diag=p6150_i0, bloodclot_diag=p6152_i0, lowerbp_medication=p6153_i0) %>%
    rename_with(~ stringr::str_replace(.x, "^p41280_", "date_of_diagnosis_"))


colnames(data)

###self reported health conditions
##reported cancer
table(data$cancer_selfreport)


ggplot(data = data)+
    geom_bar(mapping = aes(x = cancer_selfreport))


table(data$noncancer_selfreport)

ggplot(data = data)+
    geom_bar(mapping = aes(x = noncancer_selfreport))

##diagnosed by doctor
table(data$cancer_diag)

data <- data %>%
    mutate(cancer_diag_new = fct_relevel(cancer_diag))

str(data$cancer_diag_new)

##################################################




table(data$cvd_diag)

table(data$bloodclot_diag)

table(data$diabetes_diag_baseline)

table(data$medication)

data %>%
    mutate(cancer_diag_new = fct_recode(
        cancer_diag,
        "Yes" = "Yes - you will be asked about this later by an interviewer",
        "No"      = "No",
        "Prefer not to answer/Do not know" = "Prefer not to answer",
        "Prefer not to answer/Do not know" = "Do not know"))  %>%
    tabyl(cancer_diag_new)


table(data$cvd_diag, data$lowerbp_medication)
