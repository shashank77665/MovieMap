# Movie Search Flutter App

A Flutter application that allows users to search for movies by title and view detailed information about selected movies. The app integrates with a public movie API to provide users with up-to-date movie details.

## Features

-   Search movies by title.
-   Display a list of movies matching the search query.
-   View detailed information about a selected movie, including:
    -   Title
    -   Release date
    -   Genre
    -   Ratings
    -   Cast and crew information (if available).

## Screenshots

### Home Screen

Search for movies by title and see a list of results.

<img src="screenshot/screenshot_1.png" width="300" alt="Home Screen">

### Search Results

View the search results, showing movie posters, titles, and release dates.

<img src="screenshot/screenshot_2.png" width="300" alt="Search Results">

### Movie Details

Select a movie to view detailed information, including a synopsis, rating, and cast.

<img src="screenshot/screenshot_3.png" width="300" alt="Movie Details">

## Getting Started

### Prerequisites

-   Flutter SDK installed. You can follow the official [Flutter setup guide](https://flutter.dev/docs/get-started/install).
-   An API key for a movie database (e.g., The Movie Database API).

### Installation

1.  Clone this repository:

    ```bash
    git clone https://github.com/shashank77665/MovieMap.git
    ```

2.  Navigate to the project directory:

    ```bash
    cd movie-search-flutter-app
    ```

3.  Install dependencies:

    ```bash
    flutter clean
    flutter pub get
    ```

4.  Add your API key by editing the configuration file (`lib/api_key.dart` or similar).

5.  Run the app:

    ```bash
    flutter run
    ```

## Technologies Used

-   **Flutter** - For building the UI and app logic.
-   **Dart** - Programming language used for Flutter development.
-   **Movie API** - Fetches real-time data about movies.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.
