
import UIKit

class SegmentedController: UIViewController {
    
    private let segmentedControl = SegmentedControlView()
    private let photoCollectionView = PhotoCollectionView()
    private let videoCollectionView = VideoCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
        setupDelegates()
        
        segmentChanged()
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
        photoCollectionView.delegate = self
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = collectionView == photoCollectionView ? "PhotoCell" : "VideoCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = collectionView == photoCollectionView ? .blue : .red
        return cell
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
