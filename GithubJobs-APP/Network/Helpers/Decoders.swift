//
//  Decoders.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation


public enum Decoders {
       
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          decoder.dateDecodingStrategy = .formatted(dateFormatter)
          return decoder
    }()
}
