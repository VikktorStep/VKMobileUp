import UIKit
import WebKit

class VideoDetailViewController: UIViewController {
    var video: Video?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupWebView()
        loadVideo()
        enableSwipeBackGesture()
    }
    
    private func setupNavigationBar() {
        title = video?.title

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didTapBackButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShareButton)
        )

        updateNavigationBarTintColor()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        webView.backgroundColor = .systemBackground
        webView.scrollView.backgroundColor = .systemBackground
    }
    
    private func loadVideo() {
        guard let video = video, let url = URL(string: video.player) else { return }
        webView.load(URLRequest(url: url))
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapShareButton() {
        guard let url = URL(string: video?.player ?? "") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateNavigationBarTintColor()
    }
    
    private func updateNavigationBarTintColor() {
        let tintColor: UIColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
        navigationItem.leftBarButtonItem?.tintColor = tintColor
        navigationItem.rightBarButtonItem?.tintColor = tintColor
    }
    
    private func enableSwipeBackGesture() {
        guard let navigationController = navigationController else { return }
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension VideoDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
