//
//  ATSTvShow.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import Foundation
import CoreData

struct ATSTvShow: Decodable {
    //MARK: - Properties
    let id: Int?
    let name: String?
    let rating: ATSRating?
    let image: ATSImage?
    let summary: String?
    var isFavorite: Bool? = false
}

extension ATSTvShow: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ATSTvShow, rhs: ATSTvShow) -> Bool {
        lhs.id == rhs.id
    }
}

struct ATSImage: Decodable {
    let medium, original: String?
}

struct ATSRating: Decodable {
    let average: Double?
}
