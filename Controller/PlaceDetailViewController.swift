

import UIKit
import MapKit

class PlaceDetailViewController: UIViewController,MKMapViewDelegate {
    
    var placeInfo:PlaceInfo!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desctiptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var GoogleMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsCompass=false
        self.mapView.showsUserLocation=true
        self.mapView.userTrackingMode = .none
        self.mapView.delegate=self
        
        self.titleLabel.text = self.placeInfo.title ?? ""
        self.desctiptionLabel.text = self.placeInfo.subtitle ?? ""
       // self.GoogleMap.buttonType = self.placeInfo.coordinate ?? ""
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = self.placeInfo.coordinate
        self.mapView.addAnnotation(newPin)
        
        let savedPlaces = UserDefaults.standard.object(forKey: "saved_places") as? NSData
        
        
        
        if savedPlaces != nil {
            
            let savedPlacesArray = NSKeyedUnarchiver.unarchiveObject(with: savedPlaces! as Data) as! [PlaceInfo]
            
            if savedPlacesArray.contains(where: { $0.placeID == self.placeInfo.placeID }) {
                
                self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark"), for: .normal)
            } else {
                
                self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark-off"), for: .normal)
            }
            
        }else{
            
            self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark-off"), for: .normal)
        }
        
    }
    
    
    @IBAction func ShareBtn(_ sender: Any) {
        let URLstring =  String(format:"https://http://madad-official.com/")
        let urlToShare = URL(string:URLstring)
        let activityViewController = UIActivityViewController(
            activityItems: [desctiptionLabel,urlToShare!],
            applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        //so that ipads won't crash
        present(activityViewController,animated: true,completion: nil)
        
    }
    
    
    @IBAction func GoolgeBtnPRessed(_ sender: Any) {
    }
    
    
   
    override func viewDidAppear(_ animated: Bool) {
        checkLocationServiceAuthenticationStatus()
    }
    var locationManager = CLLocationManager()
    
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
    
    
    @IBAction func bookMarkPressed(_ sender: UIButton) {
        
        
        let savedPlacesData = UserDefaults.standard.object(forKey: "saved_places") as? NSData
        
        if savedPlacesData != nil {
            
            var savedPlacesArray = NSKeyedUnarchiver.unarchiveObject(with: savedPlacesData! as Data) as! [PlaceInfo]
            
            if savedPlacesArray.contains(where: { $0.placeID == self.placeInfo.placeID }) {
                // Remove
                savedPlacesArray.removeFirst()
                self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark-off"), for: .normal)
            } else {
                
                //ADD
                
                savedPlacesArray.append(placeInfo)
                self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark"), for: .normal)
            }
            
            let savedPlaceData=NSKeyedArchiver.archivedData(withRootObject: savedPlacesArray)
            
            UserDefaults.standard.set(savedPlaceData, forKey: "saved_places")
            UserDefaults.standard.synchronize()
            
            
            
        }else{
            
            
            let savedPlaceData=NSKeyedArchiver.archivedData(withRootObject: [placeInfo])
            
            UserDefaults.standard.set(savedPlaceData, forKey: "saved_places")
            UserDefaults.standard.synchronize()
            
            self.bookMarkButton.setImage(#imageLiteral(resourceName: "mark"), for: .normal)
            
        }
        
    }
    
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
    
}

extension PlaceDetailViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        _ = locations.last!
        self.mapView.showsUserLocation = true
    }
}



