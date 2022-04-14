//
//  MainUICollectionVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 10.04.2022.
//

import UIKit


protocol JobSearchOutputProtocol {
    func saveSearchJobs(jobInfoList: [JobInfo])
}

class MainCollectionVC: UICollectionViewController{
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var downloadVM = DownloadViewModel()
    private var jobDataList: [JobInfo] = [JobInfo]()
    private var searchJobDataList: [JobInfo] = [JobInfo]()
    private var searchMode = false
    
    let jobTitles = ["All 13","iOS", "FullStack", "Swift"]
    var jobViewModel = JobsViewModel()
    
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
    
    
    // Segmented Handle
    @objc func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("all")
            
            self.jobViewModel.getSearchingJobs(with: "software%20development")
          
        case 1:
            self.jobViewModel.getSearchingJobs(with: "ios%20developer")
        case 2:
            self.jobViewModel.getSearchingJobs(with: "full%20stack")
            print("full")
        case 3:
            self.jobViewModel.getSearchingJobs(with: "swift")
            print("Swift")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchBarConfigure()
        jobViewModel.setSearchDelegate(output: self)
        jobViewModel.getSearchingJobs(with: "software%20development")
        
    }
    
    private func setupViews() {
        view.addSubview(segmentedControl)
      
        segmentedControlConfigure()

        collectionView.backgroundColor = .lightGray
        collectionView.register(HomeCollectionCell.self,
                                forCellWithReuseIdentifier: HomeCollectionCell.identifier)
    }
    func addCounter(count: Int)->UIView {
        // Count > 0, show count
        if count > 0 {

            // Create label
            let fontSize: CGFloat = 10
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.textAlignment = .center
            label.textColor = .white
            label.backgroundColor = .red

            // Add count to label and size to fit
            label.text = "\(NSNumber(value: count))"
            label.sizeToFit()

            // Adjust frame to be square for single digits or elliptical for numbers > 9
            var frame: CGRect = label.frame
            frame.size.height += CGFloat(Int(0.4 * fontSize))
            frame.size.width =  frame.size.width + CGFloat(Int(fontSize) +   15)
            label.frame =  CGRect(x: 15, y: -10, width: 30, height: 30)

            // Set radius and clip to bounds
            label.layer.cornerRadius = frame.size.height / 2.0
            label.clipsToBounds = true

            // Show label in accessory view and remove disclosure
            return label

        } else {
            return UIView()
        }
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


//MARK: -

extension MainCollectionVC: JobSearchOutputProtocol {
    
    func saveSearchJobs(jobInfoList: [JobInfo]) {
        DispatchQueue.main.async {
            print("result", jobInfoList.count)
            self.jobDataList = jobInfoList
           
            self.navigationController?.navigationBar.addSubview(self.addCounter(count: jobInfoList.count))
            
            self.collectionView.reloadData()
        }
    }
}



//MARK: - UISearchBarDelegate
extension MainCollectionVC: UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        

        
        guard var query = searchBar.text?.lowercased(),
                             !query.trimmingCharacters(in: .whitespaces).isEmpty,
                             query.trimmingCharacters(in: .whitespaces).count > 0
                else { return}

        if query.contains(" ") {
            query =  searchBar.text?.replacingOccurrences(of: " ", with: "%20") ?? ""
        }
        if query.contains("ı") {
            query =  searchBar.text?.replacingOccurrences(of: "ı", with: "i") ?? ""
        }
     
        print("query",query.first)
        self.jobViewModel.getSearchingJobs(with: query)
         
    }
    
  
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.jobViewModel.getSearchingJobs(with: "swift")
            self.collectionView.reloadData()
        }
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
        return   jobDataList.count
    }

   
    
    // cellForItemAt
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else {
            return UICollectionViewCell()
        }

        homeCell.configure(with: jobDataList[indexPath.row])
        
        
        
        // Cell içindeki bookmarkBtn tıklanınca, burası tetikleniyor.
        homeCell.callBackAddBookmark = {
            print("callback", indexPath.row)
            self.downloadVM.createBookMarkWithIndexPath(bookmarkItem: self.jobDataList[indexPath.row])
        }
        
        homeCell.layer.cornerRadius = 25
        return homeCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsVC()
        print("myrow",self.jobDataList[indexPath.row])
        detailsVC.configure(with: self.jobDataList[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
     
}
