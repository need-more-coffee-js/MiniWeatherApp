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
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            } else if let user = viewModel.user {
                UserView(user: user, viewModel: viewModel) // Передаем viewModel в UserView
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                Text("No user data")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

struct UserView: View {
    let user: User
    @ObservedObject var viewModel: UserViewModel // Добавляем viewModel как ObservedObject
    @State private var showMap = false
    
    var body: some View {
        ZStack {
            // Фон
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Основной контент
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: user.picture.large)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                
                Text("\(user.name.first) \(user.name.last)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    InfoRow(icon: "person.fill", text: "Gender: \(user.gender.capitalized)")
                    InfoRow(icon: "globe", text: "Nationality: \(user.nat)")
                    InfoRow(icon: "calendar", text: "Age: \(user.dob.age)")
                    InfoRow(icon: "envelope.fill", text: "Email: \(user.email)")
                    InfoRow(icon: "phone.fill", text: "Phone: \(user.phone)")
                    InfoRow(icon: "cellphone", text: "Cell: \(user.cell)")
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Кнопка для показа карты
                Button(action: {
                    showMap.toggle()
                }) {
                    HStack {
                        Image(systemName: "map.fill")
                        Text("Show on Map")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Кнопка для загрузки другого пользователя
                Button(action: {
                    viewModel.fetchUser() // Загружаем нового пользователя
                }) {
                    Text("Load Another User")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(viewModel.isLoading) // Отключаем кнопку во время загрузки
            }
            .padding()
        }
        .sheet(isPresented: $showMap) {
            MapView(coordinates: user.location.coordinates)
        }
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30)
            Text(text)
                .foregroundColor(.white)
                .font(.subheadline)
            Spacer()
        }
    }
}
