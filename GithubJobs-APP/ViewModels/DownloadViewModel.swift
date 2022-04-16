//
//  DownloadViewModel.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation


protocol DownloadViewModelProtocol {
    var downloadOutPut: DownloadOutPutProtocol? { get }
    func setDownloadDelegate(output: DownloadOutPutProtocol)
}


class DownloadViewModel: DownloadViewModelProtocol {
    
    var downloadOutPut: DownloadOutPutProtocol?
    
    func setDownloadDelegate(output: DownloadOutPutProtocol) {
        self.downloadOutPut = output
    }
    
    
    
    // CREATE
    func createBookMarkWithIndexPath(bookmarkItem: JobInfo ){
        DataPersistentManager.shared.createBookmarkJob(entityModel: bookmarkItem) { result in
            print("bookmarkItem",bookmarkItem)
            switch result {
            case .success():
                print("Download Success",result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // READ
    func getlLocalStorageDownloadDatas(){
        DataPersistentManager.shared.getDatasFromDB { [weak self] result in
            switch result {
            case .success(let jobInfoDBDatas):
                self?.downloadOutPut?.saveData(downloadJobInfos: jobInfoDBDatas)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // DELETE
}
