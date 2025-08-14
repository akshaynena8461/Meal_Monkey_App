import MapKit
import UIKit

extension ChangeAddressViewController: CLLocationManagerDelegate,
    UISearchBarDelegate, MKMapViewDelegate
{

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Failed to get location: \(error.localizedDescription)")
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)
        -> MKAnnotationView?
    {
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        )

        if annotationView == nil {
            annotationView = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            annotationView?.canShowCallout = true

            // Set your custom image
            annotationView?.image = UIImage(named: "Ic_Location_Pin")

            // Optional: center the pin bottom on the coordinate
            annotationView?.centerOffset = CGPoint(
                x: 0,
                y: -(annotationView?.image?.size.height ?? 0) / 2
            )

            // Optional: add a detail button on callout
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

}
