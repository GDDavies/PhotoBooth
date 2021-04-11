# PhotoBooth

##  Installation Instructions

There are no third-part dependencies used in this project so just open the `.xcodeproj` file and run the app on your physical device (the app doesn't fully function on a simulator due to a lack of cameras).

##  Approach

This is a basic MVP which has the requested functionality:

* Take and name a photo
* View all previously taken photos along with their names and date/time taken

### Architecture

The app uses MVVM architecture along with:

* Database service to save and fetch objects
* Repository service to save and fetch objects. If we were to have an API service to perform network requests we could also store this here. For example if we wanted to use the database as a cache but to get final images from a remote endpoint.
* Interactor to perform any logic on the repository results, or before passing on the user's image to the repository

### UI

No storyboards/XIBs have been used in the project because fully programmatic constraints and views are more scalable. XML files can cause major conflicts when multiple devs are working on them, they're also difficult to understand when viewing code changes in pull requests.

`UIStackViews` have been used where possible to simplify constraints.

The app works in both light and dark mode.

##  Future updates

* Improve performance when tapping on `Take photo`, to do with the initialization and setup of `CameraController`
* More tests, for example converting Dto to domain object and tests for `CameraController`
* Validation on image name, for example name minimum and maximum length
* Database fetch paging so if the user has a large number of photos stored we can fetch a limited number per request
* Wrapper around the CoreData implementation to allow easier saving/fetching of different types
* Empty state for when the user has no saved photos
* Ability to delete photos
* Correctly scaled thumbnail, currently it is square-shaped while the original image is a rectangle
* The navigation bar when taking a picture is clear so it can be hard to see the back button
* Many more...
