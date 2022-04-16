//
//  HomeCollectionCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit
import Kingfisher

class HomeCollectionCell: UICollectionViewCell {
    var clickMode = false
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
    private let salaryLabel: UILabel = {
        let label = UILabel()
        label.text = "50$"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Boston, MA"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2

        label.textColor = .black
      
        return label
    }()
    
    private let bookmarkIconBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "bookmark.square"), for: UIControl.State.normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(bookmarkClickHandle), for: .touchUpInside)
        return btn
    }()
    
   

//MARK: - bookmarkIconBtn click Handle and send MainVC
    var callBackAddBookmark: ( () -> ())?
    
    @objc func bookmarkClickHandle(){
        bookmarkIconBtn.isHidden = !bookmarkIconBtn.isHidden
        
        NotificationCenter.default.post(name: NSNotification.Name("bookmark"),
                                        object: bookmarkIconBtn.isHidden)
        
        self.callBackAddBookmark?()
       
    }
    
    
//MARK: - SetupViews
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("bookmark"), object: bookmarkIconBtn.isHidden, queue: nil) { _ in
            self.bookmarkIconBtn.isHidden = false
        }
        
    }
    
    
    
    private func setupViews() {
        addSubview(imgCompany)
        addSubview(positionLabel)
        addSubview(bookmarkIconBtn)
        backgroundColor = .white
        
        
        
           
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
           layer.shadowRadius = 10
           layer.shadowOffset = .zero
           layer.shadowOpacity = 1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}


//MARK: - Fill in Cell with data
extension HomeCollectionCell {
    func configure(with myJobModel: JobInfo){
        
        self.companyNameLabel.text = myJobModel.companyName
        guard let url = URL(string: myJobModel.companyLogo ?? "") else { return }
        
        
        
            
        if myJobModel.jobType == "full_time" {
            self.workTimeLabel.text = "Full Time"
        } else if myJobModel.jobType == "part_time" {
            self.workTimeLabel.text = "Part Time"
        } else  if  myJobModel.jobType == "contract" {
            self.workTimeLabel.text = "Contract"
        } else {
            self.workTimeLabel.text = ""
        }
        
        self.imgCompany.kf.setImage(with: url)
        self.locationLabel.text = myJobModel.candidateRequiredLocation
        self.positionLabel.text = myJobModel.title
        self.salaryLabel.text = myJobModel.salary
        
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

        
        let stackView = UIStackView(arrangedSubviews: [companyNameLabel,locationLabel, workTimeLabel, salaryLabel])
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
