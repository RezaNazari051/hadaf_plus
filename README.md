
# Todo List App ( Hadaf Plus )

This is a simple Todo List application developed using **Flutter**. The application allows users to manage their tasks with features such as adding new tasks, marking tasks as complete/incomplete, and deleting tasks.

## Features
- **View Tasks**: View a list of tasks with their status (completed or not).
- **Add Tasks**: Add a new task with a title.
- **Update Task Status**: Mark tasks as completed or incomplete.
- **Delete Tasks**: Delete a task from the list.

## Screenshots


<p align="center">
  <img src="https://s8.uupload.ir/files/screenshot_1729258814_m4jy.png" alt="Todo List - View Tasks" width="250"/>
  <img src="https://s8.uupload.ir/files/screenshot_1729258816_bqd.png" alt="Todo List - Actions" width="250"/>
  <img src="https://s8.uupload.ir/files/screenshot_1729258821_pb45.png" alt="Todo List - Add Task" width="250"/>
</p>
## Web Demo

You can try the **web demo** of this app [here](https://todo-app-6a798.web.app/).

## Project Structure

The project follows **Clean Architecture** principles, where the code is divided into different layers:
- **Data Layer**: Handles API requests and data models.
- **Domain Layer**: Contains business logic and use cases.
- **Presentation Layer**: Manages UI and state.

### State Management

The app uses **Bloc** for state management, which separates the business logic from the UI. We have also used **Get_it** for **dependency injection** to handle different instances and services in the app.

### Why Bloc instead of GetX?

Although the original project requirement mentioned **GetX** for state management, I didn't have prior experience working with GetX. Given the options between **Provider** and **Bloc**, I chose **Bloc** because it offers a more structured and scalable way to manage state and business logic in larger applications. Additionally, Bloc's event-driven architecture helps maintain clear separation between business logic and the UI.

## Setup

To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/RezaNazari051/hadaf_plus
   ```

2. Navigate to the project directory:
   ```bash
   cd hadaf_plus
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## API

The app uses the **DummyJSON API** to perform CRUD operations on the todo list.

API Documentation: [https://dummyjson.com/docs/todos#todos-all](https://dummyjson.com/docs/todos#todos-all)

## Dependencies

- **Flutter Bloc**: State management.
- **Get_it**: Dependency injection.
- **Dio**: For API integration.
