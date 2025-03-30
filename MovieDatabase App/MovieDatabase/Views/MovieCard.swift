//
//  MovieCard.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    var isExpanded: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let posterURL = movie.poster, let url = URL(string: posterURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 60, height: 90)
                .cornerRadius(8)
                .clipped()
            } else {
                Image(systemName: "NotFound")
                    .resizable()
                    .frame(width: 60, height: 90)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(movie.year) • \(movie.language.joined(separator: ", "))")
                       .font(.subheadline)
                       .foregroundColor(.secondary)
                
                if !isExpanded {
                    Text(movie.genre.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundColor(.black)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

// MARK: - Movie Card Preview
struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(
            movie: Movie(
                title: "Inception",
                year: "2010",
                genre: ["Sci-Fi", "Thriller"],
                director: "Christopher Nolan",
                actors: ["Leonardo DiCaprio", "Joseph Gordon-Levitt"],
                plot: "A thief who enters dreams to steal secrets faces his biggest challenge.",
                poster: nil,
                language: ["English"],
                ratings: [
                    Movie.Rating(source: "IMDB", value: "8.8/10"),
                    Movie.Rating(source: "Rotten Tomatoes", value: "87%")
                ]
            ),
            isExpanded: false
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
