//
//  MovieCategory.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import SwiftUI

struct MovieCategory: View {
    let title: String
    let movies: [Movie]
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(movies) { movie in
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
            .padding()
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(title)
    }
}

// MARK: Movie Category Preview
struct MovieCategory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieCategory(
                title: "Top Rated",
                movies: [
                    Movie(
                        title: "Extraction",
                        year: "2020",
                        genre: ["Action"],
                        director: "Sam Hargrave",
                        actors: ["Chris Hemsworth", "Randeep Hooda"],
                        plot: "Sample plot",
                        poster: "https://sample-movie-poster.jpg",
                        language: ["English"],
                        ratings: [
                            Movie.Rating(source: "IMDB", value: "6.8/10"),
                            Movie.Rating(source: "Rotten Tomatoes", value: "67%")
                        ]
                    ),
                    Movie(
                        title: "Extraction",
                        year: "2020",
                        genre: ["Action"],
                        director: "Sam Hargrave",
                        actors: ["Chris Hemsworth", "Randeep Hooda"],
                        plot: "Sample plot",
                        poster: "https://sample-movie-poster.jpg",
                        language: ["English"],
                        ratings: [
                            Movie.Rating(source: "IMDB", value: "6.8/10"),
                            Movie.Rating(source: "Rotten Tomatoes", value: "67%")
                        ]
                    ),
                ]
            )
        }
    }
}
