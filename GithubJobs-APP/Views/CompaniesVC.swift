//
//  CompaniesVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 11.04.2022.
//

import UIKit

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
    var searchBar: UISearchBar?
    
    
    let jobTitles: [String] = ["Swift","iOS", "Front End", "Full Stack", "Back End", "DevOps", "Marketing Manager"]
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CompaniesTableViewCell.self,
                           forCellReuseIdentifier: CompaniesTableViewCell.identifier)
        tableView.backgroundColor = .white
        return tableView
    }()
    
  
    
    @objc func searchingFunc(shouldShow: Bool){
         
           if shouldShow {
               let searchBar = UISearchBar()
               searchBar.delegate = self
               searchBar.sizeToFit()
               searchBar.showsCancelButton = true
               searchBar.becomeFirstResponder() // Icona tıklayınca, searchbar focus yapıyor.
               searchBar.tintColor = .systemYellow
               searchBar.searchTextField.backgroundColor = .white
               searchBar.searchTextField.textColor = .black
               
               navigationItem.rightBarButtonItem = nil
               navigationItem.titleView = searchBar
           } else {
               
               navigationItem.titleView = nil
               configureSearchBarButton()
              
           }
       }
       
       
       @objc func showSearchBar(){
           searchingFunc(shouldShow: true)
       }
       
      
    
    func configureSearchBarButton(){
           navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
           navigationItem.rightBarButtonItem?.tintColor = .white
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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
                        navigationItem.title = "Searching Jobs.."

        }
        
        self.configureSearchBarButton()
        
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
       
        
        switch indexPath.section {
            
            case Sections.Swift.rawValue:
                //tableCell.configure(with: swiftJobsList)
                tableCell.backgroundColor = .systemPink
            case Sections.iOS.rawValue:
                tableCell.backgroundColor = .orange
            case Sections.FrontEnd.rawValue:
                tableCell.backgroundColor = .cyan
            case Sections.FullStack.rawValue:
                tableCell.backgroundColor = .blue
            case Sections.BackEnd.rawValue:
                tableCell.backgroundColor = .red
            case Sections.DevOps.rawValue:
                tableCell.backgroundColor = .yellow
                
            case Sections.MarketingManager.rawValue:
                tableCell.backgroundColor = .green
                
            default:
                return UITableViewCell()
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    // Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return jobTitles[section]
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


//MARK: - SearchBar Delegate
extension CompaniesVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("click")
        self.searchingFunc(shouldShow: false)
        
    }
}
