//
//  PhotosCollectionViewController.swift
//  VKMobileUp
//
//  Created by Виктор Степанов on 19.08.2024.
//

//import UIKit
//
//final class PhotosViewController: UIViewController, PhotosViewProtocol {
//    
//    var presenter: PhotosPresenterProtocol?
//    private let photoCollectionView = PhotosCollectionView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(photoCollectionView)
//        setupConstraints()
//        presenter?.viewDidLoad()
//    }
//    
//    func displayPhotos(_ photos: [Photo]) {
//        photoCollectionView.photos = photos
//        photoCollectionView.reloadData()
//    }
//    
//    func showError(_ error: Error) {
//        // Показываем ошибку пользователю, например, через UIAlertController
//        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//    private func setupConstraints() {
//        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
