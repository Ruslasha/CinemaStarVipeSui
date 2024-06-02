// MovieCellSUI.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct MovieCellSUI: View {
    @Binding var movie: Movie
    
    private enum Constants {
        static let starMark = "⭐ "
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let posterURL = movie.poster, let url = URL(string: posterURL) {
                AsyncImage(url: url) { image in
                    image
                        .image?.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(8)
                }
            } else {
                Color.gray
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(8)
            }
            Text(movie.name)
            Text(Constants.starMark + rating)
        }
        .foregroundStyle(.white)
    }
    
    private var rating: String {
        String(format: "%0.1f", movie.rating)
    }
}
