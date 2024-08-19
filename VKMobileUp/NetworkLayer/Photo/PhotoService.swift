
import Foundation

protocol PhotosServiceProtocol {
    func fetchPhotos() async throws -> [Photo]
}

class PhotosService: PhotosServiceProtocol, HTTPDataDownloader {
    private let authModel: WebAuthModel

    init(authModel: WebAuthModel) {
        self.authModel = authModel
    }

    func fetchPhotos() async throws -> [Photo] {
        guard let endpoint = try buildPhotosEndpoint() else {
            throw APIErrors.requestFailed(description: "Invalid endpoint")
        }
        let photoResponse: PhotoResponse = try await fetchData(as: PhotoResponse.self, endpoint: endpoint)
        return photoResponse.response.items
    }
    
    // MARK: - URL Building
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/photos.get"

        return components
    }
    
    private func buildPhotosEndpoint() throws -> String? {
        guard let accessToken = authModel.getToken(), authModel.isTokenValid() else {
            throw APIErrors.requestFailed(description: "Access token is missing or invalid")
        }
        
        var components = baseURLComponents
        
        components.queryItems = [
            .init(name: "access_token", value: accessToken),
            .init(name: "owner_id", value: "-128666765"),  // Проверенное значение owner_id
            .init(name: "album_id", value: "266276915"),   // Проверенное значение album_id
            .init(name: "v", value: "5.199"),  // Версия API
            .init(name: "extended", value: "1"),  // Чтобы получить больше информации о фото
            .init(name: "photo_sizes", value: "1")  // Чтобы получить все размеры фото
        ]
        
        return components.url?.absoluteString
    }
}

