# Clean Architecture layers for iOS Swift apps
## The Common Layers

Here's an overview of the main layers commonly found in **Clean Architecture** when coding iOS apps in Swift.

# The Clean Architecture
In the clean architecture each layer has its own specific responsibilities, ensuring **separation of concerns** and better **testability** than other architectures.

In a typical **Clean Architecture** for iOS (or any other platform), there are several **layers** that are part of a multi-layered system that combine to create an app.

**The Dependency rule**

According to Uncle Bob, the key to this that source code dependencies can only point inwards on the diagram above. That means a view controller knows and calls a view model, but a view model cannot know anything about a view controller in the world of iOS.

# 1. Presentation Layer (UI Layer)
## Responsibilities

This layer is responsible for displaying data to the user and handling user interactions. It includes **Views, ViewModels**, and **Controllers** (e.g., in **MVVM**, **MVC**, or **VIPER** patterns).

## Components
**Views**: UI components (e.g., SwiftUI or UIKit views) that handle user interface rendering and interaction.

**ViewModel/Controller**: The components that handle presentation logic, prepare data for the UI, and react to user actions (e.g., transforming data into a user-friendly format).

## Interaction with Other Layers
The presentation layer communicates with the domain or application layer (e.g., via a **ViewModel** or **Presenter**), often requesting data to display.

# 2. Domain Layer (Business Logic Layer)
## Responsibilities

The domain layer contains the **core business logic** and **domain models** of the application. It doesn't know anything about the underlying data sources (e.g., network, databases). It focuses on **use cases** or **interactors** and pure business rules.

## Components
**Entities**: Core business objects (e.g., `User`, `Transaction`, `Movie`). These are domain-specific models that represent real-world concepts.

**Use Cases (Interactors)**: This is where the business logic lives. Use cases coordinate the flow of data between repositories and the presentation layer.

## Interaction with Other Layers
The domain layer interacts with the **data layer** through **repositories**, making requests for data to fulfil use cases.

# 3. Data Layer (Repository Layer)

## Responsibilities
The data layer is responsible for handling **data access**, whether from **remote sources** (like APIs), **local databases**, or **caches**. The data layer abstracts these details from the domain layer by providing a unified **repository** interface.

## Components
**Repositories**
The repository pattern abstracts the data sources (**network, database, cache**) and provides the necessary data in the form of **domain entities**. Repositories manage data retrieval and persistence and may interact with the **network layer** or **database layer**.

## Data Mappers
These components may convert raw data (e.g., DTOs from the network) into **domain entities** and vice versa.

## Interaction with Other Layers
The repository is responsible for interacting with **services** in the **network layer** or **local storage layer** to fetch and store data. The **domain layer** (via use cases) calls the **repository** when it needs data.

# 4. Network Layer

## Responsibilities
The network layer handles all **external API calls** and other network operations. It abstracts the details of **HTTP requests**, **authentication**, and **error handling** from higher layers, like **repositories**.

## Components
**API Services or Managers**: These components are responsible for making the HTTP requests (e.g., via URLSession) and returning the results. They handle the technical aspects of networking, such as headers, authentication, retries, and error handling.

**DTOs (Data Transfer Objects)**: These are lightweight objects used to send data between the network layer and the data layer. The API responses are often received in the form of DTOs, which are then passed to repositories for transformation.

## Interaction with Other Layers
The **network layer** interacts with the **data layer** (**repositories**). The **repositories** request data from the API services when needed and receive raw data (e.g., **JSON**, **DTOs**).

# 5. Persistence Layer (Storage Layer)
## Responsibilities

The persistence layer handles all **local data storage**, whether in the form of a database (e.g., **CoreData**, **Realm**, **SQLite**), **user defaults**, or even files.

## Components
**Database Managers**: Components that manage local data storage, provide access to stored data, and perform queries.
**Cache Managers**: Handle in-memory caching or disk-based caching, used to store data temporarily for faster access.

## Interaction with Other Layers
The **data layer** (**repositories**) often interact with the persistence layer to store or retrieve data. For example, repositories may first check the cache or database before making a network request.

# 6. Infrastructure/Utilities Layer (Optional)
## Responsibilities
This layer can be used to provide cross-cutting concerns like **logging**, **analytics**, **authentication management**, or other **services** that may be used across the app.

## Components
**Logging**: Centralized logging to track application events and errors.
**Authentication/Session Managers**: Handle user authentication, tokens, and session management.
**Analytics Services**: Services that track user behavior and send analytics data.

-----

# An Example Data Flow
**"A streaming movie application, much like Netflix."**

## Presentation Layer
The **view / view controller** displays the data about the movies in a compelling form.

The **view model** requests data from the **domain layer** (e.g., "Get Movie Details") and presents it in the form of a **view object** for the view to display.

## Domain Layer 
The **use case** (alternatively known as an **interactor**) calls a **repository** in the **data layer** to retrieve movie details.

The **use case / interactor** applies any business rules (e.g., filtering or validation) and passes the movie entity to the **view model**.

## Data Layer
The **repository** handles the data.

The movie application uses **cached** data (from the persistence layer) to keep performance high, and the **repository** checks for that **cached** data. If no **cached** data is found, it requests the data from the **network layer**.

## Network Layer
The **API service** makes an HTTP **request** to an external API to obtain a list of movies and retrieves raw JSON data, which is mapped to a **Data Transport Object** (DTO) - in this case an array of `MovieDTO` objects.

## Data Layer
The repository transforms the **DTO** into a **domain entity** (e.g., `Movie`) and returns it to the **use case**.

# Conclusion
That's my interpretation of the clean architecture for iOS. Take a look, and get back to me if you've any questions.
