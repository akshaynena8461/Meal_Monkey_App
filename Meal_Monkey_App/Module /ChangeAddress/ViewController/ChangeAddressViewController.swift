import MapKit
import UIKit

// MARK: - Delegate Protocol
protocol ChangeAddressDelegate: AnyObject {
    func didSelectAddress(_ address: String)  // Called when user selects an address
}

class ChangeAddressViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var lblChooseSavedAddress: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapView: MKMapView!  // Map view showing location
    @IBOutlet weak var txtSearchAddress: UITextField!  // Text field to search address
    @IBOutlet weak var btnChooseSavedPlace: UIButton!  // Button to choose saved places (optional)
    @IBOutlet weak var btnCurrentLocation: UIButton!  // Button to move map to current location
    var fullAddress: String?  // Store last selected address

    // MARK: - Properties
    weak var delegate: ChangeAddressDelegate?  // Delegate to send selected address back
    let locationManager = CLLocationManager()  // Handles device location updates
    let geocoder = CLGeocoder()  // Converts between coordinates and addresses

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        setupUI()
        setupLocation()
        setupMap()
    }
    
    func applyTheme(){
        let theme = ThemeManager.shared
        view.backgroundColor = theme.backgroundColor()
        internalView.backgroundColor = theme.backgroundColor()
        mainView.backgroundColor = theme.backgroundColor()
        txtSearchAddress.textColor = theme.textColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtSearchAddress.placeholder = LanguageManager.shared.localizedString(for: "8461_search_address")
        lblChooseSavedAddress.text = LanguageManager.shared.localizedString(for: "8461_choose_saved_address")
        applyTheme()
    }

    // MARK: - UI Setup
    private func setupUI() {
        // Style the search text field
        EditStyle.setborder(textfields: [txtSearchAddress], cornerRadious: 28)
        EditStyle.setPadding(textFields: [txtSearchAddress], paddingWidth: 34)

        setLeftAlignedTitleWithBack(
            Main.NavTitle.changeAddress,
            target: self,
            action: #selector(BackBtnTapped)
        )

        // Add tap gesture to map to detect user taps
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mapTapped(_:))
        )
        mapView.addGestureRecognizer(tapGesture)

        // Listen for "Return" key to search address
        txtSearchAddress.addTarget(
            self,
            action: #selector(searchAddress),
            for: .editingDidEndOnExit
        )
    }

    // MARK: - Location Setup
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
    }

    // MARK: - Map Setup
    private func setupMap() {
        mapView.showsUserLocation = true

        // Set default location (example: Ahmedabad, India)
        let defaultLocation = CLLocationCoordinate2D(
            latitude: 23.040517,
            longitude: 72.503878
        )
        centerMap(on: defaultLocation)
        addPinAtCenterAndReverseGeocode()
    }

    // MARK: - Map Interaction
    @objc func mapTapped(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        updatePinAndAddress(at: coordinate)
    }

    private func updatePinAndAddress(at coordinate: CLLocationCoordinate2D) {
        // Remove old annotations (except user location)
        mapView.removeAnnotations(
            mapView.annotations.filter { !($0 is MKUserLocation) }
        )

        // Add a new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Loading address..."
        mapView.addAnnotation(annotation)

        // Reverse geocode to get human-readable address
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        geocoder.reverseGeocodeLocation(location) {
            [weak self] placemarks, error in
            guard let self = self else { return }

            var resoveAddress = "Unknown Location"
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let city = placemark.locality ?? ""
                let country = placemark.country ?? ""
                resoveAddress = "\(name), \(city), \(country)"

                annotation.title = name
                annotation.subtitle = "\(city), \(country)"
            }

            self.fullAddress = resoveAddress
            self.mapView.selectAnnotation(annotation, animated: true)
            self.delegate?.didSelectAddress(fullAddress ?? "")  // Notify delegate
        }
    }

    // MARK: - CLLocationManager Delegate
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        centerMap(on: location.coordinate)
        updatePinAndAddress(at: location.coordinate)
        locationManager.stopUpdatingLocation()
    }

    // MARK: - Address Search
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

    // MARK: - Current Location
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

    // MARK: - Map Helpers
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

    // MARK: - Location Permission
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
            title: Main.Location.title,
            message: Main.Location.message,
            preferredStyle: .alert

        )

        alert.addAction(
            UIAlertAction(title: Main.Location.cancel, style: .cancel)
        )
        alert.addAction(
            UIAlertAction(
                title: Main.Location.settings,
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

    // MARK: - Back Button
    @objc func BackBtnTapped() {
        // If a pin is selected, save its title as the selected address
        if let myfullAddress = fullAddress, !myfullAddress.isEmpty {

            // Save the full address in UserDefaults
            UserDefaults.standard.set(fullAddress, forKey: "SelectedAddress")
            UserDefaults.standard.synchronize()

            // Notify delegate with full address
            delegate?.didSelectAddress(fullAddress ?? "")
        }

        // Pop view controller
        navigationController?.popViewController(animated: true)
    }
}
