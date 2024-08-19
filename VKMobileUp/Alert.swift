import UIKit

extension Notification.Name {
    static let showAlert = Notification.Name("showAlert")
}

struct AlertInfo {
    let title: String
    let message: String
}

class AlertManager {
    static let shared = AlertManager()

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(notification:)), name: .showAlert, object: nil)
    }

    @objc private func showAlert(notification: Notification) {
        guard let alertInfo = notification.object as? AlertInfo else { return }
        let alertController = UIAlertController(title: alertInfo.title, message: alertInfo.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}


struct AlertContext {
    static let genericError = AlertInfo(title: "Error", message: "Что-то пошло не так, попробуйте позже")
}
