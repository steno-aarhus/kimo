
##add ID

add_id <- function(data) {
    data %>%
        mutate(id = 1:n())
}


##rename

data %>%
    rename(sex = p31, education = p6138_i0, townsend_index = p22189, ethnicity = p21000_i0, income = p738_i0) %>%
    rename(year_birth=p34, age_baseline=p21022, month_birth=p52, center=p54_i0, date_death=p40000_i0, employment=p6142_i0)  %>%
    rename(smoking = p20116_i0,  drinking = p20117_i0, met = p22040_i0) %>%
    rename(diabetes_diag_baseline=p2443_i0, cancer_selfreport=p134_i0, noncancer_selfreport=p135_i0, cancer_diag=p2453_i0) %>%
    rename(bmi = p21001_i0, medication=p137_i0, operation=p136_i0, othercondition=p2473_i0, gestation_diab=p4041_i0) %>%
    rename(cvd_diag=p6150_i0, bloodclot_diag=p6152_i0, lowerbp_medication=p6153_i0) %>%
    rename_with(~ stringr::str_replace(.x, "^p41280_", "date_of_diagnosis_"))
