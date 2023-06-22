import Foundation
import SwiftData

//@Model
//class Trip {
//    var name: String
//    var destination: String
//    var endDate: Date
//    var startDate: Date
// 
//    var bucketList: [BucketListItem]? = []
//    var livingAccommodation: LivingAccommodation?
//}

@Model
class Trip {
    @Attribute(.unique) var name: String
    var destination: String
    var endDate: Date
    var startDate: Date
 
    @Relationship(.cascade) var bucketList: [BucketListItem]? = []
    var livingAccommodation: LivingAccommodation?
}

struct BucketListItem: Decodable, Encodable {
    let name: String
}

struct LivingAccommodation: Decodable, Encodable {
    let name: String
}

func test() {
    let container = try? ModelContainer(for: [Trip.self], ModelConfiguration())
}
