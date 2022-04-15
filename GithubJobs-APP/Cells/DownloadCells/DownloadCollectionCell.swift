//
//  DownloadCollectionCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 15.04.2022.
//

import UIKit

class DownloadCollectionCell: UICollectionViewCell {
    static var identifier =  "DownloadCollectionCell"
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"v1")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}
