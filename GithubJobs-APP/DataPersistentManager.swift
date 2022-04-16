//
//  DataPersistentManager.swift
//  GithubJobs-APP
//
//  Created by ugur-pc on 13.04.2022.
//

import Foundation
import UIKit
import CoreData



class DataPersistentManager {
        
    static let shared = DataPersistentManager()
    
    enum DataBaseError {
        case failedSavedData
        case fetchDBError
        case deletedError
    }
    
    
    // Get Context
    func getContext() -> NSManagedObjectContext {
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             
              return  NSManagedObjectContext()
          }
          
          let context = appDelegate.persistentContainer.viewContext
          
          return context
      }
    
    // CREATE
    func createBookmarkJob(entityModel: JobInfo,
                           completion: @escaping (Result<Void>) -> Void) {

        let bookmarkModel = GithubEntity(context: getContext())
        
        bookmarkModel.id = Int32(entityModel.id ?? 0)
        bookmarkModel.title = entityModel.title
        bookmarkModel.companyLogo = entityModel.companyLogo
        bookmarkModel.companyName = entityModel.companyName
       // bookmarkModel.salary = entityModel.salary?.rawValue
        bookmarkModel.url = entityModel.url
       // bookmarkModel.jobType = entityModel.jobType?.rawValue
        
        
        do {
                  print("entityModel",entityModel)
                  try getContext().save()
                  completion(.success(()))
                
              } catch {
                  completion(.failure(DataBaseError.failedSavedData as! Error))
              }
        
    }
    
    
    // GET ALL
    func getDatasFromDB(completion: @escaping (Result<[GithubEntity]>) -> Void) {
        
        let request: NSFetchRequest<GithubEntity>
        request = GithubEntity.fetchRequest()
        
        do {
            let jobDBDatas = try self.getContext().fetch(request)
            completion(.success(jobDBDatas))
        } catch {
            completion(.failure(DataBaseError.fetchDBError as! Error))
        }
        
    }
    
    
}
