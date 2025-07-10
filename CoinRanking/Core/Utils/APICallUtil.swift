//
//  APICallUtil.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import Foundation

class APICallUtil{
    static let shared = APICallUtil()
    
    func fetch<T: Decodable>(returnType: T.Type, url: URL) async -> Result<T, APICallError>{
        do{
            var request = URLRequest(url: url)
            print("DEBUG: URL Request: \(url)")
            
            let bearerToken = Constants.accessToken
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                return .failure(APICallError.custom("API error \(code)"))

            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch let error as URLError
        {
            print("DEBUG: urlSession error \(error.localizedDescription)")
            print("DEBUG: -------------")
            return .failure(APICallError.custom("API Failed"))
        }
        catch {
            print("DEBUG: API error; \(error)")
            return .failure(APICallError.custom(error.localizedDescription))
        }
    }
    
    func post<T: Encodable, U: Decodable>(returnType: U.Type, url: URL, postData: T) async -> Result<U, APICallError> {
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonData = try JSONEncoder().encode(postData)
            request.httpBody = jsonData
            
            // Add bearer token to the Authorization header
            let bearerToken = Constants.accessToken
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            let (responseData, response) = try await URLSession.shared.data(for: request)
           
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                return .failure(APICallError.custom("API error \(code)"))
            }
            
            let decodedData = try JSONDecoder().decode(U.self, from: responseData)
            return .success(decodedData)
        } catch let error as URLError {
            print("DEBUG: API error; \(error)")
            return .failure(APICallError.urlSession(error))
        } catch let decodingError as DecodingError {
            print("DEBUG: decodingError error; \(decodingError)")
            return .failure(APICallError.decoding(decodingError))
        } catch {
            print("DEBUG: API error; \(error)")
            return .failure(APICallError.custom(error.localizedDescription))
        }
    }
}
