//
//  DownloadCollectionCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 15.04.2022.
//

import UIKit
import Kingfisher

class DownloadTableCell: UITableViewCell {
    static var identifier =  "DownloadTableCell"
    
    private let imgCompany: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    var companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Huawei"
        label.font = .systemFont(ofSize: 21)
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private let workTime: UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemBlue
        
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
    
    var salaryLabel: UILabel = {
        let label = UILabel()
        label.text = "50$"
        label.font = .systemFont(ofSize: 21)
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgCompany)
        contentView.addSubview(stackView)
        [companyNameLabel,positionLabel, locationLabel, salaryLabel ,workTime].forEach { stackView.addArrangedSubview($0)}
        
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}



//MARK: - Fill data
extension DownloadTableCell {
    func configureWithEntity(jobEntity: GithubEntity){
       
        
        guard let salary = jobEntity.salary else  {
            return
        }
        print("newsalary",salary)
        self.salaryLabel.text = "\(salary)"
        
        guard let url = URL(string: jobEntity.companyLogo ?? "") else { return }
        self.imgCompany.kf.setImage(with: url)
        
        if jobEntity.jobType == "full_time" {
            self.workTime.text = "Full Time"
        } else if jobEntity.jobType == "part_time" {
            self.workTime.text = "Part Time"
        } else  if  jobEntity.jobType == "contract" {
            self.workTime.text = "Contract"
        } else {
            self.workTime.text = ""
        }
        
        self.companyNameLabel.text = jobEntity.companyName
        
    }
}



//MARK: -
extension DownloadTableCell {
    private func setConstraints(){
        imgCompany.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: nil,
                          padding: .init(top: 10, left:10, bottom: 10, right: 10),
                          size: .init(width: 200, height: 80)
        
        )
        
        stackView.anchor(top: topAnchor,
                         leading: imgCompany.trailingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor
        )
    }
}
