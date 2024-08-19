
import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIErrors.requestFailed(description: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrors.requestFailed(description: "Request failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIErrors.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("\(error.localizedDescription)")
            throw error as? APIErrors ?? .unknownError(error: error)
        }
    }
}
