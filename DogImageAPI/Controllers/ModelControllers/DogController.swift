//
//  DogsController.swift
//  DogImageAPI
//
//  Created by anthony byrd on 5/5/21.
//

import UIKit

class DogController {
    
    static let baseURL = URL(string: "https://dog.ceo/api/breed/")
    static let randomImageEndpoint = "/images/random"
    
    static func fetchRandomDogImage(with searchTerm: String, completion: @escaping (Result<Dog, DogError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let searchTermURL = baseURL.appendingPathComponent(searchTerm)
        let finalURL = searchTermURL.appendingPathComponent(randomImageEndpoint)
        print(finalURL)
        
        //Data Task
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let decoder = JSONDecoder()
                let dog = try decoder.decode(Dog.self, from: data)
                completion(.success(dog))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImageForDog(with dog: Dog, completion: @escaping (Result<UIImage, DogError>) -> Void) {
        guard let url = URL(string: dog.message) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(image))
        }.resume()
    }
}//End of class
