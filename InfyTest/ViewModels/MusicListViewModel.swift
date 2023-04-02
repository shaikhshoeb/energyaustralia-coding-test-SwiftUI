//
//  MusicListViewModel.swift
//  InfyTest
//
//  Created by Shoeb on 01/04/23.
//

import Foundation
import SwiftUI

protocol TipstersViewModelProtocol {
    func getFestivals(_ completion: @escaping (Bool) -> Void)
}

final class MusicListViewModel: ObservableObject {
    // MARK: Output
    @Published private(set) var festivals: [Festival] = []
    private let apiService: APIService
    
    init(apiService:APIService) {
        self.apiService = apiService
    }
        
    func getFestivals(_ completion: @escaping (Bool) -> Void)  {
      
        self.apiService.getFestivals { data in
            DispatchQueue.main.async {
                self.festivals = data
                if data.isEmpty == false{
                   completion(true)
                }
                else{
                    completion(false)
                }
            }
            
        }
       
    }
}

