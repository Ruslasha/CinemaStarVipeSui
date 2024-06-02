//
//  SimilarMovieView.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 28.05.2024.
//

import SwiftUI

struct RecomendationMovieView: View {

    @State var movie: SimilarMovie?

    var body: some View {
        if let movie {
            VStack(alignment: .leading, spacing: 8) {

                if let posterURL = movie.poster.url, let url = URL(string: posterURL) {
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
                    .font(Font(UIFont.verdana(ofSize: 16) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.white)
            }
        }
    }


}

