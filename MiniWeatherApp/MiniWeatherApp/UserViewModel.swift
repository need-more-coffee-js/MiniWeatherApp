//
//  UserViewModel.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUser() {
        isLoading = true
        guard let url = URL(string: "https://randomuser.me/api/") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                    print("Error decoding JSON: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.user = response.results.first
            })
            .store(in: &cancellables)
    }
}
