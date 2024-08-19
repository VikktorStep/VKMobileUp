
import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {
    var photo: Photo?
    
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
        loadImage()
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .white
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
    }
    
    private func setupViews() {
        view.addSubview(dateLabel)
        view.addSubview(imageView)
        
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadImage() {
        guard let photo = photo, let url = URL(string: photo.origPhoto.url) else { return }
        
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Image successfully loaded: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        )
        
        let date = Date(timeIntervalSince1970: photo.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        navigationItem.title = dateFormatter.string(from: date)
    }

    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapShareButton() {
        guard let image = imageView.image else { return }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
