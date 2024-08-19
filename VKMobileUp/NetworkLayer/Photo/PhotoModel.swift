
import Foundation

struct PhotoResponse: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Photo]
}

struct Photo: Decodable, Identifiable {
    var id: Int
    let date: TimeInterval
    let origPhoto: OrigPhoto

    enum CodingKeys: String, CodingKey {
        case id, date
        case origPhoto = "orig_photo"
    }
}

struct OrigPhoto: Decodable {
    var url: String
}

