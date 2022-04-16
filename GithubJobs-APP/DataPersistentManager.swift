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
        bookmarkModel.salary = entityModel.salary 
        bookmarkModel.url = entityModel.url
        bookmarkModel.jobType = entityModel.jobType
        bookmarkModel.candidateRequiredLocation = entityModel.candidateRequiredLocation
        
        print("entityModel.salary", entityModel.salary )
        
        
        do {
                  
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
    
    //Delete
       func deleteDataFromDB(entityModel: GithubEntity,
                             completion: @escaping (Result<Void>) -> Void) {
           getContext().delete(entityModel)
           do {
               try getContext().save()
               completion(.success(()))
               
           } catch {
               completion(.failure(DataBaseError.deletedError as! Error))
           }
           
       }
    
    
    // Delete All
       func deleteAllFromDB(){
           let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "GithubEntity")
           let deleteAllReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
           
           do {
               try  getContext().execute(deleteAllReq)
               print()
           } catch {
               print("err")
           }
       }
    
}
