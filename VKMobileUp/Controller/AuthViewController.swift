
import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вход через VK", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginButton.widthAnchor.constraint(equalToConstant: 343),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Mobile Up\nGallery"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    @objc private func didTapLoginButton() {
        let webViewController = WebViewController()
        webViewController.modalPresentationStyle = .pageSheet
        present(webViewController, animated: true, completion: nil)
    }

}
