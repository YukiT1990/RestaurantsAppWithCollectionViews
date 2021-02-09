//
//  LinearLayoutCollectionViewCell.swift
//  RestaurantsApp
//
//  Created by Yuki Tsukada on 2021/02/09.
//

import UIKit

class LinearLayoutCollectionViewCell: UICollectionViewCell {
    let contentViewSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        return sv
    }()
    let labelsSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        return sv
    }()
    let nameContainerSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        return sv
    }()
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 16.0)
        return lb
    }()
    let priceRangeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14.0)
        lb.textAlignment = .right
        return lb
    }()
    let imageContainer: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 12.0)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentViewSV)
        contentViewSV.addArrangedSubview(imageContainer)
        contentViewSV.addArrangedSubview(labelsSV)
        labelsSV.addArrangedSubview(nameContainerSV)
        labelsSV.addArrangedSubview(descriptionLabel)
        nameContainerSV.addArrangedSubview(nameLabel)
        nameContainerSV.addArrangedSubview(priceRangeLabel)
        
        contentView.backgroundColor = .white
        
        nameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            contentViewSV.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            contentViewSV.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            imageContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5),
            
            nameContainerSV.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3),
            nameLabel.leadingAnchor.constraint(equalTo: labelsSV.leadingAnchor, constant: 10),
            priceRangeLabel.widthAnchor.constraint(equalTo: nameContainerSV.widthAnchor, multiplier: 1/5),
            priceRangeLabel.trailingAnchor.constraint(equalTo: labelsSV.trailingAnchor, constant: -10),
            
            descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/3),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsSV.leadingAnchor, constant: 10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
