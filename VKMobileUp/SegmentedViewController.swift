import UIKit

class SegmentedViewController: UIViewController {
    
    private let segmentedControl = SegmentedControlView()
    private let photoCollectionView = PhotoCollectionView()
    private let videoCollectionView = VideoCollectionView()
    
    private var photos: [Photo] = []
    private var videos: [Video] = []
    
    private let router: StartScreenRouter
    
    init(router: StartScreenRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
        setupDelegates()
        
        segmentChanged()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = TextStrings.mobileUpGalery.rawValue
        let logoutButton = UIBarButtonItem(title: TextStrings.exit.rawValue, style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        navigationController?.navigationBar.tintColor = UIColor.label
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    private func setupSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(photoCollectionView)
        view.addSubview(videoCollectionView)
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            photoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            videoCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDelegates() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
    }
    
    @objc private func segmentChanged() {
        let isPhotoSegmentSelected = segmentedControl.selectedSegmentIndex == 0
        
        photoCollectionView.isHidden = !isPhotoSegmentSelected
        videoCollectionView.isHidden = isPhotoSegmentSelected
        
        if !isPhotoSegmentSelected && videos.isEmpty {
            loadVideos()
        }
        
        if isPhotoSegmentSelected && photos.isEmpty {
            loadPhotos()
        }
    }
    
    private func loadPhotos() {
        Task {
            let authModel = WebAuthModel()
            let photosService = PhotosService(authModel: authModel)
            
            do {
                let photos = try await photosService.fetchPhotos()
                NSLog("Fetched \(photos.count) photos:")
                self.photos = photos
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
            } catch {
                NSLog("Error fetching photos: \(error)")
            }
        }
    }
    
    private func loadVideos() {
        Task {
            let authModel = WebAuthModel()
            let videoService = VideoService(authModel: authModel)
            
            do {
                videos = try await videoService.fetchVideos()
                DispatchQueue.main.async {
                    self.videoCollectionView.reloadData()
                }
            } catch {
                NSLog("Error fetching videos: \(error)")
            }
        }
    }
    
    @objc private func logout() {
        let alertController = UIAlertController(
            title: "Выход",
            message: "Вы уверены, что хотите выйти?",
            preferredStyle: .alert
        )

        let logoutAction = UIAlertAction(title: "Выйти", style: .destructive) { _ in
            self.router.start()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension SegmentedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return photos.count
        } else {
            return videos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
            let photo = photos[indexPath.item]
            cell.configure(with: photo)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCollectionViewCell
            let video = videos[indexPath.item]
            cell.configure(with: video)
            return cell
        }
    }
}

extension SegmentedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == videoCollectionView {
            let selectedVideo = videos[indexPath.item]
            let videoDetailVC = VideoDetailViewController()
            videoDetailVC.video = selectedVideo
            navigationController?.pushViewController(videoDetailVC, animated: true)
        } else {
            let selectedPhoto = photos[indexPath.item]
            NSLog("Selected photo: \(selectedPhoto.id)")
            let detailVC = PhotoDetailViewController()
            detailVC.photo = selectedPhoto
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension SegmentedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoCollectionView {
            let spacing: CGFloat = 6
            let width = (collectionView.frame.width - spacing * 2) / 2
            return CGSize(width: width, height: width)
        } else {
            let width = collectionView.frame.width
            let height = width * 9 / 16
            return CGSize(width: width, height: height)
        }
    }
}
