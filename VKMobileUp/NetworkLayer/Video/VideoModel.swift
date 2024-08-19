
import Foundation

struct VideoResponse: Decodable {
    var response: Videos
}

struct Videos: Decodable {
    var items: [Video]
}

struct Video: Decodable {
    let id: Int
    let title: String
    let player: String 
    let image: [VideoImage]
}

struct VideoImage: Decodable {
    let url: String
}
