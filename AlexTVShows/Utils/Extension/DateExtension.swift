//
//  DateExtension.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import Foundation

extension Date {
    func toServiceFormatt() -> String? {
        let inputFormatter = DateFormatter()
        
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let resultString = inputFormatter.string(from: self)

        return resultString
    }
}
