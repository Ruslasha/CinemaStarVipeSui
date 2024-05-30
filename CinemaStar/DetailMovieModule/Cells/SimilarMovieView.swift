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

                Image(.orig)
                        .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(movie.name)
                    .font(Font(UIFont.verdana(ofSize: 16) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.white)
            }
        }
    }


}

