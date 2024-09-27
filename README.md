# news_wave

A new Flutter project.

## Getting Started

This application is designed to provide users with the latest news updates in a streamlined and user-friendly manner. Upon first launch, users are prompted to enter their first and last name on a login screen. Afterward, the app requests permission to send notifications. The main news feed presents a list of articles, and users can tap on any item to view the full article in an integrated in-app browser, seamlessly linking to the web.

From a technical perspective, the app follows Clean Architecture principles, separating the presentation, business logic, and data layers for better maintainability and scalability. Dependency injection is utilized to manage object creation in a centralized manner, enhancing modularity and testability. Shared Preferences are employed to store user data locally, so after the initial login, users are not required to enter their details again, enhancing the overall user experience by offering a persistent login state.

By leveraging local storage, the app significantly improves convenience and ensures a smoother user journey, making it more intuitive and efficient for returning users.
