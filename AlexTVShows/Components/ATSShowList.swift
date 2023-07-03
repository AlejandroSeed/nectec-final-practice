//
//  ATSShowList.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSShowList: View {
    var tvShows: [ATSTvShow] = []
    var action: ATSAction
    
    var body: some View {
        List {
            ForEach(tvShows, id: \.self) { key in
                if action.shouldGoToDetails {
                    NavigationLink {
                        ATSTvShowDetailView(tvShow: key)
                    } label: {
                        ATSShowItemView(tvShow: key)
                            .padding(.bottom, 8)
                            .padding(.top, 8)
                            .swipeActions {
                                Button(action.text) {
                                    action.swipeAction(key)
                                 }
                                .tint(action.color)
                            }
                    }.padding(.trailing, 16)
                } else {
                    ATSShowItemView(tvShow: key)
                        .padding(.bottom, 8)
                        .padding(.top, 8)
                        .swipeActions {
                            Button(action.text) {
                                action.swipeAction(key)
                             }
                            .tint(action.color)
                        }
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
    }
}

struct ATSShowList_Previews: PreviewProvider {
    static var previews: some View {
        ATSShowList(tvShows: [
            ATSTvShow(id: 1, name: "Prueba 1", rating: .init(average: 7.0), image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/257/644822.jpg", original: "https://static.tvmaze.com/uploads/images/medium_landscape/257/644822.jpg"), summary: "Descripcion 1"),
            ATSTvShow(id: 2, name: "Prueba 2", rating: .init(average: 9.0), image: .init(medium: "https://static.tvmaze.com/uploads/images/medium_landscape/257/644822.jpg", original: "https://static.tvmaze.com/uploads/images/medium_landscape/257/644822.jpg"), summary: "Descripcion 2", isFavorite: true)
        ], action: ATSAction(color: .green, text: "Agregar", swipeAction: { _ in
            print("Prueba")
        }, shouldGoToDetails: true))
    }
}
