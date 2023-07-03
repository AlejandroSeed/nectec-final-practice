//
//  ATSTvShow.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import Foundation
import CoreData

extension [ATSTvShow] {
    func mapFavorites(context: NSManagedObjectContext) -> [ATSTvShow] {
        let favoriteMovies: [ATSTvShow] = (try? ATSTvShowManager().getFavoriteTvShows(context: context)) ?? []
        
        return self.map { tvShow in
            guard favoriteMovies.contains(tvShow) else {
                return tvShow
            }
            
            var tvShow = tvShow
            
            tvShow.isFavorite = true
            print(tvShow)
            return tvShow
        }
    }
}
