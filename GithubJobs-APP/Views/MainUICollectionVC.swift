//
//  MainUICollectionVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit



class MainUICollectionVC: UICollectionViewController{
    
    private let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.register(HomeCollectionCell.self,
                                forCellWithReuseIdentifier: HomeCollectionCell.identifier)
        searchBarConfigure()
    }
    
    
    
    private func  searchBarConfigure() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = self.searchController
        searchController.searchBar.tintColor  = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        searchController.searchBar.barTintColor = .black
       
    }
    
   
    
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - DelegateFlowLayout
extension MainUICollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20,
                      height: 180)
    }
}


//MARK: - SearchBarDelegate
extension MainUICollectionVC: UISearchBarDelegate  {
    
}


//MARK: -  CollectionView funcs
extension MainUICollectionVC {
    
    
    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
       return 7
    }

    
    // cellForItemAt
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else {
            return UICollectionViewCell()
        }
        
        homeCell.backgroundColor = UIColor(hue: CGFloat(drand48()),
                                           saturation: 1,
                                           brightness: 1,
                                           alpha: 1)
        homeCell.layer.cornerRadius = 25
        return homeCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsVC()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
