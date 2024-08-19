import UIKit
import WebKit

<<<<<<<< HEAD:VKMobileUp/AuthenticationStart/AuthViewController.swift
class AuthViewController: UIViewController {
    var router: AuthStartRouter
    var presenter: Presenter
    
    init(router: AuthStartRouter, presenter: Presenter) {
        self.router = router
========
final class StartScreenViewController: UIViewController, StartScreenViewProtocol {
    var presenter: StartScreenPresenter
    
    private let loginButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    init(presenter: StartScreenPresenter) {
>>>>>>>> develop:VKMobileUp/StartScreen/StartScreenController.swift
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        setupLoginButton()
        setupTitleLabel()
    }
    
    private func setupLoginButton() {
        loginButton.setTitle(TextStrings.vkLogin.rawValue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        loginButton.setTitleColor(.systemBackground, for: .normal)
        loginButton.backgroundColor = .label
        loginButton.layer.cornerRadius = 12
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = TextStrings.mobileUpStartScreen.rawValue
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginButton.widthAnchor.constraint(equalToConstant: 343),
            loginButton.heightAnchor.constraint(equalToConstant: 52),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    @objc private func didTapLoginButton() {
        presenter.didTapButton()
    }
}
