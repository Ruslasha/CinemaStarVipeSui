//
//  ActorsViewCellSUI.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 28.05.2024.
//

import SwiftUI

struct ActorViewCellSUI: View {

    private let imageAspectRation = 46.0/73.0

    @State var person: Person

    var body: some View {
        VStack {
            Image(.verona)
                    .resizable()
            .aspectRatio(imageAspectRation, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(person.name ?? "")
                .font(Font(UIFont.verdana(ofSize: 8) ?? .systemFont(ofSize: 8)))
                .foregroundStyle(.white)
        }
    }
}
