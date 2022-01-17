//
//  RocketListTableViewCell.swift
//  RocketFan
//
//  Created by Hilal on 15.01.2022.
//

import UIKit
import Kingfisher

class RocketListTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        backView.backgroundColor = .label.withAlphaComponent(0.1)
        backView.layer.cornerRadius = 4
        
        rocketImageView.layer.cornerRadius = 4
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
    
    func setValues(_ model: ListTableViewCellViewModel?) {
        guard let item = model else { return }
        titleLabel.text = item.name
        infoLabel.text = item.description
        favoriteButton.isSelected = item.isFavorite
        
        if let imageString = item.flickr_images.first,
           let imageUrl = URL(string: imageString) {
            rocketImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
