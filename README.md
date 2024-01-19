# MotrpacRatTrainingPhysiologyData

<!-- badges: start -->

![R package version](https://img.shields.io/github/r-package/v/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData?label=R%20package)
[![R-CMD-check](https://github.com/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData/actions/workflows/R-CMD-check.yaml)
![Last commit](https://img.shields.io/github/last-commit/PNNL-Comp-Mass-Spec/MotrpacRatTrainingPhysiologyData/master)

<!-- badges: end -->

## Table of Contents

* [Overview](#overview)
  * [About This Package](#about-this-package)
  * [About MoTrPAC](#about-motrpac)
* [Installation](#installation)
* [Getting Help](#getting-help)
* [Acknowledgements](#acknowledgements)
* [Data Use Agreement](#data-use-agreement)

***

## Overview

### About This Package

This package contains all input data, analysis steps (in the form of vignettes), and results for the MoTrPAC PASS1B Physiology manuscript. This includes data from both male and female Fischer 344 (F344) rats that were either sedentary or completed an endurance exercise training intervention. Training began at 6 or 18 months of age and lasted for a duration of 1, 2, 4, or 8 weeks.

The [data-raw/](https://github.com/MoTrPAC/MotrpacRatTrainingPhysiologyData/tree/master/data-raw) directory contains R scripts that detail how most of the exported datasets were created. For data objects that end in `"_STATS"` or `"_EMM"`, please refer to the appropriate vignette. Vignettes contain all details of the statistical analyses while the online-only articles generate most of the manuscript figures. Vignettes and articles can be viewed on the [pkgdown website](https://motrpac.github.io/MotrpacRatTrainingPhysiologyData/) under the "Articles" tab. This website also includes data and function documentation and news regarding new releases.

**Vignettes:**

* Statistical analyses of baseline body composition and VO2max testing measures
* Statistical analyses of mean fiber area by muscle and fiber type
* Statistical analysis of fiber counts by muscle and fiber type
* Statistical analyses of muscle-specific measures 
* Statistical analyses of plasma clinical analytes
* Statistical analyses of post- vs. pre-training body composition and VO2max testing measures
* Statistical analysis of weekly total body mass

**Articles:**

* Plots of plasma clinical analytes
* Plots of baseline measures
* Plots of fiber area by muscle and fiber type
* Plots of muscle fiber type percentages
* Plots of muscle measures
* Plots of post - pre differences
* Plots of tissue dissection times
* Plots of weekly body mass and blood lactate


### About MoTrPAC

MoTrPAC is a national research consortium designed to discover and perform preliminary characterization of the range of molecular transducers (the "molecular map") that underlie the effects of physical activity in humans. The program's goal is to study the molecular changes that occur during and after exercise and ultimately to advance the understanding of how physical activity improves and preserves health. The six-year program is the largest targeted NIH investment of funds into the mechanisms of how physical activity improves health and prevents disease. See [motrpac.org](https://www.motrpac.org/) and [motrpac-data.org](https://motrpac-data.org/) for more details.

## Installation

You can install the development version of MotrpacRatTrainingPhysiologyData like so:

``` r
if (!require("devtools", quietly = TRUE))
    install.packages("devtools")

devtools::install_github("MoTrPAC/MotrpacRatTrainingPhysiologyData")
```

## Getting Help

For questions, bug reporting, and data requests for this package, please [submit a new issue](https://github.com/MoTrPAC/MotrpacRatTrainingPhysiologyData/issues) and include as many details as possible, including a minimal reproducible example, if applicable.

## Acknowledgements

MoTrPAC is supported by the National Institutes of Health (NIH) Common Fund through cooperative agreements managed by the National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK), National Institute of Arthritis and Musculoskeletal Diseases (NIAMS), and National Institute on Aging (NIA).

Specifically, the MoTrPAC Study is supported by NIH grants U24OD026629 (Bioinformatics Center), U24DK112349, U24DK112342, U24DK112340, U24DK112341, U24DK112326, U24DK112331, U24DK112348 (Chemical Analysis Sites), U01AR071133, U01AR071130, U01AR071124, U01AR071128, U01AR071150, U01AR071160, U01AR071158 (Clinical Centers), U24AR071113 (Consortium Coordinating Center), U01AG055133, U01AG055137 and U01AG055135 (PASS/Animal Sites).

## Data Use Agreement

Recipients and their Agents agree that in publications using **any** data from MoTrPAC public-use data sets they will acknowledge MoTrPAC as the source of data, including the version number of the data sets used, *e.g.*:

-   Data used in the preparation of this article were obtained from the Molecular Transducers of Physical Activity Consortium (MoTrPAC) database, which is available for public access at [motrpac-data.org](motrpac-data.org). Specific datasets used are [version numbers].

-   Data used in the preparation of this article were obtained from the Molecular Transducers of Physical Activity Consortium (MoTrPAC) MotrpacRatTrainingPhysiologyData R package [version number].

## See Also

- [MotrpacRatTraining6mo](https://github.com/MoTrPAC/MotrpacRatTraining6mo/)
- [MotrpacRatTraining6moData](https://github.com/MoTrPAC/MotrpacRatTraining6moData/)
- [MotrpacRatTraining6moWAT](https://github.com/MoTrPAC/MotrpacRatTraining6moWAT/)
- [MotrpacRatTraining6moWATData](https://github.com/MoTrPAC/MotrpacRatTraining6moWATData/)
