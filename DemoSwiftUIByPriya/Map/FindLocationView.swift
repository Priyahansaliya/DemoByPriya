//
//  FindLocationView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 06/08/24.
//

import SwiftUI
import MapKit

struct FindLocationView: View {
    @StateObject private var viewModel = FindMapViewModel()
    @State private var cityName: String = ""

    var body: some View {
        VStack {
            FindMapView(region: $viewModel.region, selectedAnnotation: $viewModel.selectedAnnotation, overlay: $viewModel.overlay)
                .edgesIgnoringSafeArea(.all)

            HStack {
                TextField("Enter City Name", text: $cityName)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(Color.gray)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button(action: {
                    viewModel.navigateToCity(named: cityName)
                }) {
                    Text("Go")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

class FindMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var selectedAnnotation: MKPointAnnotation?
    @Published var overlay: MKCircle?

    init() {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                                         span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }

    func navigateToCity(named cityName: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { [weak self] placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first,
                  let location = placemark.location else { return }

            let coordinate = location.coordinate
            let annotation = MKPointAnnotation()
            annotation.subtitle = cityName
            annotation.title = cityName
            annotation.coordinate = coordinate
            DispatchQueue.main.async {
                self?.selectedAnnotation = annotation
                self?.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                self?.overlay = MKCircle(center: coordinate, radius: 3000) // 5km radius for highlighting
            }
        }
    }
}

struct FindMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedAnnotation: MKPointAnnotation?
    @Binding var overlay: MKCircle?
    
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
        
        if let overlay = overlay {
            uiView.removeOverlays(uiView.overlays)
            uiView.addOverlay(overlay)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: FindMapView
        
        init(_ parent: FindMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.canShowCallout = true
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let circleRenderer = MKCircleRenderer(circle: circleOverlay)
                circleRenderer.strokeColor = .red
                circleRenderer.lineWidth = 0.3
                circleRenderer.fillColor = .red.withAlphaComponent(0.3)
                circleRenderer.lineDashPattern = [3, 6] // Dash pattern
                return circleRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
