//
//  UserDetailsViewController.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

import UIKit
import SwiftUI

class UserDetailsViewController: UIViewController {
    var user: User?
    
    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let nationalityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: user)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        genderLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nationalityLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, genderLabel, nationalityLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configure(with user: User?) {
        guard let user = user else { return }
        nameLabel.text = "\(user.name.first) \(user.name.last)"
        genderLabel.text = "Gender: \(user.gender)"
        nationalityLabel.text = "Nationality: \(user.nat)"
    }
}

struct UserDetailsView: UIViewControllerRepresentable {
    var user: User?
    
    func makeUIViewController(context: Context) -> UserDetailsViewController {
        let vc = UserDetailsViewController()
        vc.user = user
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UserDetailsViewController, context: Context) {
        uiViewController.configure(with: user)
    }
}
