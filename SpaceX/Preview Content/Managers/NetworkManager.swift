//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import Foundation
import UIKit

final class NetworkManager {
    
    // singleton
    static let shared = NetworkManager()
    // set up cache
    private let cache = NSCache<NSString,UIImage>()
    
    static let baseURL = "https://api.spacexdata.com/v4/"
    
    private let rocketURL = baseURL + "rockets"
    
    private let upcomingLaunchesURL = "https://api.spacexdata.com/v5/launches/upcoming"
    
    private let membershipAgreementURL = "https://firebasestorage.googleapis.com/v0/b/spacex-690e8.appspot.com/o/MembershipAgreement.txt?alt=media&token=c1983868-6100-45cd-9c6e-308492bc84b8"
    private let privacyPolicyURL = "https://firebasestorage.googleapis.com/v0/b/spacex-690e8.appspot.com/o/PrivacyConditions.txt?alt=media&token=28994437-6ef3-40e6-a4b7-25d48a3863b3"
    
    private init() {}
    
    // function completion handler that returns a result either a success array of appetizerss or failture of APError
    func getRockets(completed: @escaping (Result<[Rocket], APError>) -> Void) {
        
        // check for good URL
        guard let url = URL(string: rocketURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        // create network call to make request with good url it'll return to data, response, and error
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            // check for error i.e. lost wifi
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // cast the response as a HTTPURLResponse and check status code make sure it's 200
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            // check for data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // decode data into the model
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Rocket].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        // fire off the network call
        task.resume()
        
    }
    
    // network call to download image. pass in url string and returns either a UIImage or nil
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        // set up cacheKey from URL
        let cacheKey = NSString(string: urlString)
        
        // check cache for object before we download.
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // check if url is good
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        // if the url is good then do network call
        // because we're using placeholder we don't care about errors
        // if we can make an image set that image into the cache
        // set completion handler to pass image up
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    
    func getUpcomingLaunches(completed: @escaping (Result<[Launch], APError>) -> Void) {
        guard let url = URL(string: upcomingLaunchesURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Launch].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("Error decoding launch data: \(error.localizedDescription)")
                completed(.failure(.invalidData))
            }
        }
        task.resume()

    }
}
