//
//  MainTabBarVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 11.04.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        // tabbar Navigation
        let homeTab = UINavigationController(rootViewController: MainCollectionVC())
        let sponsoringCompanies =  UINavigationController(rootViewController: CompaniesVC())
        let downloadedJob = UINavigationController(rootViewController: DownloadedListVC())
        
        
        // tabBar icons
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        sponsoringCompanies.tabBarItem.image = UIImage(systemName: "person.2.crop.square.stack")
        downloadedJob.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        
        homeTab.title = "Home"
        sponsoringCompanies.title = "Companies"
        downloadedJob.title = "Download"
        tabBar.tintColor = .white
        tabBar.barTintColor = .purple
        setViewControllers([homeTab, sponsoringCompanies, downloadedJob], animated: true)
        
    }
    

  

}
