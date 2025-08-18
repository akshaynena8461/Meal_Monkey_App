import MapKit
import UIKit

protocol ChangeAddressDelegate: AnyObject {
    func didSelectAddress(_ address: String)
}

class ChangeAddressViewController: UIViewController {

    weak var delegate: ChangeAddressDelegate?

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var btnChooseSavedPlace: UIButton!
    @IBOutlet weak var btnCurrentLocation: UIButton!

    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        setupUI()
        setupLocation()
        setupMap()
    }

    private func setupUI() {
        EditStyle.setborder(textfields: [txtSearchAddress], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearchAddress], paddingWidth: 34)
        mapView.delegate = self

        setLeftAlignedTitleWithBack(
            "Change Address",
            target: self,
            action: #selector(BackBtnTapped)
        )
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapTapped(_:))
        )
        mapView.addGestureRecognizer(tapGesture)

        txtSearchAddress.addTarget(
            self,
            action: #selector(searchAddress),
            for: .editingDidEndOnExit
        )
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
    }

    private func setupMap() {
        mapView.showsUserLocation = true
        // Default location (e.g., your city)
        let defaultLocation = CLLocationCoordinate2D(
            latitude: 23.0225,
            longitude: 72.5714
        )
        centerMap(on: defaultLocation)
        addPinAtCenterAndReverseGeocode()
    }

    @objc func mapTapped(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        updatePinAndAddress(at: coordinate)
    }

    private func updatePinAndAddress(at coordinate: CLLocationCoordinate2D) {

        mapView.removeAnnotations(
            mapView.annotations.filter { !($0 is MKUserLocation) }
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Loading address..."
        mapView.addAnnotation(annotation)

        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        geocoder.reverseGeocodeLocation(location) {
            [weak self] placemarks, error in
            guard let self = self else { return }

            var fullAddress = "Unknown Location"
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                fullAddress = "\(name), \(city), \(country)"

                annotation.title = name
                annotation.subtitle = "\(city), \(country)"
            }
            self.mapView.selectAnnotation(annotation, animated: true)
            self.delegate?.didSelectAddress(fullAddress)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        centerMap(on: location.coordinate)
        updatePinAndAddress(at: location.coordinate)
        locationManager.stopUpdatingLocation()
    }

    // MARK: - Search Address
    @objc func searchAddress() {
        guard let query = txtSearchAddress.text, !query.isEmpty else { return }
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first,
                let location = placemark.location
            else { return }
            let coordinate = location.coordinate
            self.centerMap(on: coordinate)
            self.updatePinAndAddress(at: coordinate)
        }
        txtSearchAddress.resignFirstResponder()
    }

    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        goToCurrentLocation()
    }

    func goToCurrentLocation() {
        if let coordinate = locationManager.location?.coordinate {
            centerMap(on: coordinate)
            updatePinAndAddress(at: coordinate)
        } else {
            locationManager.startUpdatingLocation()
        }
    }

    func centerMap(
        on location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(region, animated: true)
    }

    func addPinAtCenterAndReverseGeocode() {
        let centerCoord = mapView.centerCoordinate
        updatePinAndAddress(at: centerCoord)
    }

    func checkLocationPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                showPermissionAlert()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        } else {
            let status = CLLocationManager.authorizationStatus()
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if status == .denied || status == .restricted {
                showPermissionAlert()
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }

    func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Location Permission Needed",
            message:
                "Please enable location access in Settings to use this feature.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(
            UIAlertAction(
                title: "Open Settings",
                style: .default,
                handler: { _ in
                    if let settingsURL = URL(
                        string: UIApplication.openSettingsURLString
                    ) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            )
        )
        present(alert, animated: true)
    }

    @objc func BackBtnTapped() {
        if let selectedAnnotation = mapView.annotations.first(where: {
            !($0 is MKUserLocation)
        }) {
            if let title = selectedAnnotation.title ?? "", !title.isEmpty {
                UserDefaults.standard.set(title, forKey: "SelectedAddress")
                UserDefaults.standard.synchronize()
                delegate?.didSelectAddress(title)
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
