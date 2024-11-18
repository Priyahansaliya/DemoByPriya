//
//  CustomMapView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 27/09/24.

import SwiftUI
import MapKit

struct CustomMapView: View {
    
    // MARK: - Variables
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @Namespace private var locationSpace
    @State private var mapSelection: MKMapItem?
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResult: [MKMapItem] = []
    @State private var isSearching: Bool = false // To indicate search status
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var viewingRegion: MKCoordinateRegion?
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
                // Annotation for a specific location
                Annotation("Ahmedabad", coordinate: CLLocationCoordinate2D(latitude: 23.0225, longitude: 72.5714)) {
                    ZStack {
                        Image(systemName: "applelogo").font(.body)
                        Image(systemName: "square").font(.largeTitle)
                    }
                }
                .annotationTitles(.hidden)
                
                // Annotations for search results
                ForEach(searchResult, id: \.self) { item in
                    if routeDisplaying {
                        if item == routeDestination {
                            let placemark = item.placemark
                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                .tint(.blue)
                        }
                    }else{
                        let placemark = item.placemark
                        Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                }
                
                // Route overlay (if available)
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(Color.blue, lineWidth: 3)
                }
                
                // User location annotation
                UserAnnotation()
            }
            .onMapCameraChange({ ctx in
                viewingRegion = ctx.region
            })
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 16) {
                    MapCompass(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            
            // Search bar
            .searchable(text: $searchText, isPresented: $showSearch)
            
            // Translucent toolbar
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
            
            // Details sheet for selected item
            .sheet(isPresented: $showDetails, onDismiss: {
                withAnimation(.snappy) {
                    // zoom route
                    if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(boundingRect)
                    }
                }
            }, content: {
                mapDetail()
                    .presentationDetents([.height(350)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(350)))
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled(true)
            })
            .safeAreaInset(edge: .bottom) {
                if routeDisplaying {
                    Button("End Route") {
                        withAnimation(.snappy) {
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeDestination
                            routeDestination = nil
                            route = nil
                            cameraPosition = .region(.myRegion)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.red.gradient, in: .rect(cornerRadius: 15))
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
            
            // Search submission logic
            .onSubmit(of: .search) {
                Task {
                    guard !searchText.isEmpty else { return }
                    debounceSearch()
                }
            }
            
            // Handle changes in search text
            .onChange(of: searchText, initial: false) {
                if !showSearch {
                    searchResult.removeAll(keepingCapacity: false)
                    showDetails = false
                    // Zoom out to user's region when search is canceled
                    withAnimation(.snappy) {
                        cameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.0225, longitude: 72.5714),
                                                                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                    }
                }
            }
            
            // Handle changes in map selection
            .onChange(of: mapSelection) { oldValue, newValue in
                showDetails = newValue != nil
                fetchLookAroundPreview()
            }
            
            // Display progress view while searching
            .overlay {
                if isSearching {
                    ProgressView("Searching...") // Show loading indicator when searching
                }
            }
        }
    }
    
    @ViewBuilder
    func mapDetail() -> some View {
        VStack(spacing: 15) {
            ZStack {
                if lookAroundScene == nil {
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                }else{
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails = false
                    withAnimation(.snappy) {
                        mapSelection = nil
                    }
                }) {
                    Image(systemName: "mark.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                        .background(.white, in: .circle)
                }
                .padding(10)
            }
            Button("Get Direction", action: fetchRoute)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(.blue.gradient, in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    
    // MARK: - Debounce Search Function
    private func debounceSearch() {
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // Add delay to debounce
            if !searchText.isEmpty {
                await searchPlace()
            }
        }
    }
    
    // MARK: - Search Function
    private func searchPlace() async {
        isSearching = true
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = viewingRegion ?? .myRegion
        
        do {
            let results = try await MKLocalSearch(request: request).start()
            searchResult = results.mapItems
        } catch {
            print("Search failed with error: \(error.localizedDescription)")
            searchResult = []
        }
        isSearching = false
    }
    
    func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
    
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: .myLocation))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = mapSelection
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = true
                   
                }
            }
        }
    }
}

#Preview {
    CustomMapView()
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 23.0225, longitude: 72.5714)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
