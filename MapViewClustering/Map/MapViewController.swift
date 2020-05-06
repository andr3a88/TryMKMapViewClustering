//
//  ViewController.swift
//  MapViewClustering
//
//  Created by Andrea Stevanato on 06/05/2020.
//  Copyright © 2020 Andrea Stevanato. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var annotations: [MKAnnotation] = Array(1...100).map({ (index) -> MKPointAnnotation in
        let annotation = MKPointAnnotation()
        annotation.title = "Pin \(index)"
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double.random(in: 43...46), longitude: Double.random(in: 11...13))
        return annotation
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.addAnnotations(annotations)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is MKPointAnnotation:
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
            view.clusteringIdentifier = "cluster_id"
            return view
        case is MKClusterAnnotation:
            return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation)
        default:
            return nil
        }
    }
}
