//
//  SportService.swift
//  bet-rave
//
//  Created by Eric Chandonnet on 2024-07-25.
//

import Foundation

enum BetsServiceError: Error {
    case urlError
    case requestError
    case jsonDecodingError
    case fetchingDataError
    case invalidStatusCode
}

class SportService {
    
    var apiKey: String {
        ProcessInfo.processInfo.environment["API_KEY"]!
    }
    
    func getMmaOdds() {
        var request = URLRequest(url: URL(string: "https://v1.mma.api-sports.io/fights")!,timeoutInterval: Double.infinity)
        request.addValue("XxXxXxXxXxXxXxXxXxXxXxXx", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.mma.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = "GET"

    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
        }
        print(String(data: data, encoding: .utf8)!)
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
    
}
