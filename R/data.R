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
#' ANALYTES_EMM[["Corticosterone"]]
#'
#' @keywords datasets
"ANALYTES_EMM"


#' @title Statistical analysis results of plasma clinical analytes
#'
#' @description A \code{data.frame} containing analysis results of plasma
#'   clinical analytes.
#'
#' @usage ANALYTES_STATS
#'
#' @seealso \code{\link{ANALYTES}}, \code{\link{ANALYTES_EMM}}
#'
#' @examples
#' print.data.frame(head(ANALYTES_STATS))
#'
#' @keywords datasets
"ANALYTES_STATS"


#' @title Plasma clinical analytes
#'
#' @description A \code{data.frame} containing common clinical analytes measured
#'   in plasma.
#'
#' @usage ANALYTES
#'
#' @details
#' \tabular{lll}{
#'   \bold{Analyte} \tab \bold{Catalogue No.} \tab \bold{Company} \cr
#'   Corticosterone \tab 55-CORMS-E01 \tab Alpco (Salem, NH) \cr
#'   Glucose \tab B24985 \tab Beckman (Brea, CA) \cr
#'   Glycerol \tab 445850 \tab Beckman \cr
#'   Lactate \tab A95550 \tab Beckman \cr
#'   Total Ketones \tab 415-73301, 411-73401 \tab Fujifilm Wako (Osaka, Japan) \cr
#'   NEFA \tab 995-34791, 999-34691, 993-35191, 991-34891 \tab Fujifilm Wako \cr
#'   Glucagon \tab K1535YK \tab Meso Scale  Discovery (Rockville, MD) \cr
#'   Insulin, Leptin \tab K15158C (multiplex assay) \tab Meso Scale Discovery \cr
#' }
#'
#' @seealso \code{\link{ANALYTES_EMM}}, \code{\link{ANALYTES_STATS}}
#'
#' @examples
#' print.data.frame(head(ANALYTES))
#'
#' @keywords datasets
"ANALYTES"


#' @title Baseline (pre-training) measures estimated marginal means
#'
#' @description A list of \code{emmGrid} objects: NMR mass, lean mass, fat mass,
#'   %% lean mass, %% fat mass; absolute VO\eqn{_2}max; and relative
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
#' BASELINE_EMM[["NMR Weight"]]
#'
#' @keywords datasets
"BASELINE_EMM"


#' @title Statistical analysis results of baseline (pre-training) measures
#'
#' @description A \code{data.frame} containing statistical analysis results of
#'   baseline (pre-training) measures: NMR mass, lean mass, fat mass, %% lean
#'   mass, %% fat mass; absolute VO\eqn{_2}max; relative VO\eqn{_2}max; and
#'   maximum run speed.
#'
#' @usage BASELINE_STATS
#'
#' @seealso \code{\link{BASELINE_EMM}}
#'
#' @examples
#' unique(BASELINE_STATS$response) # available measures
#'
#' print.data.frame(head(BASELINE_STATS))
#'
#' @keywords datasets
"BASELINE_STATS"


#' @title Fiber-type-specific measures estimated marginal means
#'
#' @description A list of \code{emmGrid} objects: fiber type cross-sectional
#'   area (CSA).
#'
#' @usage FIBER_TYPES_EMM
#'
#' @seealso \code{\link{FIBER_TYPES}}, \code{\link{FIBER_TYPES_STATS}},
#'   \code{\link[emmeans]{emmeans}}
#'
#' @examples
#' names(FIBER_TYPES_EMM) # available measures
#'
#' str(FIBER_TYPES_EMM)
#'
#' # Print one of the emmGrid objects
#' FIBER_TYPES_EMM[["Fiber CSA"]]
#'
#' @keywords datasets
"FIBER_TYPES_EMM"


#' @title Statistical analysis results of fiber-type-specific measures
#'
#' @description A \code{data.frame} containing statistical analysis results of
#'   fiber-type-specific measures: fiber type cross-sectional area (CSA).
#'
#' @usage FIBER_TYPES_STATS
#'
#' @seealso \code{\link{FIBER_TYPES}}, \code{\link{FIBER_TYPES_EMM}}
#'
#' @examples
#' unique(FIBER_TYPES_STATS$response) # available measures
#'
#' print.data.frame(head(FIBER_TYPES_STATS))
#'
#' @keywords datasets
"FIBER_TYPES_STATS"


#' @title Fiber-type-specific measures
#'
#' @description A \code{data.frame} containing fiber-type-specific measures:
#'   fiber type cross-sectional area (CSA) and fiber count.
#'
#' @usage FIBER_TYPES
#'
#' @seealso \code{\link{FIBER_TYPES_EMM}}, \code{\link{FIBER_TYPES_STATS}}
#'
#' @examples
#' print.data.frame(head(FIBER_TYPES))
#'
#' @keywords datasets
"FIBER_TYPES"


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
#' @description A \code{data.frame} containing statistical analysis results of
#'   muscle-specific measures: terminal muscle mass, mean cross-sectional area
#'   (CSA), glycogen, capillary contacts, and citrate synthase.
#'
#' @usage MUSCLES_STATS
#'
#' @seealso \code{\link{MUSCLES}}, \code{\link{MUSCLES_EMM}}
#'
#' @examples
#' unique(MUSCLES_STATS$response)
#'
#' print.data.frame(head(MUSCLES_STATS))
#'
#' @keywords datasets
"MUSCLES_STATS"


#' @title Muscle-specific measures
#'
#' @description A \code{data.frame} containing muscle-type specific measures
#'   taken from medial gastrocnemius (MG), lateral gastroc (LG), plantaris (PL),
#'   and soleus (SOL): terminal muscle mass, mean cross-sectional area (CSA),
#'   glycogen, capillary contacts, and citrate synthase.
#'
#' @usage MUSCLES
#'
#' @seealso \code{\link{MUSCLES_EMM}}, \code{\link{MUSCLES_STATS}}
#'
#' @examples
#' print.data.frame(head(MUSCLES))
#'
#' @keywords datasets
"MUSCLES"


#' @title NMR body composition measures
#'
#' @description A \code{data.frame} containing measures of body composition
#'   (total body mass, body fat, %% body fat, lean mass, and %% lean mass) both
#'   pre- and post-training.
#'
#' @usage NMR
#'
#' @seealso \code{\link{PHYSIO}}, \code{\link{PRE_POST_STATS}}
#'
#' @examples
#' print.data.frame(head(NMR))
#'
#' @keywords datasets
"NMR"


#' @title All physiology data
#'
#' @description All physiology measures combined into a single
#'   \code{data.frame}.
#'
#' @usage PHYSIO
#'
#' @examples
#' head(PHYSIO)
#'
#' @keywords datasets
"PHYSIO"


#' @title Statistical analysis results of post - pre training differences
#'
#' @description A \code{data.frame} containing statistical analysis results of
#'   post - pre training differences: NMR body mass, lean mass, fat mass, %% lean
#'   mass, %% fat mass; difference between terminal and pre-training NMR mass at
#'   1W and 2W of endurance training; absolute VO\eqn{_2}max; relative
#'   VO\eqn{_2}max; and maximum run speed.
#'
#' @usage PRE_POST_STATS
#'
#' @seealso \code{\link{PHYSIO}}
#'
#' @examples
#' unique(PRE_POST_STATS$response)
#'
#' print.data.frame(head(PRE_POST_STATS))
#'
#' @keywords datasets
"PRE_POST_STATS"


#' @title VO2max test measures
#'
#' @description A \code{data.frame} containing measures from the pre- and
#'   post-training VO\eqn{_2}max tests: total body mass, absolute and relative
#'   VO\eqn{_2}max, respiratory exchange rate (RER), VCO\eqn{_2}, maximum run
#'   speed, blood lactate, and test duration.
#'
#' @usage VO2MAX
#'
#' @seealso \code{\link{PHYSIO}}
#'
#' @examples
#' print.data.frame(head(VO2MAX))
#'
#' @keywords datasets
"VO2MAX"


#' @title Weekly body weight and blood lactate measures
#'
#' @description A \code{data.frame} containing weekly measures of total body
#'   mass and blood lactate.
#'
#' @usage WEEKLY_MEASURES
#'
#' @seealso \code{\link{PHYSIO}}
#'
#' @examples
#' print.data.frame(head(WEEKLY_MEASURES))
#'
#' @keywords datasets
"WEEKLY_MEASURES"


#' @title Body mass recorded on different days
#'
#' @description A \code{data.frame} containing measures of total body mass (in
#'   grams) recorded on different days (pre- and post-training measures
#'   included, if applicable): NMR, VO\eqn{_2}max, and day of sacrifice.
#'
#' @usage WEIGHTS
#'
#' @seealso \code{\link{PHYSIO}}
#'
#' @examples
#' print.data.frame(head(WEIGHTS))
#'
#' @keywords datasets
"WEIGHTS"

