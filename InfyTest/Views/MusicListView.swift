//
//  MusicListView.swift
//  InfyTest
//
//  Created by Shoeb on 01/04/23.
//

import SwiftUI
import Foundation

struct MusicListView: View {
    @ObservedObject var musicViewModel: MusicListViewModel
    @State private var showAlert = false
    var body: some View {
        
        NavigationView {
            List{
                
                ForEach(Array(musicViewModel.festivals.enumerated()), id: \.offset) { index, element in
                    Section(header: Text(element.name)) {
                        ForEach(Array(element.bands.enumerated()), id: \.offset) { index, brand in
                            MusicRow(brand: brand)
                        }
                        
                    }
                }
               
            }
            .listStyle(.grouped)
            .onAppear {
             
                self.musicViewModel.getFestivals { isDataConsist in
                    if isDataConsist == true{
                        // Data
                        //showAlert.toggle()
                        showAlert = false
                    }
                    else{
                        //No Data
                        showAlert = false
                        showAlert.toggle()
                    }
                }
              
                
            }
            .navigationTitle("Music Festivals")
            .alert("Oops", isPresented:$showAlert){
           
            } message:{
                Text("Error in loading a Music Festival. Please Try again pressing Reload at the bottom")
            }
        }
        

        VStack(alignment: .leading) {
                   Button("Reload") {
                       self.musicViewModel.getFestivals { isDataConsist in
                           if isDataConsist == true{
                               // Data
                               //showAlert.toggle()
                               showAlert = false
                           }
                           else{
                               //No Data
                               showAlert = false
                               showAlert.toggle()
                           }
                       }

                    }
               }
    }
    
     
}

struct MusicRow: View {
    @State var brand: Brand
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
          Text(brand.name)
                .font(.system(size: 16, weight: .medium))
          Text(brand.recordLabel)
                .font(.system(size: 15, weight: .light))
        }
        
    }
}

