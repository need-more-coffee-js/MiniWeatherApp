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
                UserView(user: user)
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
    
    @State private var showMap = false
    @State private var showDetails = false
    
    var backgroundGradient: LinearGradient {
        switch user.gender {
                case "male":
                    return LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                case "female":
                    return LinearGradient(
                        gradient: Gradient(colors: [Color.pink, Color.orange]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                default:
                    return LinearGradient(
                        gradient: Gradient(colors: [Color.gray, Color.black]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Аватарка с анимацией
                    AsyncImage(url: URL(string: user.picture.large)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .scaleEffect(showDetails ? 1 : 0.5)
                            .opacity(showDetails ? 1 : 0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showDetails)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // Имя и фамилия с анимацией
                    Text("\(user.name.first) \(user.name.last)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(showDetails ? 1 : 0)
                        .offset(y: showDetails ? 0 : 20)
                        .animation(.easeInOut(duration: 0.5).delay(0.2), value: showDetails)
                    
                    // Информация о пользователе с анимацией
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
                    .opacity(showDetails ? 1 : 0)
                    .offset(y: showDetails ? 0 : 20)
                    .animation(.easeInOut(duration: 0.5).delay(0.4), value: showDetails)
                    
                    // Кнопка для карты с анимацией
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
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    .opacity(showDetails ? 1 : 0)
                    .offset(y: showDetails ? 0 : 20)
                    .animation(.easeInOut(duration: 0.5).delay(0.6), value: showDetails)
                }
                .padding()
            }
        }
        .onAppear {
            withAnimation {
                showDetails = true
            }
        }
        .sheet(isPresented: $showMap) {
            MapView(coordinates: user.location.coordinates)
        }
    }
}
// Компонент для строки информации
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
