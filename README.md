# Modiriyate Makharej
This is an expence tracking application.

#Folder Structure
Where to put the file you want to create?
How to find the file you're looking for?


## Core
anything that can not be divided as a feature, goes into core directory. including: 

* Navigation
* Theming
* firebase Option file
* constant values
* App Widget
* Internationalization

## Feature
we seperate each feature into user interface and state management (UI) and business logic + getting data from local or remote sources (provider) and models

## UI is seperated into state management (bloc) and anything visible on screen (view)

## Implementing a new feature:
Bloc is used in this project as state management solution. Local blocs are added in router.dart class, which make the code easier to read as every local bloc is gethered around in one file.
initial state of a bloc should be implemented in it's constructor inside that bloc's file.
State management and business logic is bloc's responsiblity in this project.

If a state is used in many screens globaly, it should be added as global bloc in root of the widget tree.

repository classes (like in [authService.dart]) should be added to repository provider widget in [app.dart] file. They are responsible for getting data from local and remote data sources. 




