//
//  DownloadedListVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 11.04.2022.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class DownloadedListVC: UIViewController{
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
     var generalCollectionView: UICollectionView = {
         let layout = CHTCollectionViewWaterfallLayout()
         layout.itemRenderDirection = .leftToRight
         layout.columnCount = 2
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(DownloadCollectionCell.self,
                    forCellWithReuseIdentifier: DownloadCollectionCell.identifier)
        return cv
    }()
    struct Model {
        let imageName: String
        let height: CGFloat
    }
    
    private var models = [Model]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(generalCollectionView)
        
        let images = Array(1...9).map { "v\($0)"}
        
        
         models = images.compactMap{
            return Model.init(imageName:$0,
                              height:CGFloat.random(in: 200...400))
        }
        
        
        generalCollectionView.fillSuperview()
        generalCollectionView.backgroundColor = .orange
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
        
    }
    
}

extension DownloadedListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DownloadCollectionCell.identifier, for: indexPath) as! DownloadCollectionCell
        
        cell.imageView.image =  UIImage(named: "\(self.models[indexPath.row].imageName)")
       
        return cell
    }
   
}


extension DownloadedListVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width / 2,
                      height: models[indexPath.row].height)
    }
    
    
}

