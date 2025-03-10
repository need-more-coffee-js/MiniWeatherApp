//
//  UserView.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = viewModel.user {
                UserView(user: user)
                UserDetailsView(user: user)
                    .frame(height: 200)
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                Text("No user data")
            }
            
            Button(action: {
                viewModel.fetchUser()
            }) {
                Text("Fetch User")
            }
        }
        .padding()
    }
}

struct UserView: View {
    let user: User
    
    @State private var isShowingDetails = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.picture.large)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isShowingDetails = true
                }
            }
            
            if isShowingDetails {
                Text("\(user.name.first) \(user.name.last)")
                    .font(.title)
                    .transition(.opacity)
                
                Text("Gender: \(user.gender)")
                    .font(.subheadline)
                    .transition(.opacity)
                
                Text("Nationality: \(user.nat)")
                    .font(.subheadline)
                    .transition(.opacity)
                
                Text("Age: \(user.dob.age)")
                    .font(.subheadline)
                    .transition(.opacity)
                
                Text("Email: \(user.email)")
                    .font(.subheadline)
                    .transition(.opacity)
                
                Text("Phone: \(user.phone)")
                    .font(.subheadline)
                    .transition(.opacity)
                
                Text("Cell: \(user.cell)")
                    .font(.subheadline)
                    .transition(.opacity)
            }
        }
    }
}
