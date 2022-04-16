//
//  DetailsVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit
import SafariServices
import Kingfisher

class DetailsVC: UIViewController {
    
    var myNumber = 0
    var companyURL = "https://www.youtube.com.tr/"
    var applyURL = "https://www.google.com.tr/"
    var zoomGesture = UIPinchGestureRecognizer()
    var myModel: JobInfo?
    
    var downloadVM = DownloadViewModel()
    
    private let companyImage = AspectFitImageView(image: UIImage(systemName: "house"), cornerRadius: 12)
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Vodafone"
        label.font = .boldSystemFont(ofSize: 17)
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
    
    private let companyWebSiteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Visit Website", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor =  UIColor.myRGB(red: 84, green: 99 , blue: 255)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let descriptionText: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 20)
        tv.textAlignment = .left
        tv.backgroundColor = .white
        tv.text = "lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        tv.layer.cornerRadius = 12
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let applyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Post", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.myRGB(red: 84, green: 99 , blue: 255)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
   
    
    @objc func textZoomHandle(sender: UIPinchGestureRecognizer){
        var pointSize = descriptionText.font?.pointSize
        pointSize = ((sender.velocity > 0) ? 1 : -1) * 1 + pointSize!
        descriptionText.font = UIFont(name: "arial", size: pointSize!)
    }
    

//MARK: -  SetupViews 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addTargetConfig()
        view.backgroundColor = .white
        
        
        
    }
    
    private func setupViews() {
        [ companyImage ,topStackView, descriptionText, applyButton].forEach { view.addSubview($0)}
        [companyLabel,positionLabel, workTimeLabel, locationLabel, companyWebSiteButton].forEach{
            topStackView.addArrangedSubview($0)
        }
        
        zoomGesture = UIPinchGestureRecognizer(target: self,
                                               action: #selector(textZoomHandle(sender:)))
        descriptionText.addGestureRecognizer(zoomGesture)
    }
    
    
//MARK: - DetailsVC buttons handle
    private func addTargetConfig(){
        companyWebSiteButton.addTarget(self, action: #selector(companyGoWebSite), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applyButtonHandle), for: .touchUpInside)
    }
    
    @objc func companyGoWebSite(){
       
        if companyURL.isEmpty {
            let alertControl = UIAlertController(title: "Link broken", message: nil, preferredStyle: .alert)
            alertControl.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertControl, animated: true)
        }
        
        guard let url = URL(string: companyURL) else { return }
        let safariService = SFSafariViewController(url: url)
        self.present(safariService, animated: true)
    }
    
    @objc func applyButtonHandle(){
        
        self.myNumber += 1
        NotificationCenter.default.post(name: NSNotification.Name("refreshTableView"),
                                        object: myNumber)
      
        guard let newModel = self.myModel else {
            return
        }
        
        self.downloadVM.createBookMarkWithIndexPath(bookmarkItem: newModel)
        
        let alert = UIAlertController(title: nil,
                                      message: "Job Saved",
                                      preferredStyle: .actionSheet)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .green.withAlphaComponent(0.2)
        alert.view.tintColor = .black
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        self.applyButton.isHidden = true
    }
    
    
//MARK: - Constraints
    private func setConstraints(){
        companyImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 10, left: 10, bottom: 10, right: 10),
                            size: .init(width: 80, height: 100))
        
        topStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            leading: view.leadingAnchor,
                            bottom: nil,
                            trailing: companyImage.leadingAnchor,
                            padding: .init(top: 10, left: 20, bottom:20, right:20))
        
        
        companyWebSiteButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        
        descriptionText.anchor(top: topStackView.bottomAnchor,
                               leading: view.leadingAnchor,
                               bottom: nil,
                               trailing: view.trailingAnchor,
                               padding: .init(top: 10,
                                              left: 10,
                                              bottom: 20,
                                              right: 10))
        
        applyButton.anchor(top: descriptionText.bottomAnchor,
                           leading: view.leadingAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           trailing: view.trailingAnchor,
                           padding: .init(top: 10,
                                          left:80,
                                          bottom: 30,
                                          right: 80))
    }

  

}


//MARK: - Fill Data
extension DetailsVC {
    
    public func configure(with model: JobInfo ) {
        self.myModel = model
        self.companyLabel.text = model.companyName
        guard let url = URL(string: model.companyLogo ?? "") else { return }
        self.companyImage.kf.setImage(with: url)
        self.descriptionText.attributedText = model.jobDescription?.htmlToAttributedString
        self.locationLabel.text = model.candidateRequiredLocation
        self.positionLabel.text = model.title
        self.companyURL = model.url ?? ""
    }
}

