//
//  MapViewController.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

import UIKit
import MapKit
import SwiftUI

class MapViewController: UIViewController {
    let coordinates: Coordinates
    var mapView: MKMapView!
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка MKMapView
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        // Добавляем аннотацию
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(coordinates.latitude) ?? 0,
            longitude: Double(coordinates.longitude) ?? 0
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        // Устанавливаем регион
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        mapView.setRegion(region, animated: true)
        
        // Добавляем кнопку закрытия
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 8
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 80),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}



struct MapView: UIViewRepresentable {
    let coordinates: Coordinates
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(coordinates.latitude) ?? 0,
            longitude: Double(coordinates.longitude) ?? 0
        )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        uiView.setRegion(region, animated: true)
    }
}
