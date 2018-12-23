//
//  RequestHandler.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 7.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
/*
import Foundation
import UIKit

import Alamofire
import AlamofireObjectMapper

func executeApi<T: Mappable>(_ urlString: String, method: HTTPMethod, parameters: [String: Any] = [:], completion:@escaping (T) -> Void) {

    let token: String = ""

    print("***************************************************")
    print("Reconfigure token structure for get or post request")
    print("Architecture/RequestHandler")
    print("***************************************************")

    let headers: HTTPHeaders = [
        "Authorization": "bearer " + token,
        "Content-Type": "application/json"
    ]

    let encode = ( (method == HTTPMethod.get) ? URLEncoding.default : JSONEncoding.default ) as ParameterEncoding
    let manager = Alamofire.SessionManager.default

        manager.requestWithoutCache(urlString, method: method, parameters: parameters, encoding: encode, headers: headers).validate().responseObject { (response: DataResponse<T>) in
            if response.response?.statusCode == 200 {
                guard let result = response.result.value else {
                    print("Someting bad happened in value cast")
                    return
                }

                completion(result)
            } else if(response.response?.statusCode == 401) {
                //UserDefaults.standard.setIsLoggedIn(value: false)
                print("Auth Error.")
            } else {
                print("I don't know what does this status code do. However, Here is the status code -> \(response.response?.statusCode ?? -10)")

                // This line allows you to terminate your application if something severe happens.
                let sending = (response.result.error != nil) ? response.error?.localizedDescription : "Someting bad happened in status code"
                NotificationCenter.default.post(name: Notification.Name("finishedLoader"), object: sending)
            }
    }
}

extension Alamofire.SessionManager {
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest {
            do {
                var urlRequest = try URLRequest(url: url, method: method, headers: headers)
                urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
                let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
                return request(encodedURLRequest)
            } catch {
                print(error)
                return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
            }
    }
}
*/
