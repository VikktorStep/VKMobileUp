
import Foundation

struct PhotoResponce: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Photo]
}

struct Photo: Decodable, Identifiable {
    var id: String
    let date: String
    let origPhoto: OrigPhoto

    enum CodingKeys: String, CodingKey {
        case id, date
        case origPhoto = "orig_photo"
    }
}

struct OrigPhoto: Decodable {
    var url: String
}
