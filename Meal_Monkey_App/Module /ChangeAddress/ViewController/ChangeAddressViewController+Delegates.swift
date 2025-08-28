import MapKit
import UIKit

// MARK: - CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate
extension ChangeAddressViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    // MARK: - Location Manager Error Handling
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Called when location updates fail
        print("Failed to get location: \(error.localizedDescription)")
    }

    // MARK: - Map View Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // Skip user location annotation (blue dot)
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            // Create a new annotation view if one isn't available for reuse
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true // Show title/subtitle when tapped
            annotationView?.image = UIImage(named: "Ic_Location_Pin") // Custom pin image

            // Adjust pin so it points correctly to location
            annotationView?.centerOffset = CGPoint(
                x: 0,
                y: -(annotationView?.image?.size.height ?? 0) / 2
            )

            // Add a detail disclosure button to callout
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            // Reuse existing annotation view
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
