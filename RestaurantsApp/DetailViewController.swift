//
//  DetailViewController.swift
//  RestaurantsApp
//
//  Created by Yuki Tsukada on 2021/02/10.
//

import UIKit

class DetailViewController: UIViewController {
    let layoutContainerSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        sv.spacing = 10
        return sv
    }()
    let headerSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        sv.backgroundColor = UIColor(hex: "#3399ff")
        sv.spacing = 10
        return sv
    }()
    let dismissButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("◁", for: .normal)
//        bt.backgroundColor = UIColor(hex: "#3399ff")
        bt.setTitleColor(UIColor(hex: "#0047b3"), for: .normal)
        bt.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
//        bt.backgroundColor = .red
        bt.frame.size.width = 40
        bt.frame.size.height = 40
        return bt
    }()
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Restaurant Name"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 40)
        return lb
    }()
    let rightSpace: UILabel = {
        let lb = UILabel()
        lb.text =  " "
        lb.frame.size.width = 40
        lb.frame.size.height = 40
        return lb
    }()
    let typeCostContainerSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.backgroundColor = .white
        sv.spacing = 10
        return sv
    }()
    let cuisineTypeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Cuisine Type"
        lb.textAlignment = .center
//        lb.textColor = UIColor(hex: "#858EC5")
        lb.font = UIFont.systemFont(ofSize: 24)
        return lb
    }()
    let priceRangeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Cost"
        lb.textAlignment = .center
//        lb.textColor = UIColor(hex: "#858EC5")
        lb.font = UIFont.systemFont(ofSize: 24)
        return lb
    }()
    let mealTimeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Meal Time"
        lb.textAlignment = .center
//        lb.textColor = UIColor(hex: "#858EC5")
        lb.backgroundColor = .white
        lb.font = UIFont.systemFont(ofSize: 24)
        return lb
    }()
    let restaurantImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var targetRestaurant: Restaurant?
    var defaultRestaurant: Restaurant = Restaurant(name: "Default", image: UIImage(named: "hananoki"), type: Restaurant.CuisineType.Japanese, mealTime: [Restaurant.MealTime.lunch], cost: Restaurant.PriceRange.high)

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        
        print("targetRestaurant \(targetRestaurant ?? defaultRestaurant)")

        // Do any additional setup after loading the view.
    }
    

    func createLayout() {
        view.backgroundColor = .white
        layoutContainerSV.backgroundColor = UIColor(hex: "#d9d9d9")
        
        // Add subviews
        view.addSubview(layoutContainerSV)
        layoutContainerSV.addArrangedSubview(headerSV)
        headerSV.addArrangedSubview(dismissButton)
        headerSV.addArrangedSubview(nameLabel)
        headerSV.addArrangedSubview(rightSpace)
        layoutContainerSV.addArrangedSubview(typeCostContainerSV)
        layoutContainerSV.addArrangedSubview(mealTimeLabel)
        layoutContainerSV.addArrangedSubview(restaurantImage)
        typeCostContainerSV.addArrangedSubview(cuisineTypeLabel)
        typeCostContainerSV.addArrangedSubview(priceRangeLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            layoutContainerSV.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            layoutContainerSV.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            priceRangeLabel.widthAnchor.constraint(equalTo: typeCostContainerSV.widthAnchor, multiplier: 1/6),
            rightSpace.widthAnchor.constraint(equalTo: dismissButton.widthAnchor)
        ])
        
        let mealTimeArrayTemp: [Restaurant.MealTime] = targetRestaurant!.mealTime
        var mealTimeStringArrayTemp: [String] = []
        for each in mealTimeArrayTemp {
            mealTimeStringArrayTemp.append(each.rawValue)
        }
        
        nameLabel.text = targetRestaurant?.name
        cuisineTypeLabel.text = "Cuisine Type: \(targetRestaurant!.type.rawValue)"
        priceRangeLabel.text = targetRestaurant?.cost.rawValue
        mealTimeLabel.text = "Available at \(mealTimeStringArrayTemp.joined(separator: ", "))"
        restaurantImage.image = targetRestaurant?.image
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

}
