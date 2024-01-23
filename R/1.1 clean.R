
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
install.packages("flextable")
# Load the janitor package
library(janitor)
library(flextable)
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


####CVD dianogised by docttor
##################################################
table(data$cvd_diag)

# Alpha-numeric default order - no adjustment within ggplot
ggplot(data = data)+
    geom_bar(mapping = aes(x = cvd_diag))

data %>%
    as_tibble() %>%
    count(cvd_diag)  %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()          # format to one line per row


data <- data %>%
    mutate(cvd_diag_yesno = case_when(
        is.na(cancer_diag) ~ "Missing",  # Handle missing values
        stringr::str_detect(cvd_diag, "^(Angina|Heart attack|High blood pressure|Stroke)") ~ "Yes",
        stringr::str_detect(cvd_diag, "^(None)") ~ "No",
        cvd_diag == "Prefer not to answer" ~ "Not Report",
        TRUE ~ NA_character_
    ))


table(data$cvd_diag_yesno)
table(data$cvd_diag_yesno, data$cvd_diag)

####blood clot dianogised by docttor
##################################################
table(data$bloodclot_diag)

data %>%
    as_tibble() %>%
    count(bloodclot_diag)  %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()          # format to one line per row


library(dplyr)
data <- data %>%
    mutate(bloodclot_diag_yesno = case_when(
        is.na(bloodclot_diag) ~ "Missing",  # Handle missing values
        bloodclot_diag %in% c("Hayfever, allergic rhinitis or eczema", "None of the above") ~ "No",
        bloodclot_diag == "Prefer not to answer" ~ "Not report",
        TRUE ~ "Yes"
    ))


# print table
table(data$bloodclot_diag_yesno)

####diabetes dianogised by docttor
##################################################
###################################
table(data$diabetes_diag_baseline)

data %>%
    as_tibble() %>%
    count(diabetes_diag_baseline)  %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()



data <- data %>%
    mutate(diabetes_diag_yesno = case_when(
        is.na(diabetes_diag_baseline) ~ "Missing",  # Handle missing values
        diabetes_diag_baseline %in% c("Do not know", "Prefer not to answer") ~ "Not report",
        TRUE ~ as.character(diabetes_diag_baseline)  # Keep other values unchanged
    ))
table(data$diabetes_diag_yesno)



###################################
table(data$gestation_diab)

data %>%
    as_tibble() %>%
    count(gestation_diab)  %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()

data %>%
    as_tibble() %>%
    count(gestation_diab)

table(data$diabetes_diag_baseline, data$gestation_diab)

##adjust diabetes by gestational diabetes, take out those only occured at gestation
data <- data %>%
    mutate(diabetes_diag_yesno = case_when(
        gestation_diab == "Yes" ~ "No",
        TRUE ~ diabetes_diag_yesno
    ))

table(data$diabetes_diag_yesno)
##cancer diagnosed by doctor
table(data$cancer_diag)

data %>%
    as_tibble() %>%
    count(cancer_diag) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()

table(data$cancer_selfreport, data$cancer_diag)


data <- data %>%
    mutate(cancer_diag_yesno = case_when(
        is.na(cancer_diag) ~ "Missing",  # Handle missing values
        cancer_diag %in% c("Do not know", "Prefer not to answer") ~ "Not report",
        cancer_diag =="Yes - you will be asked about this later by an interviewer" ~ "Yes",
        TRUE ~ as.character(cancer_diag)  # Keep other values unchanged
    ))


table(data$cancer_diag_yesno)


#other condition diagnosed by doctor
table(data$othercondition)

data %>%
    as_tibble() %>%
    count(othercondition) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()



data <- data %>%
    mutate(othercondition_yesno = case_when(
        is.na(othercondition) ~ "Missing",  # Handle missing values
        othercondition %in% c("Do not know", "Prefer not to answer") ~ "Not report",
        othercondition =="Yes - you will be asked about this later by an interviewer" ~ "Yes",
        TRUE ~ as.character(othercondition)  # Keep other values unchanged
    ))

table(data$othercondition_yesno)

##lower blood medication
table(data$lowerbp_medication)
data %>%
    as_tibble() %>%
    count(lowerbp_medication) %>%
    print(n=50)

data %>%
    as_tibble() %>%
    count(lowerbp_medication) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()


table(data$diabetes_diag_baseline, data$lowerbp_medication)





###other meication#######
table(data$p2492_i0)

##reported cancer numbers
table(data$cancer_selfreport)


ggplot(data = data)+
    geom_bar(mapping = aes(x = cancer_selfreport))


table(data$noncancer_selfreport)

ggplot(data = data)+
    geom_bar(mapping = aes(x = noncancer_selfreport))


data %>%
    as_tibble() %>%
    count(cancer_selfreport)



data <- data %>%
    mutate(cancer_diag_new = fct_relevel(cancer_diag))

str(data$cancer_diag_new)
ggplot(data = data)+
    geom_bar(mapping = aes(x = cancer_diag_new))

#######################################
data %>%
    mutate(cancer_diag_new = fct_recode(
        cancer_diag,
        "Yes" = "Yes - you will be asked about this later by an interviewer",
        "No"      = "No",
        "Prefer not to answer/Do not know" = "Prefer not to answer",
        "Prefer not to answer/Do not know" = "Do not know"))  %>%
    tabyl(cancer_diag_new)


table(data$cvd_diag, data$lowerbp_medication)



##too long
data %>% tabyl(cvd_diag, lowerbp_medication)
data %>% tabyl(diabetes_diag_baseline, lowerbp_medication)


data %>%
    tabyl(lowerbp_medication, cvd_diag_yesno) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()          # format to one line per row


data %>%
    tabyl(lowerbp_medication, diabetes_diag_yesno) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()          # format to one line per row

data %>%
    tabyl(cvd_diag_yesno, diabetes_diag_yesno) %>%
    flextable::flextable() %>%    # convert to pretty image
    flextable::autofit()          # format to one line per row


####how many people have the health conditions at baseline
with_condition <- data %>%
    filter(
        cvd_diag_yesno == "Yes" |
            diabetes_diag_yesno == "Yes" |
            cancer_diag_yesno == "Yes" |
            bloodclot_diag_yesno == "Yes" |
            othercondition_yesno == "Yes"
    ) %>%
    distinct() %>%
    nrow()

# Display the count
print(with_condition)


