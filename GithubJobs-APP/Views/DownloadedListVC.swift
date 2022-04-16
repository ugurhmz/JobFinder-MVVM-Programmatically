//
//  DownloadedListVC.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 16.04.2022.
//

import UIKit

protocol DownloadOutPutProtocol {
    func saveData(downloadJobInfos: [GithubEntity])
}

class DownloadedListVC: UIViewController {
    
    private var downloadedList = [GithubEntity]()
    lazy var downloadViewModel = DownloadViewModel()
    
    
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(DownloadTableCell.self, forCellReuseIdentifier: DownloadTableCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadViewModel.setDownloadDelegate(output: self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadViewModel.getlLocalStorageDownloadDatas()
        self.tableView.reloadData()
    }
    
    
}


//MARK: -
extension DownloadedListVC: DownloadOutPutProtocol {
    
    func saveData(downloadJobInfos: [GithubEntity]) {
        print("downloaded", downloadJobInfos)
        self.downloadedList = downloadJobInfos
        self.tableView.reloadData()
    }
    
}


//MARK: -  Delegate, DataSource
extension DownloadedListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.downloadedList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableCell.identifier, for: indexPath) as! DownloadTableCell
        
        cell.backgroundColor = .white
        
        cell.companyNameLabel.text = self.downloadedList[indexPath.row].companyName
        
        //cell.configureWithEntity(jobInfo: downloadedList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}


