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
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
     
        return label
    }()
    
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
       
        return label
    }()
    
    private let workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Seatlle, WA"
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .black
      
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    
    
    private func setupViews() {
        addSubview(imgCompany)
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
                          size: .init(width: 80, height: 100))
        
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,positionLabel, workTimeLabel, locationLabel])
            addSubview(stackView)
        stackView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: imgCompany.leadingAnchor,
                             padding: .init(top: 10, left: 20, bottom: 0, right: 20))
           stackView.axis = .vertical
           stackView.spacing = 10
                                
      
        
    }
}
