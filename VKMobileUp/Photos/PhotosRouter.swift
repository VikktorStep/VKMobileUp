//
//import UIKit
//import Kingfisher
//
//protocol SegmentedViewProtocol: AnyObject {
//    func updatePhotos(_ photos: [Photo])
//    func showError(_ error: Error)
//}
//
//protocol SegmentedPresenterProtocol: AnyObject {
//    func viewDidLoad()
//    func didSelectPhoto(_ photo: Photo)
//}
//
//final class SegmentedPresenter: SegmentedPresenterProtocol {
//    weak var view: SegmentedViewProtocol?
//    private let router: SegmentedRouterProtocol
//    private let photosService: PhotosServiceProtocol
//
//    init(view: SegmentedViewProtocol, router: SegmentedRouterProtocol, photosService: PhotosServiceProtocol) {
//        self.view = view
//        self.router = router
//        self.photosService = photosService
//    }
//
//    func viewDidLoad() {
//        loadPhotos()
//    }
//
//    func didSelectPhoto(_ photo: Photo) {
//        router.openDetailScreen(with: photo)
//    }
//
//    private func loadPhotos() {
//        Task {
//            do {
//                let photos = try await photosService.fetchPhotos()
//                DispatchQueue.main.async {
//                    self.view?.updatePhotos(photos)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.view?.showError(error)
//                }
//            }
//        }
//    }
//}
//
//
//protocol SegmentedRouterProtocol {
//    func openDetailScreen(with photo: Photo)
//    func dismiss()
//}
//
//final class SegmentedRouter: SegmentedRouterProtocol {
//    var navigationController: UINavigationController?
//
//    init(navigationController: UINavigationController?) {
//        self.navigationController = navigationController
//    }
//
//    func openDetailScreen(with photo: Photo) {
//        let detailVC = PhotoDetailViewController()
//        detailVC.photo = photo
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//    func dismiss() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//
//class SegmentedViewController: UIViewController, SegmentedViewProtocol {
//    
//    private let segmentedControl = SegmentedControlView()
//    private let photoCollectionView = PhotoCollectionView()
//    private let videoCollectionView = VideoCollectionView()
//    
//    var presenter: SegmentedPresenterProtocol?
//    private var photos: [Photo] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupNavigationBar()
//        setupSubviews()
//        setupConstraints()
//        setupDelegates()
//        
//        presenter?.viewDidLoad()  // Вызываем загрузку данных
//        segmentChanged()
//    }
//
//    func updatePhotos(_ photos: [Photo]) {
//        self.photos = photos
//        photoCollectionView.photos = photos
//        photoCollectionView.reloadData()
//    }
//
//    func showError(_ error: Error) {
//        print("Error fetching photos: \(error)")
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.title = "MobileUp Gallery"
//        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logout))
//        navigationItem.rightBarButtonItem = logoutButton
//    }
//    
//    private func setupSubviews() {
//        view.backgroundColor = .white
//        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
//        view.addSubview(segmentedControl)
//        view.addSubview(photoCollectionView)
//        view.addSubview(videoCollectionView)
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            photoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
//            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            videoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
//            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            videoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    private func setupDelegates() {
//        photoCollectionView.dataSource = self
//        photoCollectionView.delegate = self
//        videoCollectionView.dataSource = self
//        videoCollectionView.delegate = self
//    }
//
//    @objc private func segmentChanged() {
//        photoCollectionView.isHidden = segmentedControl.selectedSegmentIndex != 0
//        videoCollectionView.isHidden = segmentedControl.selectedSegmentIndex != 1
//        print("Segment changed: \(segmentedControl.selectedSegmentIndex)")
//        print("PhotoCollectionView is hidden: \(photoCollectionView.isHidden)")
//        print("VideoCollectionView is hidden: \(videoCollectionView.isHidden)")
//    }
//
//    @objc private func logout() {
//        print("Logout tapped")
//    }
//}
//
//extension SegmentedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
//        let photo = photos[indexPath.item]
//        cell.configure(with: photo)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let spacing: CGFloat = 6
//        let width = (collectionView.frame.width - spacing * 2) / 2
//        return CGSize(width: width, height: width)
//    }
//}
//
//
//class PhotoCollectionView: UICollectionView {
//
//    var photos: [Photo] = []
//
//    init() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 6
//        super.init(frame: .zero, collectionViewLayout: layout)
//        setupCollectionView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupCollectionView() {
//        backgroundColor = .white
//        translatesAutoresizingMaskIntoConstraints = false
//        register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
//    }
//}
//
//
//class PhotoCollectionViewCell: UICollectionViewCell {
//    
//    private let imageView = UIImageView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupImageView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupImageView() {
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(imageView)
//        
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//    
//    func configure(with photo: Photo) {
//        if let url = URL(string: photo.origPhoto.url) {
//            imageView.kf.setImage(with: url, placeholder: nil, options: [
//                .transition(.fade(0.2)),
//                .cacheOriginalImage
//            ])
//        }
//    }
//}
//
//
//struct SegmentedBuilder {
//    func createSegmentedModule(navigationController: UINavigationController?) -> UIViewController {
//        let viewController = SegmentedViewController()
//        let router = SegmentedRouter(navigationController: navigationController)
//        let authModel = WebAuthModel()
//        let photosService = PhotosService(authModel: authModel)
//        let presenter = SegmentedPresenter(view: viewController, router: router, photosService: photosService)
//        
//        viewController.presenter = presenter
//        return viewController
//    }
//}
//
//
////protocol PhotosViewProtocol: AnyObject {
////    func updatePhotos(_ photos: [Photo])
////    func showError(_ error: Error)
////}
////
////
////protocol PhotosPresenterProtocol: AnyObject {
//////    func viewDidLoad()
////    func didSelectPhoto(at index: Int)
////}
////
////
////protocol PhotosRouterProtocol {
////    func openPhotoDetail(photo: Photo)
//////    func dismiss()
//////    func start()
////}
////
////final class PhotosRouter: PhotosRouterProtocol {
////    var navigationController: UINavigationController?
////
////    private lazy var builder = PhotosBuilder(router: self)
////
////    init(navigationController: UINavigationController?) {
////        self.navigationController = navigationController
////    }
////
//////    func start() {
//////        let collectionView = builder.createCollectionView()
//////        if let navigationController = navigationController {
//////            let viewController = UIViewController()
//////            viewController.view.addSubview(collectionView)
//////            collectionView.translatesAutoresizingMaskIntoConstraints = false
//////            NSLayoutConstraint.activate([
//////                collectionView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
//////                collectionView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
//////                collectionView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
//////                collectionView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
//////            ])
//////            navigationController.pushViewController(viewController, animated: true)
//////        }
//////    }
//////
//////    func dismiss() {
//////        navigationController?.dismiss(animated: true, completion: { [weak self] in
//////            self?.start()
//////        })
//////    }
////
////    func openPhotoDetail(photo: Photo) {
////        let detailVC = PhotoDetailViewController()
////        detailVC.photo = photo
////        navigationController?.pushViewController(detailVC, animated: true)
////    }
////}
////
////
////
////struct PhotosBuilder {
////    let router: PhotosRouterProtocol
////    
////    init(router: PhotosRouterProtocol) {
////        self.router = router
////    }
////    
////    func createCollectionView() -> PhotoCollectionView {
////        let photoCollectionView = PhotoCollectionView()
////        let photosService = PhotosService(authModel: WebAuthModel())
////        let presenter = PhotosPresenter(view: photoCollectionView, router: router, photosService: photosService)
////        photoCollectionView.presenter = presenter
////        return photoCollectionView
////    }
////}
////
////final class PhotosPresenter: PhotosPresenterProtocol {
////
////    weak var view: PhotosViewProtocol?
////    let router: PhotosRouterProtocol
////    let photosService: PhotosService
////    
////    var photos: [Photo] = []
////    
////    init(view: PhotosViewProtocol, router: PhotosRouterProtocol, photosService: PhotosService) {
////        self.view = view
////        self.router = router
////        self.photosService = photosService
////    }
////
////    func loadPhotos() {
////        Task {
////            do {
////                let photos = try await photosService.fetchPhotos()
////                print("Fetched \(photos.count) photos:")
////                self.photos = photos
////                DispatchQueue.main.async {
////                    self.view?.updatePhotos(photos)
////                }
////            } catch {
////                DispatchQueue.main.async {
////                    self.view?.showError(error)
////                }
////            }
////        }
////    }
////
////    func didSelectPhoto(at index: Int) {
////        let selectedPhoto = photos[index]
////        router.openPhotoDetail(photo: selectedPhoto)
////    }
////}
