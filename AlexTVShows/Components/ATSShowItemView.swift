//
//  ATSShowView.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSShowItemView: View {
    var tvShow: ATSTvShow
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: tvShow.image?.medium ?? "")) { phase in
                if let image = phase.image {
                    image.renderingMode(.original)
                        .resizable()
                } else {
                    Image(systemName: "tv")
                }
            }
            .frame(width: 80, height: 80)
            .cornerRadius(5)
            .padding(.trailing, 10)
            Text(tvShow.name ?? "NA")
                .foregroundColor(.primary)
                .font(.callout)
                .lineLimit(1)
            Spacer()
            if tvShow.isFavorite ?? false {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ATSShowView_Previews: PreviewProvider {
    static var previews: some View {
        ATSShowItemView(tvShow: ATSTvShow(id: 1, name: "Prueba", rating: .init(average: 4.0), image: .init(medium: "", original: ""), summary: "Descripcion", isFavorite: true))
    }
}
