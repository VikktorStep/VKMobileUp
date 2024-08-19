
import UIKit
import WebKit

class VideoDetailViewController: UIViewController {
    var video: Video?
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadVideo()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = video?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
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
    }
    
    private func loadVideo() {
        guard let video = video, let url = URL(string: video.player) else { return }
        webView.load(URLRequest(url: url))
    }
    
    @objc private func didTapShareButton() {
        guard let url = URL(string: video?.player ?? "") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
