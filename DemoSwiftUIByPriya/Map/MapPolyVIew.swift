//
//  MapPolyVIew.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 06/08/24.
//

import SwiftUI
import MapKit

//TODO: - set collected city name to navigate destination
struct MapPolyVIew: View {
    @StateObject private var viewModel = MapViewModel()
    @State var selectCity: String = ""
    
    var body: some View {
        VStack {
            MapView(region: $viewModel.region, selectedAnnotation: $viewModel.selectedAnnotation)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                viewModel.selectRandomCity()
            }) {
                Text("Select Random City")
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    MapPolyVIew()
}

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var selectedAnnotation: MKPointAnnotation?
    
    init() {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.0225, longitude: 72.5714),
                                         span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.selectRandomCity()
    }
    
    func selectRandomCity() {
        let cities = [
            ("San Francisco", 37.7749, -122.4194),
            ("New York", 40.7128, -74.0060),
            ("Los Angeles", 34.0522, -118.2437),
            ("Chicago", 41.8781, -87.6298),
            ("Houston", 29.7604, -95.3698)
        ]
        
        if let randomCity = cities.randomElement() {
            let annotation = MKPointAnnotation()
            annotation.title = randomCity.0
            annotation.coordinate = CLLocationCoordinate2D(latitude: randomCity.1, longitude: randomCity.2)
            self.selectedAnnotation = annotation
            self.region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedAnnotation: MKPointAnnotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        
        if let annotation = selectedAnnotation {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.canShowCallout = true
            return annotationView
        }
    }
}
