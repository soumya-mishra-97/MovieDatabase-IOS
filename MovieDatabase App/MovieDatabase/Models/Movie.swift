//
//  Movie.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id = UUID()
    let title: String
    let year: String
    let genre: [String]
    let director: String
    let actors: [String]
    let plot: String
    let poster: String?
    let language: [String]  
    let ratings: [Rating]
    
    struct Rating: Codable {
        let source: String
        let value: String
    }

    init(
        title: String = "Unknown Title",
        year: String = "Unknown Year",
        genre: [String] = ["Unknown Genre"],
        director: String = "Unknown Director",
        actors: [String] = ["Unknown Actor"],
        plot: String = "No plot available",
        poster: String? = nil,
        language: [String] = ["Unknown Language"],
        ratings: [Rating] = []
    ) {
        self.title = title
        self.year = year
        self.genre = genre
        self.director = director
        self.actors = actors
        self.plot = plot
        self.poster = poster
        self.language = language
        self.ratings = ratings
    }
    
    /// Custom Decoding to Handle Both String & Array for `language`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.genre = try container.decode([String].self, forKey: .genre)
        self.director = try container.decode(String.self, forKey: .director)
        self.actors = try container.decode([String].self, forKey: .actors)
        self.plot = try container.decode(String.self, forKey: .plot)
        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)
        self.ratings = try container.decode([Rating].self, forKey: .ratings)

        if let singleLanguage = try? container.decode(String.self, forKey: .language) {
            self.language = [singleLanguage]
        } else if let multipleLanguages = try? container.decode([String].self, forKey: .language) {
            self.language = multipleLanguages
        } else {
            self.language = ["Unknown Language"]
        }
    }
}
