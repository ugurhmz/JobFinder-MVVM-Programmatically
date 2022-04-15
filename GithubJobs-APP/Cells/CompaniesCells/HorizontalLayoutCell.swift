//
//  HorizontalLayoutCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 15.04.2022.
//

import UIKit

class HorizontalLayoutCell: UICollectionViewCell {
    
    static var identifier = "HorizontalLayoutCell"
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
        label.font = .systemFont(ofSize: 21)
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    
    private let workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Boston, MA"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
      
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgCompany)
    
       setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: -  Fill in data
extension HorizontalLayoutCell {
    func configure(with jobModel: JobInfo) {
        print("configure", jobModel)
        self.companyNameLabel.text = jobModel.title
    }
}



extension HorizontalLayoutCell {
    private func setConstraints(){

        
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,locationLabel, workTimeLabel])
            addSubview(stackView)
        stackView.anchor(top: imgCompany.bottomAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                         trailing: imgCompany.trailingAnchor,
                             padding: .init(top: 10, left: 0, bottom: 2, right:0))
        
      
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 4
               
        
        imgCompany.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: stackView.topAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
}

