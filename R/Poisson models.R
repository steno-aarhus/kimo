

##Poisson regression
##outcome--CVD
##exposure: eGFRcre, eGFRcyc

#***model 1
m1 <- glm(cvd ~ eGFRcre+age+sex+edu+race, family="poisson", data=p))

#***model 2
m1 <- glm(cvd ~ eGFRcre+age+sex+edu+race+hypertension, family="poisson", data=p))


## calculate and store predicted values
p$phat <- predict(m1, type="response")

## order by program and then by math
p <- p[with(p, order(prog, math)), ]

## create the plot
ggplot(p, aes(x = eGFRcre, y = phat, colour = prog)) +
    geom_point(aes(y = cvd), alpha=.5, position=position_jitter(h=.2)) +
    geom_line(size = 1) +
    labs(x = "eGFR", y = "Expected CVD events")

#https://stats.oarc.ucla.edu/r/dae/poisson-regression/
