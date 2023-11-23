##################################################
##clean covariates###############################
##################################################
dataclean <- data_csv
rm(data_csv_core)
rm(data_csv_dates)

attach(dataclean)
dataclean <- dataclean %>%
    rename(sex=p31)


dataclean <- dataclean %>%
    rename(birthyear=p34) %>%
    rename(houseincome=p738_i0)

dataclean <- dataclean %>%
    rename(waistcum=p48_i0) %>%
    rename(hipcum=p49_i0)

dataclean <- dataclean %>%
    rename(height=p50_i0)

dataclean <- dataclean %>%
    rename(icd10=p41202)

dataclean <- dataclean %>%
    rename(qualification=p6138_i0)

table(dataclean$qualification)


table(dataclean$sex)


#smoking-FieldID:20116: never, current, former
#<https://biobank.ndph.ox.ac.uk/ukb/field.cgi?id=20116>
#create combined variable of smoking derived from smoking status and dosage combining p20116 and p3456 (number of cigarettes currently
#<https://biobank.ndph.ox.ac.uk/ukb/field.cgi?id=3456>).
#recoding p3456, -10 to 0. -1, -3 to missing


