
import Foundation

protocol PhotosServiceProtocol {
    func fetchPhotos() async throws -> [Photo]
//    func fetchCoinDetails(id: String) async throws -> CoinDetails?
}

class PhotosService: PhotosServiceProtocol, HTTPDataDownloader {
    
    func fetchPhotos() async throws -> [Photo] {
        guard let endpoint = allPhotosURLString else {
            throw PhotosAPIErrors.requestFailed(description: "Invalid endpoint")
        }
        return try await fetchData(as: [Photo].self, endpoint: endpoint)
    }
    
    // MARK: - URL Building
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/method"
        
        return components
    }
    
    private var allPhotosURLString: String? {
        var components = baseURLComponents
        components.path += "markets"
        
        components.queryItems = [
            .init(name: "access_token", value: "vk1.a.Rak41wOtHZ9N7rxDO8OuI-e8v8Se9g_yCk2QVY9AOU5fBlgB8fNZEDtBYJpbvQO7CVD4AG0oX9unGWcloWMS07m9cypti7D-9EjfZxmTCLnpUJE2l9Ezi6eG9Ox9ATmohoZpTsjeftwmfPVEV2FSLGpZlBKUjOT8siEyS3F5VxCi-ZYT3iL8pwNkFxKiksh8"),
            .init(name: "owner_id", value: "-128666765"),
            .init(name: "album_id", value: "266276915"),
            .init(name: "v", value: "5.199")        
        ]
        
        return components.url?.absoluteString
    }
}

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw PhotosAPIErrors.requestFailed(description: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PhotosAPIErrors.requestFailed(description: "Request failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw PhotosAPIErrors.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("\(error.localizedDescription)")
            throw error as? PhotosAPIErrors ?? .unknownError(error: error)
        }
    }
}
