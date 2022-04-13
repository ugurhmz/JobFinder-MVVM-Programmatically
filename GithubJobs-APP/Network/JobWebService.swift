//
//  JobWebService.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation
import Alamofire


enum EndPoints: String {
    case baseURL = "https://remotive.com/api/"
    case jobsType = "remote-jobs"
}

public  enum ApiError: Swift.Error {
    case serializationError(internal: Swift.Error)
    case networkError(internal: Swift.Error)
}

protocol JobWebServiceProtocol {
    func searchJobsWithQuery(with query: String,
                             completion: @escaping (Result<[JobInfo]>) -> Void)
}



public class JobWebService: JobWebServiceProtocol {
    
    static let shared = JobWebService()
    
    
    // SEARCH
    func searchJobsWithQuery(with query: String,
                             completion: @escaping (Result<[JobInfo]>) -> Void) {
        
        let urlString = EndPoints.baseURL.rawValue +
                        EndPoints.jobsType.rawValue +
                        "?search=\(query)"
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                
                do {
                    let response = try decoder.decode(JobsData.self, from: data)
                    completion(.success(response.jobs ?? []))
                } catch {
                    completion(.failure(ApiError.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(ApiError.networkError(internal: error)))
            }
        }
    }
    
    
}
