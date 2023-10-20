
##start UKB RAP
install.packages("pak")
#need to install 'cli' package
install.packages("cli")
library(cli)
pak::pak("steno-aarhus/ukbAid")
ukbAid::setup_ukb_rap()
