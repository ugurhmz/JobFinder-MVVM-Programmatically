//
//  DownloadCollectionCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 15.04.2022.
//

import UIKit

class DownloadTableCell: UITableViewCell {
    static var identifier =  "DownloadTableCell"
    
    private let imgCompany: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house")
        iv.contentMode = .scaleAspectFill
  
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgCompany)
        contentView.addSubview(positionLabel)
        contentView.addSubview(stackView)
        [companyNameLabel,positionLabel, locationLabel].forEach { stackView.addArrangedSubview($0)}
        
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}



//MARK: -
extension DownloadTableCell {
    private func setConstraints(){
        imgCompany.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: stackView.leadingAnchor,
                          padding: .init(top: 5, left:10, bottom: 0, right: 10))
        
        stackView.anchor(top: topAnchor,
                         leading: imgCompany.trailingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor ,
                         size: CGSize(width: 200, height: 100)
        )
    }
}
