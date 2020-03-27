import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

      ///----------------- <<< OUTLETS & VARIBLES >>> -----------------///
    
    
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func AddPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.madad-official.com/add-place")! as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
    
    let locationManager = CLLocationManager()
    let places = PlaceInfo.getPlaces()
    
    var locationsArray:[[String:Any]]=[]
    var currentPlacemark: CLPlacemark?

    
    
    
    ///----------------- <<< LOAD THE FUNCTIONS INTO VIEW >>> -----------------///

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAnnotations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   checkLocationServiceAuthenticationStatus()
    }

    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(places)
        
        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        mapView?.addOverlays(overlays)
    }
    
    func fetchAllData(){
        
        self.mapView.showsCompass=false
        self.mapView.showsUserLocation=true
        self.mapView.userTrackingMode = .none
        self.mapView.delegate=self
        
        if let path = Bundle.main.path(forResource: "Locations", ofType: "plist") {
            ////If your plist contain root as Dictionary
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                
                let keys=dic.keys
                
                for dataOfKey in keys {
                    if let object=dic[dataOfKey] as? [[String:Any]]{
                        
                        locationsArray.append(contentsOf: object)
                    }
                }
            }
            
            for location in self.locationsArray{
                
                let newPin = MKPointAnnotation()
                newPin.coordinate = CLLocationCoordinate2D.init(latitude: Double(location["latitude"] as! String)!, longitude: Double(location["longitude"] as! String)!)
                self.mapView.addAnnotation(newPin)
                
            }
        }
  
    }
    
    
   
    @IBAction func showDirection(_ sender: Any) {
        guard let currentPlacemark = currentPlacemark else {
            return
        }
        
        let directionRequest = MKDirections.Request()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        // calculate the directions / route
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (directionsResponse, error) in
            guard let directionsResponse = directionsResponse else {
                if let error = error {
                    let alertController = UIAlertController(title: "Direction not available", message: "Route is not available now", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                return
            }
            
            let route = directionsResponse.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let routeRect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion.init(routeRect), animated: true)
        }
    }
    
    //  Current Location
    

    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private let regionRadius: CLLocationDistance = 3000 // 1km ~ 1 mile = 1.6km


}

extension MapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else if let annotation = annotation as? PlaceInfo {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()

            annotationView.image = UIImage(named: annotation.imageName!)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView.canShowCallout = true
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceInfo, let title = annotation.title else { return }
        
        let placeDetailVC=self.storyboard?.instantiateViewController(withIdentifier: "PlaceDetailViewController") as! PlaceDetailViewController
        placeDetailVC.placeInfo = annotation
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let location = view.annotation as? PlaceInfo {
            self.currentPlacemark = MKPlacemark(coordinate: location.coordinate)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
