//
//  RatingView.swift
//  MovieDatabase App
//
//  Created by Soumya Ranjan Mishra on 30/03/25.
//

import SwiftUI

struct Rating: View {
    let rating: String
    let isIMDB: Bool
    
    private var ratingValue: Double {
        if isIMDB {
            return (Double(rating) ?? 0) / 2
        } else {
            return (Double(rating.replacingOccurrences(of: "%", with: "")) ?? 0) / 20
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: index < Int(ratingValue) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            
            if isIMDB {
                Text("\(rating)/10")
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .padding(.leading, 8)
            } else {
                Text("\(rating)%")
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .padding(.leading, 8)
            }
        }
    }
}

// MARK: - Rating Preview
struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            Rating(rating: "8.5", isIMDB: true)
            Rating(rating: "75%", isIMDB: false)
            Rating(rating: "50%", isIMDB: false) 
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
