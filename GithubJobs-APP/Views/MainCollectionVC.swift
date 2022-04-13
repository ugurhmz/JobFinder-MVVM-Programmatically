//
//  MainUICollectionVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit



class MainCollectionVC: UICollectionViewController{
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    let jobTitles = ["All","iOS", "FullStack"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: jobTitles)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .black
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 10
        control.layer.masksToBounds = true
        control.addTarget(self, action: #selector(handleSegmentedControlValueChanged(_:)), for: .valueChanged)
        
       
        return control
    }()
    
    
    
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("all")
            
        case 1:
            print("ios")
        case 2:
            print("full")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchBarConfigure()
    }
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        segmentedControlConfigure()

        collectionView.backgroundColor = .lightGray
        collectionView.register(HomeCollectionCell.self,
                                forCellWithReuseIdentifier: HomeCollectionCell.identifier)
    }
    
    private func segmentedControlConfigure(){
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.leadingAnchor,
                                bottom:  collectionView.topAnchor,
                                trailing: view.trailingAnchor,
                                padding: .init(top: 5, left: 20, bottom: 30, right: 20),
                                size: .init(width: 100, height: 70)
        )
    }
    
    private func  searchBarConfigure() {
        customSearchBarStyle()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = self.searchController
        searchController.searchBar.tintColor  = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        searchController.searchBar.barTintColor = .black
       
    }
    
    private func customSearchBarStyle(){
        
         if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            //navBarAppearance.configureWithOpaqueBackground()

            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 32.0)!]
           
             navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.title = "Job Finder®"

            }
         
    }
    
   
    
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


//MARK: - DelegateFlowLayout
extension MainCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width / 2) - 10,
                      height: 200)
    }
    
   
   
}


//MARK: - SearchBarDelegate
extension MainCollectionVC: UISearchBarDelegate  {
    
}


//MARK: -  CollectionView funcs
extension MainCollectionVC {
    
    //  Navbar  <- Olan Uzaklığı.  -> TabBar
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 56.0, left: 5.0, bottom: 20, right: 5.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 20
     }
    
    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
       return 7
    }

   
    
    // cellForItemAt
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else {
            return UICollectionViewCell()
        }
  
        
        homeCell.layer.cornerRadius = 25
        return homeCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsVC()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
  
    
}
