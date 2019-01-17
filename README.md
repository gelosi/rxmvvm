# rxmvvm
_playground for using rx swift and combine with mvvm approach_

**WARNING:** you need a proper Yelp API key to play with the demo, otherwise app will crash asking for it!

## basic app structure

dependencies (via cocoapods)
- using RxSwift
- using RxMKMapView

### network layer

network is built to abstract from the implementation, I've used `URLSession` concept of tasks as a high level concept, and it plays well with the most of network implementations we have now for iOS, so, we can use either URLSession itself, or Alamofie, or something else to cover our network needs

Goal on networking layer is to introduce also concept of endopoints: therefore, we will be able to create and test requests without need of creating and testing network layer implementation, only "our" part

### data sources

Data sources are designated to manipulate low-level data transfers (via network or files, user defaults, ect) and should incapsulate parsing/serialization logic, data mingling, scoped with concrete need.
This app is reading data  from Yelp, so, all communication with Yelp is behind `RestaurantsDataSource` class.
Also, pay attention `RestaurantsDataSource` is using an abstraction of network, so, we can test data source independently, also we can swap networking for something else (like files) if we want it.

###  view models

View models should incapsulate the knowledge about it's data sources, and how to load/store data. Also, it's a nice place to provide default data for the case when data source is not yet ready, or we have some delays loading.


