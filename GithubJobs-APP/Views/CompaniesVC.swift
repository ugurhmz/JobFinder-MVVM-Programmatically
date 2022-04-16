//
//  CompaniesVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 11.04.2022.
//

import UIKit


protocol CompaniesOutPutProtocol {
    func saveSwiftJobsList(jobValues: [JobInfo])
    func saveiOsJobsList(jobValues: [JobInfo])
    func saveFrontList(jobValues: [JobInfo])
    func saveBackendList(jobValues: [JobInfo])
    func saveDevopsList(jobValues: [JobInfo])
    func saveMarketingManagerList(jobValues: [JobInfo])
    func savefullStackList(jobValues: [JobInfo])
    
}


enum Sections: Int {
    case Swift = 0
    case iOS = 1
    case FrontEnd = 2
    case FullStack = 3
    case BackEnd = 4
    case  DevOps = 5
    case MarketingManager = 6
}


class CompaniesVC: UIViewController {
    
    let searchBar = UISearchBar()
    
    var jobViewModel = JobsViewModel()
    var viewModel = JobsViewModel()
    let jobTitles: [String] = ["Swift","iOS", "Front End", "Full Stack", "Back End", "DevOps", "Marketing Manager"]
    
    private lazy var swiftJobsList: [JobInfo] = []
    private lazy var frontList: [JobInfo] = []
    private lazy var backendList: [JobInfo] = []
    private lazy var devopsList: [JobInfo] = []
    private lazy var marketingList: [JobInfo] = []
    private lazy var fullStackList: [JobInfo] = []
    private lazy var iosList: [JobInfo] = []
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CompaniesTableViewCell.self,
                           forCellReuseIdentifier: CompaniesTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        return tableView
    }()
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.setCompanyDelagte(output: self)
        viewModel.getSearchingJobs(with: "swift")
        viewModel.getSearchingJobs(with: "ios%20developer")
        viewModel.getSearchingJobs(with: "front%20end")
        viewModel.getSearchingJobs(with: "back%20end")
        viewModel.getSearchingJobs(with: "full%20stack")
        viewModel.getSearchingJobs(with: "devops")
        viewModel.getSearchingJobs(with: "marketing%20manager")
        
    
        
    }
    
    private func setupViews(){
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self

     
        if #available(iOS 13.0, *) {
                        let navBarAppearance = UINavigationBarAppearance()
                        //navBarAppearance.configureWithOpaqueBackground()
                    
                        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow,
                             NSAttributedString.Key.font: UIFont(name: "Zapfino", size: 30.0)!]
                        navBarAppearance.backgroundColor = .black
                        navigationController?.navigationBar.barStyle = .black
                        navigationController?.navigationBar.standardAppearance = navBarAppearance
                        navigationController?.navigationBar.compactAppearance = navBarAppearance
                        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

                        navigationController?.navigationBar.prefersLargeTitles = false
                        navigationItem.title = "Jobs Opportunities"

        }
        
    }
    

}


//MARK: - Fill in Data
extension CompaniesVC: CompaniesOutPutProtocol {
    func saveiOsJobsList(jobValues: [JobInfo]) {
        self.iosList = jobValues
        self.tableView.reloadData()
    }
    
    func saveSwiftJobsList(jobValues: [JobInfo]) {
        self.swiftJobsList = jobValues
        self.tableView.reloadData()
    }
    
    func saveFrontList(jobValues: [JobInfo]) {
        self.frontList = jobValues
        self.tableView.reloadData()
    }
    
    func saveBackendList(jobValues: [JobInfo]) {
        self.backendList = jobValues
        self.tableView.reloadData()
    }
    
    func saveDevopsList(jobValues: [JobInfo]) {
        self.devopsList = jobValues
        self.tableView.reloadData()
    }
    func saveMarketingManagerList(jobValues: [JobInfo]) {
        self.marketingList = jobValues
        self.tableView.reloadData()
    }
    
    func savefullStackList(jobValues: [JobInfo]) {
        self.fullStackList = jobValues
        self.tableView.reloadData()
    }
 
}


//MARK: -  Set Constraints
extension CompaniesVC {
    
    private func setConstraints(){
       
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }
}

//MARK: - Delegate, DataSource
extension CompaniesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return jobTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: CompaniesTableViewCell.identifier, for: indexPath) as! CompaniesTableViewCell
       
        tableCell.cellDelegateForNavigate = self
        
        switch indexPath.section {
            
            case Sections.Swift.rawValue:
                tableCell.configure(with: swiftJobsList)
            
            case Sections.iOS.rawValue:
                tableCell.configure(with: iosList)
            
            case Sections.FrontEnd.rawValue:
                tableCell.configure(with:  frontList)
            
            case Sections.FullStack.rawValue:
                tableCell.configure(with:  fullStackList)
            
            case Sections.BackEnd.rawValue:
                tableCell.configure(with:  backendList)
            
            case Sections.DevOps.rawValue:
                tableCell.configure(with:  devopsList)
                
            case Sections.MarketingManager.rawValue:
                tableCell.configure(with:  marketingList)
                
            default:
                return UITableViewCell()
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
    // Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {

            case Sections.Swift.rawValue:
            return "Swift || \(swiftJobsList.count)"

            
            case Sections.iOS.rawValue:
            return "iOS || \(iosList.count)"
            
            case Sections.FrontEnd.rawValue:
            return "Front End || \(frontList.count)"
            
            case Sections.FullStack.rawValue:
            return "Full Stack || \(fullStackList.count)"
            
            case Sections.BackEnd.rawValue:
            return "Back End || \(backendList.count)"
            
            case Sections.DevOps.rawValue:
            return "Devops  || \(devopsList.count)"
                
            case Sections.MarketingManager.rawValue:
            return "Marketing Manager || \(marketingList.count)"
            
            
            default:
                return "-"
        }
        
    }
    
    
    // Header Title Settings
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        guard let header  = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 2,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
    }
    
}


//MARK: -  Navigate
extension CompaniesVC: TableCellProcotol {
    func tableCollectionViewCellDidTapCell(navigateJobInfo: JobInfo) {
       let detailsVC = DetailsVC()
        detailsVC.configure(with: navigateJobInfo)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
