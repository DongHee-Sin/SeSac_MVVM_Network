//
//  APIService.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation
import Alamofire


final class APIService {
    
    static let share = APIService()
    
    private init() {}
    
    
    func request<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else { return }
                
                completion(.failure(error))
            }
        }
    }
}
