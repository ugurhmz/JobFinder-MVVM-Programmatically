//
//  HomeCollectionCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    static var identifier = "HomeCollectionCell"
    var stackView = UIStackView()
    
    private let imgCompany: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house")
        iv.contentMode = .scaleAspectFill
  
        return iv
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Huawei"
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Boston, MA"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .black
      
        return label
    }()
    
    private let bookmarkIconBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "bookmark.square"), for: UIControl.State.normal)
        btn.tintColor = .black
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    
    
    private func setupViews() {
        addSubview(imgCompany)
        addSubview(positionLabel)
        addSubview(bookmarkIconBtn)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}

//MARK: - Constraints
extension HomeCollectionCell {
    private func setConstraints(){
        imgCompany.anchor(top: topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 10, left: 10, bottom: 0, right: 10),
                          size: .init(width: 70, height: 70))

        
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,locationLabel, workTimeLabel])
            addSubview(stackView)
        stackView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: imgCompany.leadingAnchor,
                             padding: .init(top: 10, left: 20, bottom: 0, right: 20))
           stackView.axis = .vertical
           stackView.spacing = 10
//        stackView.layer.borderWidth = 1
//        stackView.layer.borderColor = UIColor.red.cgColor
      
        
        positionLabel.anchor(top: stackView.bottomAnchor,
                             leading: stackView.leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        bookmarkIconBtn.anchor(top: nil,
                            leading: nil,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: 10, left: 10, bottom: 20, right: 10),
                            size: .init(width: 35, height: 40))
    }
}
