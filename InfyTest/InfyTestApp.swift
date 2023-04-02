//
//  InfyTestApp.swift
//  InfyTest
//
//  Created by Shoeb on 01/04/23.
//

import SwiftUI

@main
struct InfyTestApp: App {
    var dataService:APIService
    var musicViewModel:MusicListViewModel
    
    init() {
        self.dataService = APIService()
        self.musicViewModel = MusicListViewModel(apiService: dataService)
        
    }
    
    var body: some Scene {
        WindowGroup {
            MusicListView(musicViewModel: musicViewModel)
        }
    }
}
