//
//  ModelViewModel.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMovies()
        setupSearch()
    }
    
    private func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        do {
            movies = try JSONDecoder().decode([Movie].self, from: data)
            filteredMovies = movies
        } catch {
            print("Error decoding movies: \(error)")
        }
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { text in
                text.isEmpty ? self.movies : self.movies.filter {
                    $0.title.localizedCaseInsensitiveContains(text) ||
                    $0.genre.contains { $0.localizedCaseInsensitiveContains(text) } ||
                    $0.director.localizedCaseInsensitiveContains(text) ||
                    $0.actors.contains { $0.localizedCaseInsensitiveContains(text) }
                }
            }
            .assign(to: &$filteredMovies)
    }
    
    func getUniqueYears() -> [String] {
        Array(Set(movies.map { $0.year })).sorted()
    }
    
    func getUniqueGenres() -> [String] {
        Array(Set(movies.flatMap { $0.genre })).sorted()
    }
    
    func getUniqueDirectors() -> [String] {
        Array(Set(movies.map { $0.director })).sorted()
    }
    
    func getUniqueActors() -> [String] {
        Array(Set(movies.flatMap { $0.actors })).sorted()
    }
    
    func getMoviesForYear(_ year: String) -> [Movie] {
        movies.filter { $0.year == year }
    }
    
    func getMoviesForGenre(_ genre: String) -> [Movie] {
        movies.filter { $0.genre.contains(genre) }
    }
    
    func getMoviesForDirector(_ director: String) -> [Movie] {
        movies.filter { $0.director == director }
    }
    
    func getMoviesForActor(_ actor: String) -> [Movie] {
        movies.filter { $0.actors.contains(actor) }
    }
}
