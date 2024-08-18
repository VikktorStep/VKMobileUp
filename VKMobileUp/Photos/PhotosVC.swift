
import UIKit

class PhotosVC: UIViewController {
    let mainView = PhotosCollectionView()
    
    var router: PhotoRouterProtocol
    var presenter: PhotosPresenter
    
    init(router: PhotoRouterProtocol, presenter: PhotosPresenter) {
        self.router = router
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        Task {
            presenter.fetchPhotos
        }
    }
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseID, for: indexPath) as! PhotoCollectionViewCell
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 8
        cell.imageView.image = UIImage(systemName: "person")
        return cell
    }
}

extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = UIImage(systemName: "person")!
        let detailVC = PhotosDetailVC(image: selectedImage, date: "2024-08-15")
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
