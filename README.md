# Favbet Test Task - Movie App 🎬

A new Flutter project.
A Flutter application that displays a list of top-rated movies with search functionality, favorites management, and theme switching.

## Getting Started

## 📱 Features

This project is a starting point for a Flutter application.

### Core Features

A few resources to get you started if this is your first Flutter project:

- **Top Rated Movies List** - Browse the best movies in a grid layout
- **Movie Details** - View detailed information about each movie
- **Favorites System** - Add/remove movies to/from favorites with local persistence
- **Search** - Find movies with debounced search
- **Pagination** - Navigate through multiple pages of movies
- **Theme Switching** - Toggle between light and dark themes
- **Theme Persistence** - Your theme preference is saved locally

### Technical Highlights

- Clean Architecture implementation with clear separation of concerns
- Feature-based project structure
- Riverpod for state management
- Go Router for navigation
- Dio for HTTP requests with authentication interceptor
- Local data persistence using SharedPreferences

## 🏗️ Architecture

The project follows **Clean Architecture** principles with three distinct layers:

```
lib/
├── features/
│   ├── movies/
│   │   ├── data/              # Data layer
│   │   │   ├── data_sources/  # Remote & Local data sources
│   │   │   ├── models/        # Data models
│   │   │   └── repositories/  # Repository implementations
│   │   ├── domain/            # Domain layer
│   │   │   ├── entities/      # Business entities
│   │   │   ├── repositories/  # Repository interfaces
│   │   │   └── use_cases/     # Business logic
│   │   └── presentation/      # Presentation layer
│   │       ├── controllers/   # State management (Riverpod)
│   │       ├── pages/         # Screen widgets
│   │       └── widgets/       # Reusable UI components
│   └── theme/
│       └── [same structure]
├── env.dart                   # Environment configuration
└── main.dart                  # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.8.1)
- Dart SDK
- An API key from [The Movie Database (TMDB)](https://www.themoviedb.org/settings/api)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd favbet_test_task
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up environment variables**

   Create a `.env` file in the project root:

   ```env
   MOVIE_API_KEY=your_tmdb_api_key_here
   MOVIE_API_HOST=https://api.themoviedb.org/3
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 Screens

### Home Page

- Displays top-rated movies in a 2-column grid
- Shows movie poster, title, and rating
- Favorite indicator on each card
- Search button in AppBar
- Theme toggle in AppBar
- Pagination controls at the bottom

### Search Page

- Search input with debouncing (250ms)
- Real-time search results
- Result count display
- Same grid layout as home page
- Infinite scroll pagination

### Movie Details Page

- Large movie poster
- Movie title in AppBar
- Rating display
- Full movie overview/description
- Release date
- Add/Remove from favorites button

## 🐛 Known Limitations

- No offline mode (requires internet connection)
- Search requires minimum 3 characters (as per requirements)
- No error toast notifications (errors are handled silently)

## 📄 License

This is a test task project for Favbet.

## 👨‍💻 Author

Created as a technical assessment for Favbet.

---

## 🎯 Test Task Requirements Checklist

- [x] Display top-rated movies in grid (2 columns)
- [x] Show poster, title, and rating
- [x] Movie details screen with all required fields
- [x] Add/Remove favorites functionality
- [x] Local persistence of favorites
- [x] Search functionality with debouncer
- [x] Search starts from 3 characters
- [x] **Bonus:** Pagination implementation
- [x] **Bonus:** Theme switching (light/dark)
- [x] **Bonus:** Theme caching

Built with ❤️ using Flutter
