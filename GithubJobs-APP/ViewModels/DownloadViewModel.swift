//
//  DownloadViewModel.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation


class DownloadViewModel {
    
    
    // GET Search Datas
    
    
    // CREATE
    func createBookMarkWithIndexPath(bookmarkItem: JobInfo ){
        DataPersistentManager.shared.createBookmarkJob(entityModel: bookmarkItem) { result in
            
            switch result {
            case .success():
                print("Download Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // READ
    
    // DELETE
}
