//
//  CuisineTypeCollectionViewCell.swift
//  RestaurantsApp
//
//  Created by Yuki Tsukada on 2021/02/07.
//

import UIKit

class CuisineTypeCollectionViewCell: UICollectionViewCell {
    
    let cuisineTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .white
        lb.textColor = UIColor(hex: "#3399ff")
        lb.textAlignment = .center
        return lb
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cuisineTypeLabel)
        
        NSLayoutConstraint.activate([
            cuisineTypeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            cuisineTypeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            cuisineTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cuisineTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
