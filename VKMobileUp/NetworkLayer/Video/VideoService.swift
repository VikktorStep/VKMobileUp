
import Foundation

protocol VideoServiceProtocol {
    func fetchVideos() async throws -> [Video]
}

class VideoService: VideoServiceProtocol, HTTPDataDownloader {
    private let authModel: WebAuthModel

    init(authModel: WebAuthModel) {
        self.authModel = authModel
    }

    func fetchVideos() async throws -> [Video] {
        guard let endpoint = try buildVideoEndpoint() else {
            throw APIErrors.requestFailed(description: "Invalid endpoint")
        }
        let videoResponse: VideoResponse = try await fetchData(as: VideoResponse.self, endpoint: endpoint)
        return videoResponse.response.items
    }
    
    // MARK: - URL Building
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/video.get"

        return components
    }
    
    private func buildVideoEndpoint() throws -> String? {
        guard let accessToken = authModel.getToken(), authModel.isTokenValid() else {
            throw APIErrors.requestFailed(description: "Access token is missing or invalid")
        }
        
        var components = baseURLComponents
        
        components.queryItems = [
            .init(name: "access_token", value: accessToken),
            .init(name: "owner_id", value: "-128666765"),
            .init(name: "v", value: "5.199"),
            .init(name: "count", value: "50"),
        ]
        
        return components.url?.absoluteString
    }
}
