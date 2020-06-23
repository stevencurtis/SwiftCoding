//
//  MapExampleView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI
import MapKit

struct MapExampleView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507351, longitude: -0.127758), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapExampleView_Previews: PreviewProvider {
    static var previews: some View {
        MapExampleView()
    }
}
