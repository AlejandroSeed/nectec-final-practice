//
//  TvShowExtension.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import Foundation

extension TvShow {
    func toATSTvShow() -> ATSTvShow {
        ATSTvShow(id: Int(self.id), name: self.name, rating: .init(average:self.rating != nil ? Double(truncating: self.rating!) : nil), image: .init(medium: self.image?.absoluteString, original: self.image?.absoluteString) , summary: self.summary, isFavorite: true)
    }
}
