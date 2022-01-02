//
//  ViewController.swift
//  concurrency_swift
//
//  Created by Jemi on 02/01/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let todo1 = try await loadTODO(1)
            print(todo1.title!)
            let todo2 = try await loadTODO(2)
            print(todo2.title!)
            let todo3 = try await loadTODO(3)
            print(todo3.title!)
        }
        
    }
    
    func loadTODO(_ id:Int) async throws -> Todo {
        let data = try await NetworkHelper.getData(path: "todos/\(id)")
        return try JSONDecoder().decode(Todo.self, from: data)
    }

}

enum AppError : Error {
    case noData
}

struct Todo : Decodable {
    var title:String?
}



/*
 override func viewDidLoad() {
     super.viewDidLoad()
     sum(1, 2) { res in
         print(res)
     }
 }
 
 func sum(_ a:Int, _ b:Int, completion: @escaping (Int) -> Void) {
     DispatchQueue.global().async {
         completion(a + b)
     }
     print("HI");
 }
 
 
 ===========
 
 override func viewDidLoad() {
     super.viewDidLoad()
     loadData { todos, error in
         print(todos)
         print(error)
     }
 }
 
 func loadData(complition: @escaping ([Todo]?, Error?) -> Void) {
     let baseURL = "https://jsonplaceholder.typicode.com/todos/"
     let url = URL(string: baseURL)!
     URLSession.shared.dataTask(with: url) {
         data, response, error in
         do {
             let todos = try! JSONDecoder().decode([Todo].self, from: data!)
             complition(todos, nil)
         } catch {
             complition(nil, error)
         }
     }.resume()
 }
 
 ===============
 
 
 override func viewDidLoad() {
     super.viewDidLoad()
     loadData { result in
         switch result {
         case .success(let todos):
             print(todos)
         case .failure(let error):
             print(error)
         }
     }
 }
 
 func loadData(complition: @escaping (Result<[Todo], Error>) -> Void) {
     let baseURL = "https://jsonplaceholder.typicode.com/todos/"
     let url = URL(string: baseURL)!
     URLSession.shared.dataTask(with: url) {
         data, response, error in
         do {
             let todos = try JSONDecoder().decode([Todo].self, from: data!)
             complition(.success(todos))
         } catch {
             complition(.failure(error))
         }
     }.resume()
 }
 
 =============
 
 override func viewDidLoad() {
     super.viewDidLoad()
     DispatchQueue.global().async {
         do {
             let data = try self.downloadImage(url: URL(string: "https://www.google.com")!)
             let image = try self.decodeImage(from: data)
             print(image)
         } catch {
             print(error)
         }
     }
 }

 func downloadImage(url:URL) throws -> Data {
     let semaphore = DispatchSemaphore(value: 0)
     var data:Data?
     DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
         data = Data()
         semaphore.signal()
     }
     _ = semaphore.wait(timeout: .distantFuture)
     if let data = data {
         return data
     }
     throw AppError.noData
 }
 
 func decodeImage(from data:Data) throws -> UIImage {
     let semaphore = DispatchSemaphore(value: 0)
     var image:UIImage?
     DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
         image = UIImage()
         semaphore.signal()
     }
     _ = semaphore.wait(timeout: .distantFuture)
     if let image = image {
         return image
     }
     throw AppError.noData
 }
 
 func proccess(image:UIImage) throws -> UIImage {
     return UIImage()
 }

 func save(image:UIImage) throws -> URL {
     return URL(string: "")!
 }
 
 */
