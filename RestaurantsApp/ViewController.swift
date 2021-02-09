//
//  ViewController.swift
//  RestaurantsApp
//
//  Created by Yuki Tsukada on 2021/02/07.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // data
    private let restaurants: [Restaurant] = [
        Restaurant(name: "Soleil", image: UIImage(named: "soleil"), type: Restaurant.CuisineType.French, mealTime: [Restaurant.MealTime.breakfast, Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Cheval Blanc", image: UIImage(named: "chevalBlanc"), type: Restaurant.CuisineType.French, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Hananoki", image: UIImage(named: "hananoki"), type: Restaurant.CuisineType.Japanese, mealTime: [Restaurant.MealTime.lunch], cost: Restaurant.PriceRange.high),
        Restaurant(name: "Takoyaki Kazuchan", image: UIImage(named: "Kazu"), type: Restaurant.CuisineType.Japanese, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.low),
        Restaurant(name: "Ton Galliano", image: UIImage(named: "tonGalliano"), type: Restaurant.CuisineType.Italian, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Midtown BBQ", image: UIImage(named: "midtownBBQ"), type: Restaurant.CuisineType.American, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Maya", image: UIImage(named: "maya"), type: Restaurant.CuisineType.Indian, mealTime: [Restaurant.MealTime.breakfast, Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Afu", image: UIImage(named: "afu"), type: Restaurant.CuisineType.Chinese, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.low),
        Restaurant(name: "Hanmaru", image: UIImage(named: "hanmaru"), type: Restaurant.CuisineType.Korean, mealTime: [Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Cala Carmen", image: UIImage(named: "calaCarmen"), type: Restaurant.CuisineType.Spanish, mealTime: [Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        // alter
        Restaurant(name: "KRAL", image: UIImage(named: "kral"), type: Restaurant.CuisineType.Turkish, mealTime: [Restaurant.MealTime.lunch], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Matryoshka", image: UIImage(named: "matryoshka"), type: Restaurant.CuisineType.Russian, mealTime: [Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Tsukiji Aozora Sandaime", image: UIImage(named: "tsukiji"), type: Restaurant.CuisineType.Japanese, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.high),
        Restaurant(name: "Tasuke", image: UIImage(named: "tasuke"), type: Restaurant.CuisineType.Japanese, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium),
        Restaurant(name: "Chinese Cafe Eight Akasaka", image: UIImage(named: "eightAkasaka"), type: Restaurant.CuisineType.Chinese, mealTime: [Restaurant.MealTime.lunch, Restaurant.MealTime.dinner], cost: Restaurant.PriceRange.medium)
    ]
    
    var sortedRestaurants: [Restaurant] = []
    lazy var filteredReataurants: [Restaurant] = self.restaurants
    
    lazy var restaurantsByCuisineType: [Restaurant.CuisineType: [Restaurant]] = self.filteredReataurants.reduce([:]) { (existing, element) in
        return existing.merging([element.type: [element]]) { (old, new) in
        return old + new
      }
    }
    
    lazy var cuisineTypeArray: [Restaurant.CuisineType] = [Restaurant.CuisineType](restaurantsByCuisineType.keys)
    var sortedCuisineTypeArray: [Restaurant.CuisineType] = []
    var cuisineTypeStringArray: [String] = []
    
    // stackView
    let collectionViewsContainerSV: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = CGFloat(10)
        return sv
    }()
    // collectionViews
    let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 35)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.frame.size.height = layout.itemSize.height
        layout.scrollDirection = .horizontal
        return cv
    }()
    let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        return cv
    }()
    private let collectionView1Identifier = "CuisineTypeCell"
    private let collectionView2IdentifierGeneral = "RestaurantCellGeneral"
    private let collectionView2IdentifierLinear = "RestaurantCellLinear"
    var generalLayout: Bool = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        
        sortedRestaurants = self.restaurants.sorted { $0.name < $1.name }
        filteredReataurants = sortedRestaurants
        
        sortedCuisineTypeArray = self.cuisineTypeArray.sorted(by: { $0.rawValue < $1.rawValue })
        
        for each in sortedCuisineTypeArray {
        cuisineTypeStringArray.append(each.rawValue)
        }
    }
    
    func createLayout() {
        view.backgroundColor = UIColor(hex: "#d9d9d9")
        collectionView1.backgroundColor = UIColor(hex: "#d9d9d9")
        collectionView2.backgroundColor = UIColor(hex: "#d9d9d9")
        
        // Initialize the collection views, set the desired frames
        var topbarHeight: CGFloat {
                return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
            }
        let collectionView1Height: CGFloat = 100
        let space: CGFloat = 10
        collectionView1.frame = CGRect(x: 0, y: topbarHeight + space, width: view.frame.width, height: collectionView1Height)
        collectionView2.frame = CGRect(x: 0, y: topbarHeight + collectionView1Height + space * 2, width: view.frame.width, height: view.frame.height - collectionView1Height - 45)
        
        collectionView1.delegate = self
        collectionView2.delegate = self

        collectionView1.dataSource = self
        collectionView2.dataSource = self
        
        // Register cell classes
        collectionView1.register(CuisineTypeCollectionViewCell.self, forCellWithReuseIdentifier: collectionView1Identifier)
        collectionView2.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: collectionView2IdentifierGeneral)
        // linearLayout
        collectionView2.register(LinearLayoutCollectionViewCell.self, forCellWithReuseIdentifier: collectionView2IdentifierLinear)
        
        // Set layout
        collectionView2.setCollectionViewLayout(generateLayoutForRestaurants(), animated: true)
        generalLayout = true
        
        // Add subviews
        self.view.addSubview(collectionViewsContainerSV)
        collectionViewsContainerSV.addArrangedSubview(collectionView1)
        collectionViewsContainerSV.addArrangedSubview(collectionView2)
        
        // Constraints
        NSLayoutConstraint.activate([
            collectionViewsContainerSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionViewsContainerSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionViewsContainerSV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewsContainerSV.widthAnchor.constraint(equalTo: view.widthAnchor),

            collectionView1.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        // Navigation bar
        self.navigationItem.title = "My Restaurants"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#3399ff")
//        let customFont = UIFont(name: "Arial", size: 40.0)!
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "＝", style: .plain, target: self, action: #selector(changeLayout))
    }
    
    
    @objc func changeLayout() {
        if generalLayout {
            // when generalLayout
            // change to linearLayout
            collectionView2.setCollectionViewLayout(linearLayoutForRestaurants(), animated: true)
//            collectionView2.register(LinearLayoutCollectionViewCell.self, forCellWithReuseIdentifier: collectionView2IdentifierLinear)
            
            navigationItem.rightBarButtonItem?.title = "◻︎"
            generalLayout = false
        } else {
            // when linearLayout
            // change to generalLayout
            collectionView2.setCollectionViewLayout(generateLayoutForRestaurants(), animated: true)
//            collectionView2.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: collectionView2IdentifierGeneral)
            
            navigationItem.rightBarButtonItem?.title = "＝"
            generalLayout = true
        }
//        collectionView2.delegate = self
//        collectionView2.dataSource = self
//        collectionView2.reloadData()
//        collectionView2.updateConstraints()
        
    }
    
    // numberOfItemsInSection function
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            // collectionView1
            return cuisineTypeStringArray.count
        } else {
            // collectionView2
            return filteredReataurants.count
        }
    }
    
    // cellForItemAtIndexPath delegate function
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView1 {
            // collectionView1
            let cell1 = collectionView1.dequeueReusableCell(withReuseIdentifier: collectionView1Identifier, for: indexPath) as! CuisineTypeCollectionViewCell
            cell1.cuisineTypeLabel.text = cuisineTypeStringArray[indexPath.row]
            return cell1
        } else {
            // collectionView2
            if generalLayout {
                // generalLayout
                let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: collectionView2IdentifierGeneral, for: indexPath) as! BasicCollectionViewCell
                cell2.nameLabel.text = filteredReataurants[indexPath.row].name
                cell2.priceRangeLabel.text = filteredReataurants[indexPath.row].cost.rawValue
                cell2.imageContainer.contentMode =  UIView.ContentMode.scaleAspectFill
                cell2.imageContainer.image = filteredReataurants[indexPath.row].image

                let mealTimeArrayTemp: [Restaurant.MealTime] = filteredReataurants[indexPath.row].mealTime
                var mealTimeStringArrayTemp: [String] = []
                for each in mealTimeArrayTemp {
                    mealTimeStringArrayTemp.append(each.rawValue)
                }

                cell2.descriptionLabel.text = "\(filteredReataurants[indexPath.row].type) - \(mealTimeStringArrayTemp.joined(separator: ", "))"
                
                return cell2
            } else {
                // linearLayout
                let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: collectionView2IdentifierLinear, for: indexPath) as! LinearLayoutCollectionViewCell
                cell2.nameLabel.text = filteredReataurants[indexPath.row].name
                cell2.priceRangeLabel.text = filteredReataurants[indexPath.row].cost.rawValue
                cell2.imageContainer.contentMode =  UIView.ContentMode.scaleAspectFill
                cell2.imageContainer.image = filteredReataurants[indexPath.row].image

                let mealTimeArrayTemp: [Restaurant.MealTime] = filteredReataurants[indexPath.row].mealTime
                var mealTimeStringArrayTemp: [String] = []
                for each in mealTimeArrayTemp {
                    mealTimeStringArrayTemp.append(each.rawValue)
                }

                cell2.descriptionLabel.text = "\(filteredReataurants[indexPath.row].type) - \(mealTimeStringArrayTemp.joined(separator: ", "))"
                
                return cell2
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1 {
            collectionView1.allowsMultipleSelection = true
//            print("cuisine type \(cuisineTypeStringArray[indexPath.row])")
//            print(collectionView1.indexPathsForSelectedItems!)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CuisineTypeCollectionViewCell {
                
                var selectedCategories: [Restaurant.CuisineType] = []
                var selectedCategoriesString: [String] = []
                var selectedRestaurants: [Restaurant] = []
                filteredReataurants = []
                for index in collectionView1.indexPathsForSelectedItems! {
                    selectedCategories.append(sortedCuisineTypeArray[index[1]])
                    selectedCategoriesString.append(sortedCuisineTypeArray[index[1]].rawValue)
                }
                for category in selectedCategories {
                    selectedRestaurants = restaurants.filter({
                        $0.type == category
                    })
                    filteredReataurants.append(contentsOf: selectedRestaurants)
                }
                
                if collectionView1.indexPathsForSelectedItems!.isEmpty {
                    filteredReataurants = sortedRestaurants
                }
                
                if cell.isSelected {
                    cell.cuisineTypeLabel.backgroundColor = UIColor(hex: "#3399ff")
                    cell.cuisineTypeLabel.textColor = .white
                }
            }
        }
        collectionView2.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView1 {
            collectionView1.allowsMultipleSelection = true
//            print("deselected cuisine type \(cuisineTypeStringArray[indexPath.row])")
            if let cell = collectionView.cellForItem(at: indexPath) as? CuisineTypeCollectionViewCell {
                cell.cuisineTypeLabel.backgroundColor = .white
                cell.cuisineTypeLabel.textColor = UIColor(hex: "#3399ff")
            }
            var selectedCategories: [Restaurant.CuisineType] = []
            var selectedCategoriesString: [String] = []
            var selectedRestaurants: [Restaurant] = []
            filteredReataurants = []
            for index in collectionView1.indexPathsForSelectedItems! {
                selectedCategories.append(sortedCuisineTypeArray[index[1]])
                selectedCategoriesString.append(sortedCuisineTypeArray[index[1]].rawValue)
            }
            for category in selectedCategories {
                selectedRestaurants = restaurants.filter({
                    $0.type == category
                })
                filteredReataurants.append(contentsOf: selectedRestaurants)
            }
            if collectionView1.indexPathsForSelectedItems!.isEmpty {
                filteredReataurants = sortedRestaurants
            }
        }
        collectionView2.reloadData()
    }
    
    private func generateLayoutForRestaurants() -> UICollectionViewLayout {
        let spacing: CGFloat = 5
        // for collectionView2
        // 1. define item
        let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
        item2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        // 2. define group
        let groupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize2, subitem: item2, count: 2)
        group2.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

        // 3. define section
        let section2 = NSCollectionLayoutSection(group: group2)

        section2.interGroupSpacing = spacing
        

        return UICollectionViewCompositionalLayout(section: section2)
        
    }
    
    private func linearLayoutForRestaurants() -> UICollectionViewLayout  {
        let spacing: CGFloat = 5
        // for collectionView2
        // 1. define item
        let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
        item2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        // 2. define group
        let groupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize2, subitem: item2, count: 1)
        group2.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)

        // 3. define section
        let section2 = NSCollectionLayoutSection(group: group2)

        section2.interGroupSpacing = spacing
        

        return UICollectionViewCompositionalLayout(section: section2)
    }
}

