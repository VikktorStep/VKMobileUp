import Foundation
import KeychainAccess

final class WebAuthModel {
    private let keychain = Keychain(service: "com.vkMobileUp.service")
    private let tokenKey = "accessToken"
    private let tokenTimestampKey = "tokenTimestamp"
    
    func saveToken(_ token: String) {
        keychain[tokenKey] = token
        let timestamp = Date().timeIntervalSince1970
        keychain[tokenTimestampKey] = String(timestamp)
        NSLog("Сохранен токен: \(token) в Keychain с временной меткой: \(timestamp)")
    }
    
    func getToken() -> String? {
        let token = keychain[tokenKey]
        NSLog("Извлечен токен из Keychain: \(String(describing: token))")
        return token
    }
    
    private func getTokenTimestamp() -> TimeInterval? {
        if let timestampString = keychain[tokenTimestampKey],
           let timestamp = TimeInterval(timestampString) {
            NSLog("Извлечена временная метка токена: \(timestamp)")
            return timestamp
        }
        NSLog("Временная метка токена не найдена")
        return nil
    }
    
    func isTokenValid() -> Bool {
        guard let _ = getToken(), let timestamp = getTokenTimestamp() else {
            NSLog("Токен не валиден или отсутствует")
            return false
        }
        
        let currentTime = Date().timeIntervalSince1970
        let timeElapsed = currentTime - timestamp
        let isValid = timeElapsed < 3600
        NSLog("Текущая временная метка: \(currentTime), время, прошедшее с момента получения токена: \(timeElapsed) секунд. Токен валиден: \(isValid)")
        return isValid
    }
    
    func clearToken() {
        keychain[tokenKey] = nil
        keychain[tokenTimestampKey] = nil
        NSLog("Токен и временная метка удалены из Keychain")
    }
}
