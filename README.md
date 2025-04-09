
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MEAanalysis

<!-- badges: start -->
<!-- badges: end -->

The multi-electrode array technique (MEA) produces a high quantity of
data relating to excitable cell activity. This data can often be complex
and time-consuming to analyse in a reproducible manner. Furthermore,
limited resources are available to calculate burst parameters for
individual electrodes as opposed to the whole well. The MEAanalysis
package provides functions which can assist with MEA data analysis and
exploration at the single electrode level, through downstream
visualisation of electrode burst list files produced by AxIS Navigator
3.6.2 software (Axion BioSystems), whilst enabling comparison of
bursting parameters between different time intervals. This package has
been designed to be compatible with 12- and 24- well MEA plates.

The package can be installed from gitHub using
devtools::install_github(“egordon2/MEA-analysis-package/MEAanalysis”) or
by cloning the repository
(<https://github.com/egordon2/MEA-analysis-package>). It is possible the
user will need to update existing packages to conform with the package
dependencies, however they should be notified of this in the terminal.
Once the package is installed it can be loaded using the
library(“MEAanalysis”) command.

If the user requires workflow vignettes to be included in the package
then they should run the
devtools::install_github(“egordon2/MEA-analysis-package/MEAanalysis”,
build_vignettes = TRUE) command during installation, ensuring the
build_vignettes argument is included. These vignettes can then be viewed
directly in R studio using the vignette(package=“MEAanalysis”) command.

Example workflows to demonstrate how this package may be used to analyse
MEA data have also been provided on the package website available here:
<https://egordon2.github.io/MEA-analysis-package/>. Please see the
function help pages for more detailed information on their purpose and
arguments.
