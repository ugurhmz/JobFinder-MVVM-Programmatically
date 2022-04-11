//
//  MainTabBarVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 11.04.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    var badgeCount = 0 
    // tabbar Navigation
    let homeTab = UINavigationController(rootViewController: MainCollectionVC())
    let sponsoringCompanies =  UINavigationController(rootViewController: CompaniesVC())
    var downloadedJob = UINavigationController(rootViewController: DownloadedListVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
    
        
        
        // tabBar icons
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        sponsoringCompanies.tabBarItem.image = UIImage(systemName: "person.2.crop.square.stack")
        downloadedJob.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        
        homeTab.title = "Home"
        sponsoringCompanies.title = "Companies"
        downloadedJob.title = "Download"
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        setViewControllers([homeTab, sponsoringCompanies, downloadedJob], animated: true)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(badgeINC),
                                               name: NSNotification.Name("refreshTableView"),
                                               object: nil)
    }
    
    @objc func badgeINC(_ notification: Notification){
        if let myNum = notification.object as? Int {
            downloadedJob.tabBarItem.badgeValue = "\(myNum)"
        }
    }

  

}

