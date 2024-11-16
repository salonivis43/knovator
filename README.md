# knovator

# Flutter Post Detail App

## Overview
This Flutter application is designed to display detailed information about a post fetched from a remote API. The app allows users to view the title and body of a post in an attractive, user-friendly interface. The data is fetched dynamically via HTTP requests using the `http` package.

## Features
- Display a list of posts fetched from the API.
- View detailed information for each post by navigating to a detail screen.
- Handle loading, error, and data states gracefully.

## Architectural Choices
This project follows a simple MVC (Model-View-Controller) pattern. The architecture consists of:
- **Model:** `Post` class to represent the data structure of each post.
- **View:** UI components using Flutter widgets (e.g., `Scaffold`, `Text`, `Card`).
- **Controller:** `ApiService` class to handle API calls and data fetching.

### Key Components
- **Post Model:** Represents the structure of a post with fields like `userId`, `id`, `title`, and `body`.
- **ApiService:** Handles the HTTP requests and fetching data from the API.
- **PostDetailScreen:** Displays the detailed view of a single post using data fetched from the API.

## Libraries Used
- **http:** For making network requests to fetch posts from a remote server.
- **flutter:** The primary framework for building the app, providing a rich set of pre-designed widgets for building the UI.

## Prerequisites
- **Flutter SDK**: The Flutter framework must be installed on your system. Follow the instructions in the official [Flutter documentation](https://flutter.dev/docs/get-started/install) to set up Flutter on your machine.
- **Android Studio or Visual Studio Code**: A code editor to write and run your Flutter application.
  
## Setup Instructions

### Clone the Repository
1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/salonivis43/knovator.git
    ```
  
### Install Dependencies
2. Navigate to the project directory:
    ```bash
    cd flutter-post-detail-app
    ```

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

### Run the Application
4. Connect a device (real or emulator) and run the app:
    ```bash
    flutter run
    ```

## Screenshots

| Post Detail | List of Posts |
![image](https://github.com/user-attachments/assets/aa95b478-a556-45bc-b63d-a85990d544d6)
![image](https://github.com/user-attachments/assets/77ceec99-86b9-4cf6-a72c-abb222e285e3)



## Repository

