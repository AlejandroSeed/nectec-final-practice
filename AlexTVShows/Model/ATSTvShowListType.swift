//
//  ATSTvShowListType.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI
import CoreData

enum ATSTvShowListType {
    case favorite
    case all
    
    //MARK: - Methods
    func getTvShows(context: NSManagedObjectContext, completion: @escaping (Result<[ATSTvShow], Error>) -> Void) {
        switch self {
        case .favorite:
            do {
                completion(.success(try ATSTvShowManager().getFavoriteTvShows(context: context)))
            } catch {
                completion(.failure(error))
            }
        case .all:
            ATSTvShowManager().getTvShow(completion: completion)
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .favorite:
            return "Favoritos"
        case .all:
            return "Tv Shows"
        }
    }
}
