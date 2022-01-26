//
//  RocketFavoritesCollectionViewCell.swift
//  RocketFan
//
//  Created by Hilal on 25.01.2022.
//

import UIKit
import Kingfisher

class RocketFavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        backView.layer.cornerRadius = 4
        rocketImageView.layer.cornerRadius = 4
    }
    
    func setValues(_ model: ListTableViewCellViewModel?) {
        guard let item = model else { return }
        titleLabel.text = item.name
        infoLabel.text = item.description
        
        if let imageString = item.flickr_images.first,
           let imageUrl = URL(string: imageString) {
            rocketImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
