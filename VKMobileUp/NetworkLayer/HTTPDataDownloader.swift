import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            NotificationCenter.default.post(name: .showAlert, object: AlertContext.genericError)
            throw APIErrors.requestFailed(description: "Invalid URL")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                NotificationCenter.default.post(name: .showAlert, object: AlertContext.genericError)
                throw APIErrors.invalidStatusCode(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                NotificationCenter.default.post(name: .showAlert, object: AlertContext.genericError)
                throw APIErrors.jsonParsingFailure
            }
        } catch {
            NotificationCenter.default.post(name: .showAlert, object: AlertContext.genericError)
            throw error
        }
    }
}
