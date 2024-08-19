
import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with photo: Photo) {
        if let url = URL(string: photo.origPhoto.url) {
            imageView.kf.setImage(with: url, placeholder: nil, options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
        }
    }
}
