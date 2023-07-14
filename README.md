# MotrpacRatTrainingPhysiologyData

<!-- badges: start -->
![R package version](https://img.shields.io/github/r-package/v/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData?label=R%20package)
![Last commit](https://img.shields.io/github/last-commit/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData/master)
<!-- badges: end -->

MotrpacRatTrainingPhysiologyData contains all input data, analysis steps (in the form of vignettes), and results for the MoTrPAC PASS1B Physiology manuscript. This includes data from both male and female Fischer 344 (F344) rats that were either sedentary or completed an endurance exercise training intervention. Training began at 6 or 18 months of age and lasted for a duration of 1, 2, 4, or 8 weeks.

Datasets and analysis results include the following:

-   NMR body composition (pre- and post-training)
-   VO$_2$max and maximal running speed (pre- and post-training)
-   Terminal mass, citrate synthase, glycogen, mean cross-sectional area, and capillary contacts for medial gastrocnemius (MG), lateral gastroc (LG), plantaris (PL), and soleus (SOL) muscles.
-   Weekly body mass and blood lactate measures

For more details, see the preprint (linked below).

## Installation

You can install the development version of MotrpacRatTrainingPhysiologyData like so:

``` r
if (!require("devtools", quietly = TRUE))
    install.packages("devtools")

devtools::install_github("PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData")
```

## Preprint

A link to the preprint will be included here, once available.

## Getting Help

For questions, bug reporting, and data requests for this package, please [submit a new issue](https://github.com/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData/issues) and include as many details as possible, including a minimal reproducible example, if applicable.

## Acknowledgements

MoTrPAC is supported by the National Institutes of Health (NIH) Common Fund through cooperative agreements managed by the National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK), National Institute of Arthritis and Musculoskeletal Diseases (NIAMS), and National Institute on Aging (NIA).

Specifically, the MoTrPAC Study is supported by NIH grants U24OD026629 (Bioinformatics Center), U24DK112349, U24DK112342, U24DK112340, U24DK112341, U24DK112326, U24DK112331, U24DK112348 (Chemical Analysis Sites), U01AR071133, U01AR071130, U01AR071124, U01AR071128, U01AR071150, U01AR071160, U01AR071158 (Clinical Centers), U24AR071113 (Consortium Coordinating Center), U01AG055133, U01AG055137 and U01AG055135 (PASS/Animal Sites).

## Data Use Agreement

Recipients and their Agents agree that in publications using **any** data from MoTrPAC public-use data sets they will acknowledge MoTrPAC as the source of data, including the version number of the data sets used, e.g.:

* Data used in the preparation of this article were obtained from the Molecular Transducers of Physical Activity Consortium (MoTrPAC) database, which is available for public access at [motrpac-data.org](motrpac-data.org). Specific datasets used are [version numbers].

* Data used in the preparation of this article were obtained from the Molecular Transducers of Physical Activity Consortium (MoTrPAC) MotrpacRatTrainingPhysiologyData R package [version number].

