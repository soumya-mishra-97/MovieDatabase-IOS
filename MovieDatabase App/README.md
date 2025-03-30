# Movie Database App

### Cricbuzz Assessment

## Overview

- This is a SwiftUI-based iOS application that allows users to browse, search, and view movie details using a structured MVVM architecture.

## Features

### Category Filters:
```
- Users can browse movies by Year, Genre, Directors, and Actors.

- Categories expand/collapse to show related movies.

- "All Movies" displays a list of all available movies with a thumbnail, title, language, and year.
```

### Search Functionality:
```
- Users can search for movies by title, genre, actor, or director.

- If a search query is entered, a list of matched movies is displayed.

- Clearing the search restores the main category view.
```

### Movie Details:
```
- Displays movie poster, title, plot, cast & crew, release date, genre, and rating.

- Users can select a rating source (IMDB, Rotten Tomatoes, Metacritic) to view ratings.

- Custom UI control to display the selected rating value.
```

## Project Structure
```
MovieDatabaseApp/
├── MovieDatabase/
│   ├── Models/
│   │   ├── Movie.swift
│   ├── Utils/
│   │   ├── Rating.swift
│   ├── ViewModels/
│   │   ├── MovieViewModel.swift
│   ├── Views/
│   │   ├── Home.swift
│   │   ├── MovieCard.swift
│   │   ├── MovieCategory.swift
│   │   ├── MovieDetail.swift
├── Resources/
│   ├── movies.json
├── MovieDatabaseAppApp.swift
```

## Notes
- This project is developed specifically for the `Cricbuzz Assessment`.

- `movies.json` in the Resources folder.
