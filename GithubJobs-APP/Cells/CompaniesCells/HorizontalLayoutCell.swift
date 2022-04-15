//
//  HorizontalLayoutCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 15.04.2022.
//

import UIKit
import Kingfisher

class HorizontalLayoutCell: UICollectionViewCell {
    
    static var identifier = "HorizontalLayoutCell"
    var stackView = UIStackView()
    
    private let imgCompany: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house")
        iv.contentMode = .scaleToFill
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
    
    
    private let jobTitle: UILabel = {
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
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(rect:  layer.bounds).cgPath
                layer.shadowRadius = 2
                layer.shadowOffset = .zero
        layer.shadowOpacity = 0.8
        
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
       
        guard let url = URL(string: jobModel.companyLogo ?? "") else { return }
        
       // let workType = myJobModel.jobType?.rawValue
        
//        if ((workType?.contains("full_time")) != nil) {
//            self.workTimeLabel.text = "Full Time"
//        } else if ((workType?.contains("full_time")) != nil) {
//            self.workTimeLabel.text = "Part Time"
//        } else {
//            self.workTimeLabel.text = workType
//        }
//
//
        
        self.imgCompany.kf.setImage(with: url)
        self.companyNameLabel.text = jobModel.companyName
        self.jobTitle.text  = jobModel.title
        self.locationLabel.text = jobModel.candidateRequiredLocation
    }
}



extension HorizontalLayoutCell {
    private func setConstraints(){

        
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,locationLabel, jobTitle])
            addSubview(stackView)
        stackView.anchor(top: imgCompany.bottomAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                         trailing: imgCompany.trailingAnchor,
                             padding: .init(top: 10, left: 0, bottom: 8, right:0))
        
      
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 4
               
        
        imgCompany.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: stackView.topAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                          size: CGSize(width: 50, height: 68)
        )
    }
}

