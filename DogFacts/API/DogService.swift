//
//  DogService.swift
//  DogFacts
//
//  Created by Gustas on 2021-09-23.
//

import Foundation

struct DogService {
    static let shared = DogService()
    
    func getRandomFact(completion: @escaping (Fact) -> Void) {
        let endpoint = "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=1"
        
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Fact].self, from: data) {
                    DispatchQueue.main.async {
                        if let singleFact = decodedResponse.first {
                            UserDefaults.standard.set(singleFact.fact, forKey: "myDogFact")
                            completion(singleFact)
                        }
                    }
                    return
                }
            }
            print("DEBUG: \(error?.localizedDescription ?? "Error")")
        }.resume()
    }
}
