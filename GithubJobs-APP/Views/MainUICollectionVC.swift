//
//  MainUICollectionVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit



class MainUICollectionVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HomeCollectionCell.self,
                                forCellWithReuseIdentifier: HomeCollectionCell.identifier)
    }
    
    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
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
        
        return CGSize(width: view.frame.width - 15,
                      height: 200)
    }
}
