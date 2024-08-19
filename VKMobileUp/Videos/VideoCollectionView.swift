
import UIKit

class VideoCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCell")
        dataSource = self
        delegate = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCollectionViewCell
        let video = videos[indexPath.item]
        cell.configure(with: video)
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = width * 9 / 16
        return CGSize(width: width, height: height)
    }
}
