![beware - work in progress](docs/src/assets/wip.png)
[![CI](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/CI.yml/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/CI.yml)

[![Documentation](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/Documentation.yml/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/Documentation.yml)

[![pages-build-deployment](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/pages/pages-build-deployment)

This is meant to become a prototype of a bitemporal data management system for life insurance. For theoretical background and generic aspects of the model look at the project for its persistence kernel https://github.com/michaelfliegner/BitemporalPostgres.jl.

We start with a structure only model without domain specific attributes, for a beginning concentrating on editing (using the API for now) and displaying the bitemporal model. The aim is to eventually
* include a tariff calculator based on examples from https://github.com/JuliaActuary/LifeContingencies.jl and to
* provide a reactive GUI based on Stipple: https://github.com/GenieFramework/Stipple.jl 
* Protypically provide complete workflows for managing life insurance contracts.

![Contract model](docs/src/assets/BitemporalModel.uxf.png)

# Screenshots
For the script populating the database for these pages [see: test/testsCreateContract.jl]( test/testsCreateContract.jl)
![Contract model](docs/src/assets/ContractsPage.PNG)
![Contract model](docs/src/assets/Historypage.PNG)
History page unfolded, showing also shadowed, i.e. retrospectively corrected versions
![Contract model](docs/src/assets/HistorypageUnfolded.PNG)b
![Contract model](docs/src/assets/CsectionPage.PNG)
