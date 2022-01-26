//
//  FavoritesViewController.swift
//  RocketFan
//
//  Created by Hilal on 25.01.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        return collection
    }()
    
    private enum Constants {
        static let cellId = "RocketFavoritesCollectionViewCell"
        typealias CellType = RocketFavoritesCollectionViewCell
    }
    
    var favorites: [ListTableViewCellViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupCollectionViewLayaout()
        setupCollectionViewCell()
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupCollectionViewLayaout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height * 2/3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 20
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func setupCollectionViewCell() {
        let nib = UINib(nibName: Constants.cellId, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Constants.cellId)
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as? Constants.CellType else {
            return UICollectionViewCell()
        }
        cell.setValues(favorites?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return collectionView.frame.height
    }
    
}
