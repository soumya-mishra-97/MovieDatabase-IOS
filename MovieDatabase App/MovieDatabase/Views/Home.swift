//
//  Home.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//


import SwiftUI

struct Home: View {
    @StateObject var viewModel = MovieViewModel()
    @State private var expandedSections: Set<String> = []
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Movie Database")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.vertical, 10)
                    
                    Divider()
                        .background(Color.gray)
                        .frame(height: 1)
                        .padding(.horizontal).padding(.bottom, 20)
                    
                    /// Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search movies by title/actors/genre/directors", text: $viewModel.searchText).font(.system(size: 16))
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(10)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    if viewModel.searchText.isEmpty {
                        /// Categories Section
                        VStack(spacing: 0) {
                            categorySection(title: "Year", items: viewModel.getUniqueYears())
                            categorySection(title: "Genre", items: viewModel.getUniqueGenres())
                            categorySection(title: "Directors", items: viewModel.getUniqueDirectors())
                            categorySection(title: "Actors", items: viewModel.getUniqueActors())
                            categorySection(title: "All Movies", items: ["All Movies"])
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    } else {
                        /// Search Results
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredMovies) { movie in
                                MovieCard(movie: movie, isExpanded: selectedMovie?.id == movie.id)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedMovie = selectedMovie?.id == movie.id ? nil : movie
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                
                                if selectedMovie?.id == movie.id {
                                    MovieDetail(movie: movie)
                                        .padding(.horizontal)
                                        .padding(.bottom, 8)
                                        .transition(.opacity.combined(with: .slide))
                                }
                                
                                Divider()
                                    .padding(.leading)
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))

        }
    }
    
    /// Movie Category List View
    private func categorySection(title: String, items: [String]) -> some View {
        VStack(spacing: 0) {
            /// Category Header
            HStack {
                Text(title)
                    .font(.system(size: 18))
    
                Spacer()
                
                Image(systemName: expandedSections.contains(title) ? "chevron.up" : "chevron.down")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    if expandedSections.contains(title) {
                        expandedSections.remove(title)
                    } else {
                        expandedSections.insert(title)
                    }
                }
            }
            
            // Category Items
            if expandedSections.contains(title) {
                VStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: MovieCategory(
                            title: item,
                            movies: getMoviesForCategory(title: title, item: item)
                        )) {
                            HStack {
                                Text(item)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                        
                        if item != items.last {
                            Divider()
                                .padding(.leading)
                        }
                    }
                }
            }
            
            if title != "All Movies" {
                Divider()
            }
        }
    }
    
    private func getMoviesForCategory(title: String, item: String) -> [Movie] {
        switch title {
        case "Year": return viewModel.getMoviesForYear(item)
        case "Genre": return viewModel.getMoviesForGenre(item)
        case "Director": return viewModel.getMoviesForDirector(item)
        case "Actor": return viewModel.getMoviesForActor(item)
        case "All Movies": return viewModel.movies
        default: return []
        }
    }
}

// MARK: Home Preview
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(MovieViewModel())
            .previewDevice("iPhone 14 Pro")
    }
}
