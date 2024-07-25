//
//  SportService.swift
//  bet-rave
//
//  Created by Eric Chandonnet on 2024-07-25.
//

import Foundation

enum SportServiceError: Error {
    case urlError
    case requestError
    case jsonDecodingError
    case fetchingDataError
    case invalidStatusCode
}

class SportService {
    
/// https://api-sports.io/documentation/mma/v1#tag/Fighters
    
    func getFights() async throws -> [Fight] {
        
        var urlComponents = URLComponents(string: "https://v1.mma.api-sports.io/fights")!
        urlComponents.queryItems = [URLQueryItem(name: "date", value: "2024-07-27"),
                                    URLQueryItem(name: "timezone", value: "America/Toronto")]
        
        guard let url = urlComponents.url else { throw SportServiceError.urlError }
        
        var request = URLRequest(url: url)
        request.addValue(ProcessInfo.processInfo.environment["API_KEY"]!, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v1.mma.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw SportServiceError.invalidStatusCode
            }
            
            guard let decodedFightResponse = try? JSONDecoder().decode(FightResponse.self, from: data) else {
                throw SportServiceError.jsonDecodingError
            }
            
            return decodedFightResponse.response
        }
        catch {
            print(error.localizedDescription)
            throw(error)
        }
    }
    
    
}
