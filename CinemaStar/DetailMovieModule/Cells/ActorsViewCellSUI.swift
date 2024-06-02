//
//  ActorsViewCellSUI.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 28.05.2024.
//

import SwiftUI

struct ActorViewCellSUI: View {
    
    private let imageAspectRation = 46.0/73.0
    
    let actorName: String
    let actorImage: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: actorImage)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 65, height: 97)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 97)
                        .clipped()
                case .failure:
                    Color.gray
                        .frame(width: 65, height: 97)
                @unknown default:
                    Color.gray
                        .frame(width: 65, height: 97)
                }
            }
            .cornerRadius(5)
            Text(actorName)
                .font(Font(UIFont.verdana(ofSize: 8) ?? .systemFont(ofSize: 8)))
                .foregroundStyle(.white)
        }
    }
}
