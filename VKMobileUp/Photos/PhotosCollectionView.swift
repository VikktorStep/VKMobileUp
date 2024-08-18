import UIKit

class PhotoCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 6
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
}

