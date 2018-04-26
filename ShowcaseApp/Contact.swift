//
//  Struct.swift
//  ShowcaseApp
//
//  Created by Kerry Nasta on 4/14/18.
//  Copyright © 2018 Kerry Nasta. All rights reserved.
//

import Foundation
import UIKit

class Contact: Codable {
    var name: String
    var company: String
    var position: String
    var email: String
    var phone: String
    var address: String
    var notes: String
    var imageData = Data()
    
    init(name: String, company: String, position: String, email: String, phone: String, address: String, notes: String) {
        self.name = name
        self.company = company
        self.position = position
        self.email = email
        self.phone = phone
        self.address = address
        self.notes = notes
    }
}
