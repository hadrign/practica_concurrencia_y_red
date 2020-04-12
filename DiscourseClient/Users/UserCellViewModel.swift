//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Hadrian Grille Negreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var urlAvatar: String?
    let urlDiscourse = "https://mdiscourse.keepcoding.io/"
    //añadir imagen
    
    init(user: User) {
        self.user = user
        self.textLabelText = user.name
        self.urlAvatar = urlDiscourse + user.avatarTemplate.replacingOccurrences(of: "{size}", with: "100")
        
        // TODO: Asignar textLabelText, el título del topic
    }
}
