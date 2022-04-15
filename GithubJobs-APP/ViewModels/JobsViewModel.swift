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
    var companyOutPut: CompaniesOutPutProtocol? { get }
}


final class JobsViewModel: JobsViewModelProtocol {
    var searchOutPut: JobSearchOutputProtocol?
    var jobWebService : JobWebService
    var  companyOutPut: CompaniesOutPutProtocol?
    
    init() {
        jobWebService = JobWebService()
    }
    
    func setCompanyDelagte(output: CompaniesOutPutProtocol ) {
        companyOutPut = output
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
                
                if query == "swift" {
                    self.companyOutPut?.saveSwiftJobsList(jobValues: response)
                }
                
                if query == "ios%20developer" {
                    self.companyOutPut?.saveiOsJobsList(jobValues: response)
                }
                
                if query == "front%20end" {
                    self.companyOutPut?.saveFrontList(jobValues: response)
                }
               
                if query == "back%20end" {
                    self.companyOutPut?.saveBackendList(jobValues: response)
                }
               
                if query == "marketing%20manager" {
                    self.companyOutPut?.saveMarketingManagerList(jobValues: response)
                }
                
                if query == "full%20stack" {
                    self.companyOutPut?.savefullStackList(jobValues: response)
                }
               
                if query == "devops" {
                    self.companyOutPut?.saveDevopsList(jobValues: response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
