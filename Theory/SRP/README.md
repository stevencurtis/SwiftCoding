# Organizing iOS Files Based on the Clean Architecture
## Separation of Concerns

In any iOS application, knowing *what should go where* is an essential way of organizing code and making sure our code is maintainable for the future.
How you should organize the key components and files within an iOS application then?
Here is a roadmap of how I think you could  organize files within your application, and maintain a **separation of concerns** that can improve maintainability within any given iOS application. Based on the *clean* architecture here is the organization system you might use if creating an all-new greenfield application.

# View
## Purpose
Handles UI rendering and displaying content. In SwiftUI, it would be a struct conforming to View. In UIKit, it could be UIView subclasses.

## Responsibilities
Display data passed from the **ViewModel** or **ViewController**.
Handle user interactions (e.g., button taps) and forward those to the **ViewModel** or **ViewController**.
Should not contain business logic.

## Example Files
`MovieListView.swift` (SwiftUI)
`CustomButtonView.swift` (UIKit)

# ViewController (UIKit)
## Purpose
Manages the lifecycle of views, binds data from **ViewModel** (in MVVM) or directly controls the views (in MVC), and initiates data fetching from the **ViewModel** or **Interactor**.

## Responsibilities
Manage the display logic (setting up views, handling view states).
Respond to user interactions (e.g., handling actions like taps or gestures).
Initiate data fetching by interacting with the **ViewModel** or **Interactor**.
Manage transitions between different screens (though this can be offloaded to a **Coordinator**).

## SwiftUI
There is no ViewController in SwiftUI. Some of the ViewController responsibilities in UIKit are handled in the view when using SwiftUI. In essence, SwiftUI folds the responsibilities of the ViewController into the View itself.

In SwiftUI lifecycle management is provided through view modifiers such as `.onAppear()` and `.onDisappear()`. The view in SwiftUI also responds to state changes using property wrappers like `@State`, `@Binding` and `@Observable`. Similarly in SwiftUI the view directly manages user input via bindings or event handlers. SwiftUI manages view state directly within the view (conditionally hiding views, for example).

**Example Files:**

`MovieListViewController.swift`
`ProfileViewController.swift`

# ViewModel
## Purpose
Holds presentation logic and transforms domain data into something the **View** or **ViewController** can display.

## Responsibilities
Fetch data from the **Interactor** or **Repository** and format it for the **View**.
Handle data transformations and logic specific to presenting data (e.g., formatting dates, calculating view states).
Bind to the View to reflect updates.

**Example Files:**
'MovieListViewModel.swift'
'UserProfileViewModel.swift'

# Coordinator
## Purpose
Manages the navigation between different screens and flow of the app. This allows the **ViewController** to focus on managing views and not handling transitions.

## Responsibilities

Coordinate navigation and handle transitions between **ViewControllers** or **Views**.

Ensure that different screens flow together correctly, based on user interaction.

**Example Files:**
`AppCoordinator.swift`
`MovieFlowCoordinator.swift`

# Interactor
## Purpose
Acts as a bridge between the **ViewModel** and the **Repository** or **Service**, ensuring that business rules are applied.

## Responsibilities
Execute specific **use cases** (like "fetch movies" or "update profile").
Apply business rules before or after fetching data from the **Repository**.
Orchestrate the data flow between the presentation layer (**ViewModel**) and the data layer (**Repository**).

**Example Files:**
`FetchMovieDetailsInteractor.swift`
`UpdateUserProfileInteractor.swift`

# Repository
## Purpose
Serves as a universal interface for data sources, abstracts the underlying data source (network, database, cache), and provides data to the **Interactor**.

##Responsibilities
Fetch and persist data, whether from a local or remote source (e.g., databases, APIs).
Abstract away the details of where the data comes from.
Return **Entities** or domain models to the **Interactor**.

**Example Files**
`MovieRepository.swift`
`UserRepository.swift`

# Service
## Purpose
Handles communication with external data sources (e.g., APIs, databases). It can have multiple endpoints as long as they are logically connected.

## Responsibilities
Interact directly with network APIs or local databases.
Send HTTP requests, receive responses, and handle the technical details of networking (like authentication, retries, error handling).

**Example Files**
`MovieAPIService.swift`
`UserLocalStorageService.swift`

# Entity
## Purpose
Represents core concepts and business models (domain-specific models like User, Movie, etc.). These models should be free from any dependencies on the UI or data layer.

##Responsibilities
Define the properties and behaviors of real-world entities that your app deals with.
Act as the bridge between raw data (from APIs, databases) and domain logic.

**Example Files**
`Movie.swift`
`User.swift`

# Example Breakdown of iOS Project Files

```swift
├── Views
│   ├── MovieListView.swift
│   └── ProfileView.swift
├── ViewControllers
│   ├── MovieListViewController.swift
│   └── ProfileViewController.swift
├── ViewModels
│   ├── MovieListViewModel.swift
│   └── ProfileViewModel.swift
├── Coordinators
│   ├── AppCoordinator.swift
│   └── MovieFlowCoordinator.swift
├── Interactors
│   ├── FetchMovieDetailsInteractor.swift
│   └── UpdateUserProfileInteractor.swift
├── Repositories
│   ├── MovieRepository.swift
│   └── UserRepository.swift
├── Services
│   ├── MovieAPIService.swift
│   └── UserLocalStorageService.swift
├── Entities
│   ├── Movie.swift
│   └── User.swift
```

# Conclusion

This is my interpretation of the 'clean architecture'. It's not guaranteed to be correct (what is) and you might have your own interpretation.

