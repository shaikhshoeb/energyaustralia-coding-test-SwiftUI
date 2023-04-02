//
//  MusicListView.swift
//  InfyTest
//
//  Created by Shoeb on 01/04/23.
//

import Foundation
import Combine

class APIService {
    let baseUrl = "https://eacp.energyaustralia.com.au/codingtest/api/v1/festivals"
    // Get from API/Database
    func getFestivals(_ completion: @escaping (_ data: [Festival]) -> Void) {
        
        guard let url = URL(string: baseUrl) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        // try to read out a string array
                        var festivals = [Festival]()
                      
                        for data in json {
                            var brandsList = [Brand]()
                            if let brands = data["bands"] as? [[String: Any]] {
                                for brand in brands {
                                    var nameStr = ""
                                    var recordLabel = ""
                                    if let tempValue = brand["name"] as? String {
                                        nameStr = tempValue
                                    }
                                    if let tempValue = brand["recordLabel"] as? String {
                                        recordLabel = tempValue
                                    }
                                    //print(nameStr)
                                    brandsList.append(Brand(name: nameStr, recordLabel: recordLabel))
                                }
                            }
                            if let name = data["name"] as? String {
                                let sortBrandArray = brandsList.sorted { $0.name < $1.name }
                                festivals.append(Festival(name: name, bands: sortBrandArray))
                            }
                        }
                        let sortFestivals = festivals.sorted { $0.name < $1.name }
                        completion(sortFestivals)
                    }else {
                     
                        //print("No Data Found")
                    }
                } catch let error as NSError {
                    print("\(error.localizedDescription)")
                    //print("Error in Loading Data")
              
                    completion([Festival].init())
                }
                
                
                
            }
        }

        dataTask.resume()
    }
    
}
