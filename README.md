# AdsSpending
Analyzing Ads Spending from A/B Tests

## Summary:
* A social media company has an ads product on their platform where companies and brands can use to market their products and services.
*	Overspending is a situation where the ads generate more clicks than the company budgets for, and therefore incur a cost to the social medica company. 
*	The social media company therefore hypothesizes that a new advertising product, where companies pay whenever the ad show, will reduce overspending. The data scientists at the company ran an A/B experiment to decide whether this new product is indeed effective.

## EDA

Box plots of the log transformation of campaign budget in the control and treatment group, by company sizes:

<img src="eda/figures/sent_len_dist.png" alt="drawing" width="350"/>

![image](https://user-images.githubusercontent.com/25354173/140620846-6f988a50-9be8-467f-8fea-1effd9fac99e.png)

Box plots of the log transformation of campaign spend in the control and treatment group, by company sizes

![image](https://user-images.githubusercontent.com/25354173/140620870-c5850b74-1890-4c39-8014-aabc5fab3bbd.png)


## Summary of results: 
* There are 6,257 out of 7,733 (80.91%) campaigns that overspent in the control group, and 5,180 out of 5,721 (73.91%) campaigns that overspent the treatment group.
*	Based on the proportion z-test, there is convincing evidence that the new ad product reduces the proportion of overspending campaign. Based on logistic regression, medium and large company size contribute to a campaign’s lower probability of overspending. 
*	However, there is not enough evidence to conclude that the mean overspending amount in the treatment group is lower than the mean overspending amount in the control group, but there is strong evidence that the observations of overspend in the treatment group tend to be smaller than the observations of overspend in the control group, based on the Mann-Whitney-Wilcoxon rank sum test. Because of this inconclusiveness, in order to make inference about mean overspending, it is advisable to run a follow-up test.
*	There is evidence for the social media company to be concerned about the lower budget entered for campaigns with the new product, based on a t-test on the means of log transformations of campaign budgets.
