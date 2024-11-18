//
//  MapView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 06/08/24.
import SwiftUI
import MapKit

struct Location: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MapViewWithAnnotations: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var selectedLocation: Location? = nil
    
    let locations = [
        Location(name: "Ahmedabad", coordinate: CLLocationCoordinate2D(latitude: 23.0225, longitude: 71.5714))
    ]
    
    // Example polygon coordinates
    let polygonCoordinates = [
        CLLocationCoordinate2D(latitude: 23.0, longitude: 71.5),
        CLLocationCoordinate2D(latitude: 23.1, longitude: 71.5),
        CLLocationCoordinate2D(latitude: 23.1, longitude: 71.6),
        CLLocationCoordinate2D(latitude: 23.0, longitude: 71.6),
        CLLocationCoordinate2D(latitude: 23.0, longitude: 71.5) // Closing the polygon
    ]
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Button(action: {
                            selectedLocation = location
                        }) {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                        Text(location.name)
                            .font(.caption)
                            .padding(4)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 3)
                    }
                }
            }
            .overlay(
                PolygonOverlay(coordinates: polygonCoordinates)
                    .border(Color.blue, width: 2)
//                    .fill(Color.blue.opacity(0.2)) // Fill color with opacity
            )
            .edgesIgnoringSafeArea(.all)
            
            if let location = selectedLocation {
                // Add additional UI for selectedLocation if needed
            }
        }
        .onChange(of: selectedLocation) { newValue in
            if let location = newValue, location.name == "Ahmedabad" {
                region.center = location.coordinate
                region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Highlighting the area with a closer zoom
            }
        }
    }
}

struct PolygonOverlay: UIViewRepresentable {
    let coordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        uiView.addOverlay(polygon)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: PolygonOverlay
        
        init(_ parent: PolygonOverlay) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                renderer.strokeColor = .blue
                renderer.lineWidth = 2
                renderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}


#Preview {
    MapViewWithAnnotations()
}
