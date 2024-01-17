#' @title Plasma clinical analytes
#'
#' @description Common clinical analytes measured in plasma. There are
#'   measurements for 10--20 rats per experimental group.
#'
#' @usage ANALYTES
#'
#' @format An object of class \code{data.frame} with 282 rows and 20 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{omics_analysis}{logical; whether the sample was selected for -omics
#'   analysis.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{runseq}{integer; run order for 6M animals (1--146).}
#'   \item{corticosterone}{integer; corticosterone (ng/mL).}
#'   \item{glucagon}{numeric; glucagon (pM).}
#'   \item{glucose}{integer; glucose (mg/dL).}
#'   \item{glycerol}{numeric; glycerol (mg/dL).}
#'   \item{insulin}{integer; insulin (pg/mL).}
#'   \item{insulin_iu}{numeric; insulin (\eqn{\mu}IU/mL) using the
#'   conversion 1 pg/mL = 0.023 \eqn{\mu}IU/mL provided in the package insert.}
#'   \item{insulin_pm}{numeric; insulin (pM).}
#'   \item{ketones}{integer; total ketone bodies (\eqn{\mu}mol/L).}
#'   \item{lactate}{numeric; lactate (mmol/L).}
#'   \item{leptin}{integer; leptin (pg/mL).}
#'   \item{nefa}{numeric; non-esterified fatty acids (NEFA) (mmol/L).}
#' }
#'
#' @details
#' \tabular{lll}{
#'   \bold{Analyte} \tab \bold{Catalogue No.} \tab \bold{Company} \cr
#'   Corticosterone \tab 55-CORMS-E01 \tab Alpco (Salem, NH) \cr
#'   Glucose \tab B24985 \tab Beckman Coulter (Brea, CA) \cr
#'   Glycerol \tab 445850 \tab Beckman Coulter \cr
#'   Lactate \tab A95550 \tab Beckman Coulter \cr
#'   Total Ketones \tab 415-73301, 411-73401 \tab Fujifilm Wako (Osaka, Japan) \cr
#'   NEFA \tab 995-34791, 999-34691, 993-35191, 991-34891 \tab Fujifilm Wako \cr
#'   Glucagon \tab K1535YK \tab Meso Scale  Discovery (Rockville, MD) \cr
#'   Insulin, Leptin \tab K15158C (multiplex assay) \tab Meso Scale Discovery \cr
#' }
#'
#' @seealso \code{\link{ANALYTES_EMM}}, \code{\link{ANALYTES_STATS}}
#'
#' @examples
#' head(ANALYTES)
#'
#' @keywords datasets
"ANALYTES"


#' @title Plasma clinical analytes estimated marginal means
#'
#' @description A list of \code{emmGrid} objects, one for each clinical analyte.
#'
#' @usage ANALYTES_EMM
#'
#' @seealso \code{\link{ANALYTES}}, \code{\link{ANALYTES_STATS}},
#'   \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' names(ANALYTES_EMM) # clinical analytes
#'
#' str(ANALYTES_EMM)
#'
#' # Print one of the emmGrid objects
#' summary(ANALYTES_EMM[["Corticosterone"]])
#'
#' @keywords datasets
"ANALYTES_EMM"


#' @title Statistical analysis results of plasma clinical analytes
#'
#' @description Statistical analysis results of plasma clinical analytes.
#'
#' @usage ANALYTES_STATS
#'
#' @format An object of class \code{data.frame} with 144 rows and 20 columns:
#'
#' \describe{
#'   \item{response}{character; the clinical analyte being tested.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{contrast}{factor; the comparison between groups. All contrasts are
#'   ratios between the trained and SED group means (levels "1W / SED", "2W /
#'   SED", "4W / SED", "8W / SED").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. All "ratio" (ratio between group means, as
#'   specified by \code{contrast}).}
#'   \item{null}{numeric; the value of the estimate under the null hypothesis.}
#'   \item{estimate}{numeric; ratio between the means of the groups as specified
#'   by \code{contrast}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test.}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the Dunnett-adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used. All "glm"
#'   (generalized linear model).}
#'   \item{family}{character; the probability distribution and link function for
#'   the generalized linear model.}
#'   \item{formula}{character; the model formula. Includes the response
#'   variable, any transformations, and predictors.}
#'   \item{weights}{character; if reciprocal group variances were used as
#'   weights to account for heteroscedasticity (nonconstant residual variance),
#'   this is noted here.}
#' }
#'
#' @seealso \code{\link{ANALYTES}}, \code{\link{ANALYTES_EMM}}
#'
#' @examples
#' head(ANALYTES_STATS)
#'
#' @keywords datasets
"ANALYTES_STATS"


#' @title Baseline (pre-training) measures estimated marginal means
#'
#' @description A list of \code{emmGrid} objects: NMR mass, lean mass, fat mass,
#'   % lean mass, % fat mass; absolute VO\eqn{_2}max; and relative
#'   VO\eqn{_2}max.
#'
#' @usage BASELINE_EMM
#'
#' @seealso \code{\link{BASELINE_STATS}}, \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' names(BASELINE_EMM) # available measures
#'
#' str(BASELINE_EMM)
#'
#' # Print one of the emmGrid objects
#' summary(BASELINE_EMM[["NMR Body Mass"]])
#'
#' @keywords datasets
"BASELINE_EMM"


#' @title Statistical analysis results of baseline (pre-training) measures
#'
#' @description Statistical analysis results of baseline (pre-training)
#'   measures: NMR mass, lean mass, fat mass, % lean mass, % fat mass; absolute
#'   VO\eqn{_2}max; relative VO\eqn{_2}max; and maximum run speed.
#'
#' @usage BASELINE_STATS
#'
#' @format An object of class \code{data.frame} with 112 rows and 23 columns:
#'
#' \describe{
#'   \item{response}{character; the measurement being tested.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{contrast}{character; the comparison between groups. Either ratios or
#'   differences between trained and sedentary group means.}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. Either "ratio" (ratio between means) or "location
#'   shift" (difference of signed mean ranks).}
#'   \item{null}{numeric; the value of the estimate under the null hypothesis.}
#'   \item{estimate}{numeric; ratio or difference between the means of the
#'   groups as specified by \code{contrast}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test. Either "t"
#'   (Student's t-statistic), "z" (Z-statistic), or "W" (Wilcox's W-statistic).}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{n_SED}{integer; the number of samples in the SED (sedentary) group.}
#'   \item{n_trained}{integer; the number of samples in the trained group
#'   (specified by \code{contrast}).}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing.}
#'   \item{family}{character; the probability distribution and link function for
#'   the generalized linear model.}
#'   \item{formula}{character; the model formula. Includes the response
#'   variable, any transformations, and predictors.}
#'   \item{weights}{character; if reciprocal group variances were used as
#'   weights to account for heteroscedasticity (nonconstant residual variance),
#'   this is noted here.}
#'   \item{obs_removed}{character; if any observations were omitted during the
#'   analysis, they are listed here.}
#' }
#'
#' @seealso \code{\link{BASELINE_EMM}}
#'
#' @examples
#' unique(BASELINE_STATS$response) # available measures
#'
#' head(BASELINE_STATS)
#'
#' @keywords datasets
"BASELINE_STATS"


#' @title Body mass recorded on different days
#'
#' @description Measures of total body mass (in grams) recorded on different
#'   days (pre- and post-training measures included, if applicable): NMR day,
#'   VO\eqn{_2}max testing day, and day of sacrifice (terminal).
#'
#' @usage BODY_MASSES
#'
#' @format An object of class \code{data.frame} with 282 rows and 12 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{arrival_body_mass}{numeric; body mass (g) recorded upon arrival to
#'   the facility.}
#'   \item{famil_body_mass}{numeric; body mass (g) following the familiarization
#'   period.}
#'   \item{nmr_pre_body_mass}{numeric; body mass (g) recorded on the same day as
#'   NMR body composition measures (pre-training).}
#'   \item{nmr_post_body_mass}{numeric; body mass (g) recorded on the same day
#'   as NMR body composition measures (post-training).}
#'   \item{vo2_pre_body_mass}{numeric; body mass (g) recorded on the same day as
#'   the VO\eqn{_2}max test (pre-training).}
#'   \item{vo2_post_body_mass}{numeric; body mass (g) recorded on the same day
#'   as the VO\eqn{_2}max test (post-training).}
#'   \item{term_body_mass}{numeric; body mass (g) recorded on the day of
#'   sacrifice.}
#' }
#'
#' @examples
#' head(BODY_MASSES)
#'
#' @keywords datasets
"BODY_MASSES"


#' @title Tissue dissection times
#'
#' @description Tissue dissection times.
#'
#' @usage DISSECTION_TIMES
#'
#' @format An object of class \code{data.frame} with 5450 rows and 11 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{sampletypedescription}{character; sample type (usually a tissue)
#'   descriptions.}
#'   \item{aliquotdescription}{factor; sample type descriptions for plotting.}
#'   \item{t_collection}{Period; time of tissue collection relative to midnight
#'   ("0S").}
#'   \item{t_death}{Period; time of death via heart puncture relative to
#'   midnight ("0S").}
#'   \item{t_freeze}{Period; time of tissue freezing relative to midnight
#'   ("0S").}
#'   \item{collect_before_death}{logical; whether the tissue was collected
#'   before the rat was sacrificed.}
#'   \item{t_diff}{integer; seconds elapsed between time of freezing and either
#'   time of collection (if \code{collect_before_death}) or time of death
#'   (if \code{!collect_before_death}).}
#' }
#'
#' @keywords datasets
"DISSECTION_TIMES"


#' @title Muscle fiber cross-sectional area estimated marginal means
#'
#' @description An \code{emmGrid} object containing estimated marginal means for
#'   the muscle fiber cross-sectional area data by fiber type.
#'
#' @usage FIBER_AREA_EMM
#'
#' @seealso \code{\link{FIBER_TYPES}}, \code{\link{FIBER_AREA_STATS}},
#'   \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' str(FIBER_AREA_EMM)
#'
#' @keywords datasets
"FIBER_AREA_EMM"


#' @title Statistical analysis results of fiber cross-sectional area
#'
#' @description Statistical analysis results of the fiber cross-sectional area
#'   data by muscle and fiber type.
#'
#' @usage FIBER_AREA_STATS
#'
#' @format An object of class \code{data.frame} with 56 rows and 21 columns:
#'
#' \describe{
#'   \item{response}{character; the measurement being tested. All "Mean Fiber
#'   Area".}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
#'   gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
#'   (soleus).}
#'   \item{type}{factor; the muscle fiber type with levels "I", "IIa", "IIx",
#'   and "IIb".}
#'   \item{contrast}{factor; the comparison between groups. All contrasts are
#'   ratios between the 8W and SED group means ("8W / SED").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. All "ratio" (ratio between group means, as
#'   specified by \code{contrast}).}
#'   \item{null}{numeric; the value of the estimate under the null hypothesis.}
#'   \item{estimate}{numeric; ratio between the means of the groups as specified
#'   by \code{contrast}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test. All "t"
#'   (Student's t-statistic).}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the Holm-adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing. All
#'   "lme" (linear mixed effects model).}
#'   \item{fixed}{character; the fixed-effects component of the model formula.
#'   Describes the response variable (and any transformations) and all predictor
#'   variables that were included. Equivalent to \code{formula}.}
#'   \item{random}{character; the random component of the model formula.
#'   Specifies the random effects for mixed effects models. All "~1 | pid"
#'   (random intercept for each rat).}
#' }
#'
#' @seealso \code{\link{FIBER_TYPES}}, \code{\link{FIBER_AREA_EMM}}
#'
#' @examples
#' head(FIBER_AREA_STATS)
#'
#' @keywords datasets
"FIBER_AREA_STATS"


#' @title Muscle fiber count estimated marginal means
#'
#' @description An \code{emmGrid} object containing estimated marginal means for
#'   the muscle fiber count data. Note that the counts have been transformed to
#'   isometric log-ratio (ilr) coordinates. See the vignette for details.
#'
#' @usage FIBER_COUNT_EMM
#'
#' @keywords datasets
"FIBER_COUNT_EMM"


#' @title Statistical analysis results of muscle fiber counts
#'
#' @description Statistical analysis results of muscle fiber counts.
#'
#' @usage FIBER_COUNT_STATS
#'
#' @format An object of class \code{data.frame} with 40 rows and 19 columns:
#'
#' \describe{
#'   \item{response}{character; the measurement being tested. All "Fiber
#'   Count".}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
#'   gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
#'   (soleus).}
#'   \item{balance}{numeric; Exploring Compositional Data with the
#'   CoDa-Dendrogram: "the natural logarithm of the ratio of geometric means of
#'   the parts in each group, normalised by a coefficient to guarantee unit
#'   length of the vectors of the basis" (Pawlowsky-Glahn & Egozcue 2011).}
#'   \item{contrast}{factor; the comparison between groups. All contrasts are
#'   differences between the 8W and SED group means ("8W - SED").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. All "difference of means" (difference between group
#'   means, as specified by \code{contrast}).}
#'   \item{estimate}{numeric; difference between the means of the groups as
#'   specified by \code{contrast}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test.}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing.}
#'   \item{formula}{character; the model formula. Includes the response
#'   variable, any transformations, and predictors.}
#' }
#'
#' @references Pawlowsky-Glahn, V., & Egozcue, J. J. (2011). Exploring
#'   Compositional Data with the CoDa-Dendrogram. \emph{Austrian Journal of
#'   Statistics, 40}(1&2), 103--113.
#'
#' @keywords datasets
"FIBER_COUNT_STATS"


#' @title Fiber-type-specific measures
#'
#' @description Fiber-type-specific measures: fiber cross-sectional area (CSA)
#'   and fiber count.
#'
#' @usage FIBER_TYPES
#'
#' @format An object of class \code{data.frame} with 672 rows and 10 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
#'   gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
#'   (soleus).}
#'   \item{type}{factor; the muscle fiber type with levels "I", "IIa", "IIx",
#'   and "IIb".}
#'   \item{fiber_area}{numeric; muscle fiber cross-sectional area (\eqn{\mu
#'   m^2}).}
#'   \item{fiber_count}{integer; number of muscle fibers by fiber type.}
#'   \item{total_fiber_count}{integer; total number of muscle fibers across
#'   fiber types.}
#' }
#'
#' @seealso \code{\link{FIBER_AREA_EMM}}, \code{\link{FIBER_AREA_STATS}},
#'   \code{\link{FIBER_COUNT_EMM}}, \code{\link{FIBER_COUNT_STATS}},
#'   \code{\link{FIBER_COUNT_MVT}}
#'
#' @examples
#' print.data.frame(head(FIBER_TYPES))
#'
#' @keywords datasets
"FIBER_TYPES"


#' @title Muscle-specific measures
#'
#' @description Muscle-specific measures taken from medial gastrocnemius (MG),
#'   lateral gastroc (LG), plantaris (PL), and soleus (SOL): terminal muscle
#'   mass, mean cross-sectional area (CSA), glycogen, capillary contacts, and
#'   citrate synthase.
#'
#' @usage MUSCLES
#'
#' @format An object of class \code{data.frame} with 1116 rows and 11 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
#'   gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
#'   (soleus).}
#'   \item{term_muscle_mass}{numeric; terminal muscle mass (mg).}
#'   \item{mean_CSA}{numeric; mean fiber cross-sectional area (CSA; \eqn{\mu
#'   m^2}).}
#'   \item{glycogen}{numeric; muscle glycogen (\eqn{ng/\mu L \text{
#'   supernatant}/mg \text{ tissue}}).}
#'   \item{capillary_contacts}{numeric; capillary contacts (number of
#'   capillaries per fiber).}
#'   \item{citrate_synthase}{numeric; citrate synthase (\eqn{U / \mu g \text{
#'   protein} \times 10^3}).}
#' }
#'
#' @seealso \code{\link{MUSCLES_EMM}}, \code{\link{MUSCLES_STATS}}
#'
#' @examples
#' head(MUSCLES)
#'
#' @keywords datasets
"MUSCLES"


#' @title Muscle-specific measures estimated marginal means
#'
#' @description A list of \code{emmGrid} objects, one for each muscle-specific
#'   measures: terminal muscle mass, mean cross-sectional area (CSA), glycogen,
#'   capillary contacts, and citrate synthase.
#'
#' @usage MUSCLES_EMM
#'
#' @seealso \code{\link{MUSCLES}}, \code{\link{MUSCLES_STATS}},
#'   \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' names(MUSCLES_EMM) # available measures
#'
#' str(MUSCLES_EMM)
#'
#' # Print one of the emmGrid objects
#' MUSCLES_EMM[["Glycogen"]]
#'
#' @keywords datasets
"MUSCLES_EMM"


#' @title Statistical analysis results of muscle-specific measures
#'
#' @description Statistical analysis results of muscle-specific measures:
#'   terminal muscle mass, mean cross-sectional area (CSA), glycogen, capillary
#'   contacts, and citrate synthase.
#'
#' @usage MUSCLES_STATS
#'
#' @format An object of class \code{data.frame} with 224 rows and 22 columns:
#'
#' \describe{
#'   \item{response}{character; the muscle-specific measurement being tested.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{muscle}{factor; the muscle that was sampled with levels "LG" (lateral
#'   gastrocnemius), "MG" (medial gastrocnemius), "PL" (plantaris), and "SOL"
#'   (soleus).}
#'   \item{contrast}{factor; the comparison between groups. All contrasts are
#'   ratios between the trained and SED group means (levels "1W / SED", "2W /
#'   SED", "4W / SED", "8W / SED").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. All "ratio" (ratio between group means, as
#'   specified by \code{contrast}).}
#'   \item{null}{numeric; the value of the estimate under the null hypothesis.}
#'   \item{estimate}{numeric; ratio between the means of the groups as specified
#'   by \code{contrast}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test. All "t"
#'   (Student's t-statistic).}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing. All
#'   "lme" (linear mixed effects model).}
#'   \item{fixed}{character; the fixed-effects component of the model formula.
#'   Describes the response variable (and any transformations) and all predictor
#'   variables that were included. Equivalent to \code{formula}.}
#'   \item{random}{character; the random component of the model formula.
#'   Specifies the random effects for mixed effects models. All "~1 | pid"
#'   (random intercept for each rat).}
#'   \item{weights}{character; if reciprocal group variances were used as
#'   weights to account for heteroscedasticity (nonconstant residual variance),
#'   this is noted here.}
#'   \item{obs_removed}{character; if any observations were omitted during the
#'   analysis, they are listed here.}
#' }
#'
#' @seealso \code{\link{MUSCLES}}, \code{\link{MUSCLES_EMM}}
#'
#' @examples
#' unique(MUSCLES_STATS$response) # available measures
#'
#' head(MUSCLES_STATS)
#'
#' @keywords datasets
"MUSCLES_STATS"


#' @title NMR body composition measures
#'
#' @description Measures of body composition (total body mass, body fat, % body
#'   fat, lean mass, and % lean mass) both pre- and post-training.
#'
#' @usage NMR
#'
#' @format An object of class \code{data.frame} with 282 rows and 19 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{pre_day}{POSIXct, POSIXt; the day when the pre-training NMR body
#'   composition measures were recorded.}
#'   \item{pre_body_mass}{numeric; body mass (g) recorded on the same day
#'   as NMR body composition measures (pre-training).}
#'   \item{pre_fat}{numeric; fat mass (g) recorded via NMR (pre-training).}
#'   \item{pre_lean}{numeric; lean mass (g) recorded via NMR (pre-training).}
#'   \item{pre_fat_pct}{numeric; percent fat mass (pre-training). Calculated as
#'   \code{pre_fat / pre_body_mass * 100}.}
#'   \item{pre_lean_pct}{numeric; percent lean mass (pre-training). Calculated
#'   as \code{pre_lean / pre_body_mass * 100}.}
#'   \item{pre_fluid_pct}{numeric; percent fluid mass (pre-training).}
#'   \item{post_day}{POSIXct, POSIXt; the day when the post-training NMR body
#'   composition measures were recorded.}
#'   \item{post_body_mass}{numeric; body mass (g) recorded on the same day as
#'   NMR body composition measures (post-training).}
#'   \item{post_fat}{numeric; fat mass (g) recorded via NMR (post-training).}
#'   \item{post_lean}{numeric; lean mass (g) recorded via NMR (post-training).}
#'   \item{post_fat_pct}{numeric; percent fat mass (post-training). Calculated
#'   as \code{post_fat / post_body_mass * 100}.}
#'   \item{post_lean_pct}{numeric; percent lean mass (post-training). Calculated
#'   as \code{post_lean / post_body_mass * 100}.}
#'   \item{post_fluid_pct}{numeric; percent fluid mass (post-training).}
#' }
#'
#' @seealso \code{\link{PRE_POST_STATS}}
#'
#' @examples
#' head(NMR)
#'
#' @keywords datasets
"NMR"


#' @title Statistical analysis results of post - pre training differences
#'
#' @description Statistical analysis results of post - pre training differences:
#'   NMR body mass, lean mass, fat mass, % lean mass, % fat mass; difference
#'   between terminal and pre-training NMR mass at 1W and 2W of endurance
#'   training; absolute VO\eqn{_2}max; relative VO\eqn{_2}max; and maximum run
#'   speed.
#'
#' @usage PRE_POST_STATS
#'
#' @format An object of class \code{data.frame} with 90 rows and 21 columns:
#'
#' \describe{
#'   \item{response}{character; the measurement being tested.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column. Either "(post - pre) mean" (mean of the paired
#'   (post - pre) differences) or "signed mean (post - pre) rank" (the signed
#'   mean ranks of the (post - pre) differences).}
#'   \item{estimate}{numeric; the value of the estimate, as described by
#'   \code{estimate_type}.}
#'   \item{SE}{numeric; the standard error of the estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test. Either "t"
#'   (Student's t-statistic) or "W" (Wilcox's W-statistic).}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the Holm-adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing. Either
#'   "lm" (linear regression) or "wilcox.test" (Wilcoxon test).}
#'   \item{formula}{character; the model formula. Includes the response
#'   variable, any transformations, and predictors.}
#'   \item{family}{character; the probability distribution and link function for
#'   the generalized linear model.}
#'   \item{weights}{character; if reciprocal group variances were used as
#'   weights to account for heteroscedasticity (nonconstant residual variance),
#'   this is noted here.}
#'   \item{obs_removed}{character; if any observations were omitted during the
#'   analysis, they are listed here.}
#' }
#'
#' @examples
#' unique(PRE_POST_STATS$response)
#'
#' head(PRE_POST_STATS)
#'
#' @keywords datasets
"PRE_POST_STATS"


#' @title VO2max test measures
#'
#' @description Measures from the pre- and post-training VO\eqn{_2}max tests:
#'   total body mass, absolute and relative VO\eqn{_2}max, respiratory exchange
#'   rate (RER), VCO\eqn{_2}, maximum run speed, blood lactate, and test
#'   duration.
#'
#' @usage VO2MAX
#'
#' @format An object of class \code{data.frame} with 234 rows and 27 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{pre_body_mass}{numeric; body mass (g) recorded on the same day as
#'   the VO\eqn{_2}max test (pre-training).}
#'   \item{pre_t_start}{POSIXct, POSIXt; date and time of the VO\eqn{_2}max test
#'   start (pre-training).}
#'   \item{pre_blactate_begin}{numeric; blood lactate (mmol/L) recorded at the
#'   start of the test (pre-training).}
#'   \item{pre_vo2max_ml_kg_min}{numeric; maximum relative VO\eqn{_2}max
#'   (mL/kg body mass/min) reached during the test (pre-training).}
#'   \item{pre_vo2max_ml_min}{numeric; maximum absolute VO\eqn{_2}max
#'   (mL/kg/min) reached during the test (pre-training).}
#'   \item{pre_vco2_max}{numeric; maximum VCO\eqn{_2} reached during the
#'   VO\eqn{_2}max test (pre-training).}
#'   \item{pre_rer_max}{numeric; maximum respiratory exchange rate (RER) reached
#'   during the VO\eqn{_2}max test (pre-training).}
#'   \item{pre_speed_max}{numeric; maximum run speed (m/min) reached during the
#'   VO\eqn{_2}max test (pre-training).}
#'   \item{pre_t_complete}{POSIXct, POSIXt; date and time of the VO\eqn{_2}max
#'   test end (pre-training).}
#'   \item{pre_blactate_end}{numeric; blood lactate (mmol/L) recorded at the end
#'   of the test (pre-training).}
#'   \item{pre_comments}{character; comments regarding the pre-training
#'   VO\eqn{_2}max test.}
#'   \item{post_body_mass}{numeric; body mass (g) recorded on the same day as
#'   the VO\eqn{_2}max test (post-training).}
#'   \item{post_t_start}{POSIXct, POSIXt; date and time of the VO\eqn{_2}max
#'   test start (post-training).}
#'   \item{post_blactate_begin}{numeric; blood lactate (mmol/L) recorded at the
#'   start of the test (post-training).}
#'   \item{post_vo2max_ml_kg_min}{numeric; maximum relative VO\eqn{_2}max
#'   (mL/kg body mass/min) reached during the test (post-training).}
#'   \item{post_vo2max_ml_min}{numeric; maximum absolute VO\eqn{_2}max
#'   (mL/kg/min) reached during the test (post-training).}
#'   \item{post_vco2_max}{numeric; maximum VCO\eqn{_2} reached during the
#'   VO\eqn{_2}max test (post-training).}
#'   \item{post_rer_max}{numeric; maximum respiratory exchange rate (RER)
#'   reached during the VO\eqn{_2}max test (post-training).}
#'   \item{post_speed_max}{numeric; maximum run speed (m/min) reached during the
#'   VO\eqn{_2}max test (post-training).}
#'   \item{post_t_complete}{POSIXct, POSIXt; date and time of the VO\eqn{_2}max
#'   test end (post-training).}
#'   \item{post_blactate_end}{numeric; blood lactate (mmol/L) recorded at the
#'   end of the test (post-training).}
#'   \item{post_comments}{character; comments regarding the post-training
#'   VO\eqn{_2}max test.}
#' }
#'
#' @examples
#' head(VO2MAX)
#'
#' @keywords datasets
"VO2MAX"


#' @title Weekly body mass estimated marginal means
#'
#' @description An \code{emmGrid} object for weekly body mass.
#'
#' @usage WEEKLY_BODY_MASS_EMM
#'
#' @seealso \code{\link{WEEKLY_MEASURES}}, \code{\link{WEEKLY_BODY_MASS_STATS}},
#'   \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' str(WEEKLY_BODY_MASS_EMM)
#'
#' @keywords datasets
"WEEKLY_BODY_MASS_EMM"


#' @title Statistical analysis results of weekly body mass
#'
#' @description Statistical analysis results of weekly body mass.
#'
#' @usage WEEKLY_BODY_MASS_STATS
#'
#' @format An object of class \code{data.frame} with 32 rows and 20 columns:
#'
#' \describe{
#'   \item{response}{character; the variable being tested.}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{week}{factor; the week the measurement was recorded relative to the
#'   start of the training protocol (levels 1--8).}
#'   \item{contrast}{factor; the comparison between groups. All contrasts are
#'   ratios between the 8W and SED group means ("8W / SED").}
#'   \item{estimate_type}{character; interpretation of the value in the
#'   \code{estimate} column.}
#'   \item{null}{numeric; the value of the estimate under the null hypothesis.}
#'   \item{estimate}{numeric; }
#'   \item{SE}{numeric; the standard error of the ratio estimate.}
#'   \item{lower.CL}{numeric; lower bound of the 95% confidence interval.}
#'   \item{upper.CL}{numeric; upper bound of the 95% confidence interval.}
#'   \item{statistic_type}{character; the type of statistical test.}
#'   \item{statistic}{numeric; the value of the test statistic.}
#'   \item{df}{numeric; the number of residual degrees of freedom.}
#'   \item{p.value}{numeric; the p-value associated with the statistical
#'   test.}
#'   \item{p.adj}{numeric; the Holm-adjusted p-value.}
#'   \item{signif}{logical; \code{TRUE} if \code{p.adj} < 0.05.}
#'   \item{model_type}{character; the statistical model used for testing.}
#'   \item{formula}{character; the model formula. Includes the response
#'   variable, any transformations, and predictors.}
#'   \item{correlation}{character; the within-group correlation structure. All
#'   "corAR1(form = ~1 | pid)".}
#' }
#'
#' @seealso \code{\link{WEEKLY_MEASURES}}, \code{\link{WEEKLY_BODY_MASS_EMM}}
#'
#' @examples
#' head(WEEKLY_BODY_MASS_STATS)
#'
#' @keywords datasets
"WEEKLY_BODY_MASS_STATS"


#' @title Weekly body mass and blood lactate measures
#'
#' @description Weekly measures of total body mass and blood lactate.
#'
#' @usage WEEKLY_MEASURES
#'
#' @format An object of class \code{data.frame} with 2226 rows and 11 columns:
#'
#' \describe{
#'   \item{pid}{character; randomly generated 8-digit identifier used in
#'   linkage to phenotypic data. All samples from the same animal have the same
#'   PID.}
#'   \item{iowa_id}{character; unique ID used for each rat at the Iowa PASS.}
#'   \item{omics_analysis}{logical; whether the sample was selected for -omics
#'   analysis.}
#'   \item{sex}{factor; the sex of the rat with levels "Female" and "Male".}
#'   \item{group}{factor; exercise training group. Either "SED" (sedentary) or
#'   the number of weeks of training ("1W", "2W", "4W", "8W").}
#'   \item{age}{factor; the age of the rat at the beginning of the training
#'   protocol. Levels: "6M" (Adult) and "18M" (Aged).}
#'   \item{day}{numeric; the day the measurement was recorded relative to the
#'   start of the training protocol.}
#'   \item{week}{numeric; the week the measurement was recorded relative to the
#'   start of the training protocol (1--8).}
#'   \item{week_time}{factor; at what point in the week the measurement was
#'   taken ("start" or "end").}
#'   \item{body_mass}{numeric; total body mass (g) recorded at the start of each
#'   week.}
#'   \item{lactate}{numeric; blood lactate (mM) recorded at the start and end of
#'   each week.}
#' }
#'
#' @seealso \code{\link{WEEKLY_BODY_MASS_EMM}},
#'   \code{\link{WEEKLY_BODY_MASS_STATS}}
#'
#' @examples
#' head(WEEKLY_MEASURES)
#'
#' @keywords datasets
"WEEKLY_MEASURES"

