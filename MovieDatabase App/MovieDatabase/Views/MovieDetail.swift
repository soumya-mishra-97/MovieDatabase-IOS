//
//  MovieDetail.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    @State private var selectedRatingSource: String
    
    init(movie: Movie) {
        self.movie = movie
        _selectedRatingSource = State(initialValue: movie.ratings.first?.source ?? "IMDB")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.plot)
                .font(.body)
                .foregroundColor(.primary)
            
            HStack {
                Text("Director:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.director)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            HStack(alignment: .top) {
                Text("Cast:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.actors.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
            
            /// Rating View
            VStack {
                Picker("Rating Source", selection: $selectedRatingSource) {
                    ForEach(movie.ratings, id: \.source) { rating in
                        Text(rating.source).tag(rating.source)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 8)
                
                if let selectedRating = movie.ratings.first(where: { $0.source == selectedRatingSource }) {
                    Rating(
                        rating: selectedRating.value,
                        isIMDB: selectedRatingSource == "IMDB"
                    )
                    .padding(.top, 8)
                }
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

// MARK: - Movie Detail Preview
struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(
            movie: Movie(
                title: "Extraction",
                year: "2020",
                genre: ["Action"],
                director: "Sam Hargrave",
                actors: ["Chris Hemsworth", "Randeep Hooda"],
                plot: "A fearless black market mercenary embarks on a deadly mission.",
                poster: "https://sample-movie-poster.jpg",
                language: ["English"],
                ratings: [
                    Movie.Rating(source: "IMDB", value: "6.8"),
                    Movie.Rating(source: "Rotten Tomatoes", value: "67")
                ]
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
