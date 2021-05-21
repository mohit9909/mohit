//
//  Models.swift
//  SWorks
//
//  Created by Mohit Raina  on 20/05/21.
//

import Foundation

struct ClientModel: Codable {
    
    let name: String
    let location: Cordinates
    let phone: Int64
    let address: String
}

/// Location Coordinates Model
struct Cordinates: Codable {
    let lat: Double
    let long: Double
}


