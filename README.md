# NS model comp
 North Sea mental model - EwE model comparison


This github repository creates the analysis and figures comparing qualitative (mentalmodeler.org) and quantitative ecosystem model scenarios for the Skagerrak, Kattegat, Souther North Sea and the Norwegian trench. Scenarios of increased and decreased fishing were run on all models, while scenarios of increased and decreased marine mammals were run on the Kattegat model. These results are reported in Olsen et al. 2022. 

The r-scripts need to be run in the following order:
1)	mental model circle figures.Rmd -  creates circular graphs of the mental models
2)	mental models qpress.Rmd - runs QPRESS analysis of the scenarioson the mental models 
3)	kattegate_EwE.Rmd - creates normalized time series from the Kattegate EwE model
4)	NS EwE.Rmd - creates normalized time series from the North Sea EwE model
5)	QPRESS EwE comparison.Rmd - compares the mental model and EwE scenarios
6)	EwE Circular Graphs.Rmd -  makes circular graphs of the NS and Kattegate EwE model diet matricies

