//
//  CompaniesTableViewCell.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 14.04.2022.
//

import UIKit

class CompaniesTableViewCell: UITableViewCell {

    static var identifier = "CompaniesTableViewCell"
    private var swiftList: [JobInfo] = [JobInfo]()
    
    private  let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.showsHorizontalScrollIndicator = false
        cv.register(HorizontalLayoutCell.self,
                    forCellWithReuseIdentifier: HorizontalLayoutCell.identifier)
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    private func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
       
        
    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds  // NOT -> Bunu bu cell'de viewDidLoad içinde yazdığında çalışmıyor. Burada yaz.
    }
}
extension CompaniesTableViewCell {
    func configure(with myModel: [JobInfo] ) {
        print("myModel", myModel.count)
        
        self.swiftList = myModel
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}


//MARK: - Delegate, DataSource
extension CompaniesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.swiftList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flowCell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalLayoutCell.identifier, for: indexPath) as! HorizontalLayoutCell
        flowCell.backgroundColor = .white
        
        flowCell.configure(with: swiftList[indexPath.row])
        return flowCell
    }
  
    
    
    
    
    
}

extension CompaniesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 2.5,
                      height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 55
    }
    
}
