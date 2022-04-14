//
//  JobsViewModel.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation


protocol JobsViewModelProtocol {
    func getSearchingJobs(with query: String)
    func setSearchDelegate(output: JobSearchOutputProtocol)
    var searchOutPut: JobSearchOutputProtocol? { get }
}


final class JobsViewModel: JobsViewModelProtocol {
    var searchOutPut: JobSearchOutputProtocol?
    var jobWebService : JobWebService
  
    
    init() {
        jobWebService = JobWebService()
    }
    
    func setSearchDelegate(output: JobSearchOutputProtocol) {
        searchOutPut = output
    }
    
    func getSearchingJobs(with query: String) {
        jobWebService.searchJobsWithQuery(with: query) { [weak self] result in
            
            guard let self = self else {return }
            switch result {
            case .success(let response):
                self.searchOutPut?.saveSearchJobs(jobInfoList: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
