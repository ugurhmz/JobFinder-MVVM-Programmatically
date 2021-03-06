// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct JobsData: Codable {
    let jobCount: Int?
    let jobs: [JobInfo]?

    enum CodingKeys: String, CodingKey {
        case jobCount = "job-count"
        case jobs
    }
}

// MARK: - Job
struct JobInfo: Codable {
    let id: Int?
    let url: String?
    let title, companyName: String?
    let companyLogo: String?
    let category: String?
    let tags: [String]?
    let jobType: String?
    let publicationDate, candidateRequiredLocation: String?
    let salary: String?
    let jobDescription: String?
    let companyLogoURL: String?

    enum CodingKeys: String, CodingKey {
        case id, url, title
        case companyName     = "company_name"
        case companyLogo     = "company_logo"
        case category, tags
        case jobType    = "job_type"
        case publicationDate = "publication_date"
        case candidateRequiredLocation = "candidate_required_location"
        case salary
        case jobDescription = "description"
        case companyLogoURL = "company_logo_url"
    }
}


