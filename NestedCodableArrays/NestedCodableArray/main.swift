//
//  main.swift
//  NestedCodableArray
//
//  Created by Steven Curtis on 05/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

let jsonString = """
{
    "user": {
        "first_name": "Dave",
        "second_name": "Roberts"
    },
    "friends": [{
        "id": "AA0123",
        "first_name": "Jenny",
        "second_name": "Williams"
        },{
        "id": "B1235",
        "first_name": "Jerry",
        "second_name": "Mobley"
    }]
}
"""

struct EasyUM: Decodable {
    var user: User
    var friends: [Friends]
}
struct Friends: Decodable {
    var id: String
    var first_name: String
    var second_name: String
}
struct User: Decodable {
    var first_name: String
    var second_name: String
}

let decodera = JSONDecoder()
let dataa = jsonString.data(using: .utf8)!
let decodeda = try! decodera.decode(EasyUM.self, from: dataa)
//print (decodeda)

struct NestedStructs: Decodable {
    var user: UserNested
    var friends: [FriendsNested]
    struct FriendsNested: Decodable {
        var id: String
        var first_name: String
        var second_name: String
    }
    struct UserNested: Decodable {
        var first_name: String
        var second_name: String
    }
}

let decoderb = JSONDecoder()
let datab = jsonString.data(using: .utf8)!
let decodedb = try! decoderb.decode(NestedStructs.self, from: datab)
//print (decodedb)


struct UserModel: Codable {
    // Top-level coding keys
    enum CodingKeys: String, CodingKey {
      case friends, user
    }

    enum UserKeys: String, CodingKey {
        case firstName = "first_name", secondName = "second_name"
    }
    
    enum FriendKeys: String, CodingKey {
        case id
        case firstName = "first_name", secondName = "second_name"
    }
    var user: User

    struct User: Codable {
        var first_name: String
        var second_name: String
    }
  
    var friends: [Friends] = []
    struct Friends: Codable {
        var id: String
        var first_name: String
        var second_name: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        user = User(
            first_name: try userContainer.decode(String.self, forKey: .firstName),
            second_name: try userContainer.decode(String.self, forKey: .secondName))
        var friendUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .friends)
        while !friendUnkeyedContainer.isAtEnd {
            let friendContainer = try friendUnkeyedContainer.nestedContainer(keyedBy: FriendKeys.self)
            let friend = Friends(
                id: try friendContainer.decode(String.self, forKey: .id),
                first_name: try friendContainer.decode(String.self, forKey: .firstName),
                second_name: try friendContainer.decode(String.self, forKey: .secondName))
            friends.append(friend)
        }
    }
}

let decoder = JSONDecoder()
let data = jsonString.data(using: .utf8)!
let decoded = try! decoder.decode(UserModel.self, from: data)
print (decoded)


//print (decoded.friends[0].id )

//dump (decoded)


//If you want to include the id keys declare let friends : [[String:String]] and decode friends = try container.decode([[String:String]].self, forKey: .friends)
