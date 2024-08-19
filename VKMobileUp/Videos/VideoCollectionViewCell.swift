import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let titleContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        titleLabel.textAlignment = .right
        titleLabel.numberOfLines = 0
        
        titleContainerView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor.black.withAlphaComponent(0.6) : UIColor.white.withAlphaComponent(0.6)
        }
        titleContainerView.layer.cornerRadius = 16
        titleContainerView.layer.masksToBounds = true
        
        titleContainerView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(titleContainerView)
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -6),
            
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width - 32)
        ])
    }
    
    func configure(with video: Video) {
        if let imageUrlString = video.image.last?.url, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
        }
        titleLabel.text = video.title
        titleContainerView.layoutIfNeeded()
    }
}
