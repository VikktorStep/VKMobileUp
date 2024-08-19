import UIKit

class VideoCollectionView: UICollectionView {
    
    var videos: [Video] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        backgroundColor = .systemBackground 
        translatesAutoresizingMaskIntoConstraints = false
        register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCell")
    }
}

extension VideoCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = width * 9 / 16
        return CGSize(width: width, height: height)
    }
}
