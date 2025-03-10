//
//  MapView.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

//import SwiftUI
//import MapKit
//
//struct MapView: UIViewRepresentable {
//    let coordinates: Coordinates
//    
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView(frame: .zero)
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        let coordinate = CLLocationCoordinate2D(
//            latitude: Double(coordinates.latitude) ?? 0,
//            longitude: Double(coordinates.longitude) ?? 0
//        )
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        uiView.addAnnotation(annotation)
//        
//        let region = MKCoordinateRegion(
//            center: coordinate,
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//        uiView.setRegion(region, animated: true)
//    }
//}
