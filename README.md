![beware - work in progress](docs/src/assets/wip.png)
[![CI](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/CI.yml/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/CI.yml)

[![Documentation](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/Documentation.yml/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/Documentation.yml)

[![pages-build-deployment](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/michaelfliegner/BitempWebApp/actions/workflows/pages/pages-build-deployment)

This is meant to become a prototype of a bitemporal data management system for life insurance. We start with a structure only model without domain specific attributes, for a beginning concentrating on editing (using the API for now) and displaying the bitemporal model.

![Contract model](docs/src/assets/BitemporalModel.uxf.png)

# Screenshots
For the script populating the database for these pages [see: test/test.jl]( test/tests.jl)

![Contract model](docs/src/assets/ContractsPage.PNG)
![Contract model](docs/src/assets/HistoryPage.PNG)
History page showing also shadowed, i.e. retrospectively corrected versions
![Contract model](docs/src/assets/HistoryPageUnfolded.PNG)
![Contract model](docs/src/assets/CsectionPage.PNG)

For theoretical background and generic aspects of the model look at the project for its persistence kernel

https://github.com/michaelfliegner/BitemporalPostgres.jl
