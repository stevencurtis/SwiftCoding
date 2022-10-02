//
//  main.swift
//  PostExample
//
//  Created by Steven Curtis on 06/05/2021.
//

import Foundation

//class Post {
//    let userID: String
//    init(userID: String) {
//        self.userID = userID
//    }
//}
//
//class Image: Post {
//    let photo: String
//    init(userID: String, photo: String) {
//        self.photo = photo
//        super.init(userID: userID)
//    }
//}
//
//class Text: Post {
//    let text: String
//    init(userID: String, text: String) {
//        self.text = text
//        super.init(userID: userID)
//    }
//}
//
//class Video: Post {
//    let video: String
//    init(userID: String, video: String) {
//        self.video = video
//        super.init(userID: userID)
//    }
//}

class User {
    let id: String
    init(id: String) {
        self.id = id
    }
}


// Multiple inheritance is not allowed
//class Family: User, Post {
//    let name: String
//    init(name: String) {
//        self.name = name
//    }
//}

protocol PostProtocol {
    var userID: String { get }
}

class Post: PostProtocol {
    let userID: String
    init(userID: String) {
        self.userID = userID
    }
}

class Family: PostProtocol {
    var userID: String
    let name: String
    init(name: String, userID: String) {
        self.name = name
        self.userID = userID
    }
}
