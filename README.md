# StarRank—  a HacknLead Hackathon project

Location: Zurich, Switzerland
Date: 16-17, June, 2018

Project owners (in alphabetical order): 
* Arantxa Urchueguia Fornes (arantxa.urchueguia@gmail.com)
* Chris Martins (chris.snophan@gmail.com)
* Ekaterina Stepanova (ekfila@gmail.com)
* Marina Shkapina (shkapmari@gmail.com)
* Sarvenaz Choobdar (schoobdar@gmail.com)
* Xiao Jean Chen (xiaojean.chen@gmail.com)



## The Challenge
Forget investor’s gut feeling! Let’s put some objectivity into startup rating! By using machine learning we’ll create a fully automated VC to predict the TOP 100 startups that be announced in this year’s award ceremony on Sep 5. They’ll provide the ratings and results of past competitions (100 jurors, past top 100 winners and 2500 startups).

Objective of the challenge is to predict startup success in general and the TOP 100 startup award ranking in particular. The ranking is done every year and published in a nice event and the Handelszeitung. The past ranking is to be found here: https://www.startup.ch/top100


The ranking is composed of a public voting and (more importantly) of the votes from 100 jurors (most of then venture capitalists) who could name their Top 10 candidates out of more than 2000 Swiss startups that were eligible. The ranking was done since 2011, startups have to be Swiss and no more than 5 years old, announcement of the winners will be on Sep 5, 2018.

## Data

The data was provided by Startup.ch, including the information on the startups (name, city, uni spin-off, technology, incorporation date, number of employees, company activity description). 
We also used the API data provided by Crunchbase on the eligible Swiss startups, their founders and the jury members of the 2018 competition. 

## Algorithmic Method

Indicators that we used include:

* Companies’ investors;
* Funding rounds;
* Raised amount of money;
* What region the company from;
* Whether the company was acquired (binominal);
* Whether the company participated in the top100 in the previous years (from 2012 to 2017);
* Whether the company made it to top100 in the previous years (from 2012 to 2017);
* Number of company’s employees;
* Company’s incorporation date.

## Experimental Result

Although we were granted access to the extensive CrunchBase database, and performed more than a dozen round of data cleaning and preparation, the CrunchBase corpus is sparse with many missing attributes in the company as well as the people profiles. However, our approach still achieved good performance even under data with such sparsity, and we believe it will keep improving as the company profiles on CrunchBase become more complete.

We Trained two binary classifiers to predict if a startup ends up in the Top100 list in 2017. We used SVM and RandomForest. We trained on history of company appearing in top list between 2017-2016 and tested on if a company ends up in topl list of 2017. This already give up precision of 0.9 and recall of 0.6. 

We then added more features including financial features (funding rounds, juror as investor or advisor) and profile of companies (age, number of employees) and this raised the recall to average of 0.8 in a 10-fold cross-validation.


## Further Improvement
The StarRank project was completed in less than 48 hours, although there was substantial  group effort and rapport, and the team is satisfactory of the results, there is much room for further improvement. 

Areas to be improved:
Although we were granted access to the extensive CrunchBase database, and performed more than a dozen round of data cleaning and preparation, the CrunchBase corpus is sparse with many missing attributes in the company as well as the people profiles. We could produce better results with more data, perhaps scraped from the web. 

We found that a small number of successful companies tend to have higher values for a certain features than other successful ones, so is the case for some unsuccessful companies, which may cause false negatives and false positives potentially. A way to bridge such discrepancies is yet to be explored.



