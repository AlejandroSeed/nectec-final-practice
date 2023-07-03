//
//  ATSAction.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSAction {
    let color: Color
    let text: String
    let swipeAction: (ATSTvShow) -> Void
    let shouldGoToDetails: Bool
}
