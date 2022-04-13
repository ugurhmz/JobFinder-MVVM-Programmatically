//
//  Result.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
