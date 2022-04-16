//
//  DownloadedListVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 16.04.2022.
//

import UIKit

class DownloadedListVC: UIViewController {

    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(DownloadTableCell.self, forCellReuseIdentifier: DownloadTableCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        title =  "Downloaded List"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.fillSuperview()
    }
}

extension DownloadedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableCell.identifier, for: indexPath) as! DownloadTableCell
        
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
