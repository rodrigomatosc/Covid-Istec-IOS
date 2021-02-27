//
//  InformationCovid.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 24/02/2021.
//

import Foundation

struct InformationCovid: Codable {
    var confirmed : Float?
    var recovered : Float?
    var deaths : Float?
    var country : String?
    var population : Float?
    var life_expectancy : String?
    var continent : String?
    var abbreviation : String?
    var location : String?
    var capital_city : String?
    var lat : String?
    var long : String?
    var updated : String?
    var dates : [String : Float]?
}
