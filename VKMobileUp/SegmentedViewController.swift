
import UIKit

class SegmentedController: UIViewController {
    
    private let segmentedControl = SegmentedControlView()
    private let photoCollectionView = PhotoCollectionView()
    private let videoCollectionView = VideoCollectionView()

    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
        setupDelegates()
        
        loadPhotos()
        
        segmentChanged()
    }
    
    private func loadPhotos() {
        Task {
            let authModel = WebAuthModel()
            let photosService = PhotosService(authModel: authModel)
            
            do {
                self.photos = try await photosService.fetchPhotos()
                print("Fetched \(photos.count) photos:")
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
            } catch {
                print("Error fetching photos: \(error)")
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "MobileUp Gallery"
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setupSubviews() {
        view.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        view.addSubview(photoCollectionView)
        view.addSubview(videoCollectionView)
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
        photoCollectionView.delegate = photoCollectionView
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
    }

    
    @objc private func segmentChanged() {
        photoCollectionView.isHidden = segmentedControl.selectedSegmentIndex != 0
        videoCollectionView.isHidden = segmentedControl.selectedSegmentIndex != 1
    }
    
    @objc private func logout() {
        print("Logout tapped")
    }
}

extension SegmentedController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return photoCollectionView.photos.count  // Возвращаем количество фотографий
        } else {
            return 10 // Это для videoCollectionView, если там будет другой источник данных
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
            let photo = photoCollectionView.photos[indexPath.item]  // Данные берутся из photoCollectionView
            cell.configure(with: photo)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoCollectionView {
            let spacing: CGFloat = 6
            let width = (collectionView.frame.width - spacing * 2) / 2
            return CGSize(width: width, height: width)
        } else {
            return CGSize(width: collectionView.frame.width, height: 200)
        }
    }
}

