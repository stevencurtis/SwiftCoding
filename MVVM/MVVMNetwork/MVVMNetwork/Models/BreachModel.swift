//
//  UserModel.swift
//  Pwned
//
//  Created by Steven Curtis on 27/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

struct BreachModel : Codable {
    let name : String
    let title : String
    let domain : String
    let breachDate : String
    var breachDateformatted: String? {return usDateToUK(breachDate) }
    let addedDate : String
    let modifiedDate : String
    let pwnCount : Int
    let description: String
    let logoPath : String
    let dataClasses : [String]
    let verified: Bool
    let fabricated : Bool
    let sensitive : Bool
    let retired : Bool
    let spam : Bool
    
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDate = "BreachDate"
        case addedDate = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case logoPath = "LogoPath"
        case dataClasses = "DataClasses"
        case verified = "IsVerified"
        case fabricated = "IsFabricated"
        case sensitive = "IsSensitive"
        case retired = "IsRetired"
        case spam = "IsSpamList"
    }

    func usDateToUK (_ inpDate: String) -> String {
        let dateAsString = inpDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        if let date = dateFormatter.date(from: dateAsString)
        {
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            let outputDate = dateFormatter.string(from: date)
            return outputDate
        }
        return inpDate
    }
}

extension RandomAccessCollection where Element == BreachModel {
    func sortedByName() -> [BreachModel] {
        return sorted { a, b in a.name < b.name }
    }
}


