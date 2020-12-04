//
//  ContactsViewController.swift
//  SlideInTransition
//
//  Created by otigan on 26.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ContactsViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var contactsImage: UIImageView!
    
    
   
    var timer: Timer?

    
    
    
    @IBOutlet weak var adress: UITextView!
    
    @IBOutlet weak var number: UITextView!
    
    
    @IBOutlet weak var status: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.number.delegate = self
        self.adress.delegate = self
        self.status.delegate = self
        

        
        number.isScrollEnabled = false
        adress.isScrollEnabled = false
        status.isScrollEnabled = false
        
         let attributes = [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)]
        
        let numberString = NSMutableAttributedString(string: "Номер телефона: +7(382)290-66-00", attributes: attributes)
        
        adress.textContentType = .addressCityAndState
    
        
        
        let adressString = NSMutableAttributedString(string: "Адрес: ул. Елизаровых, 86, Томск, Томская обл., 634021", attributes: attributes)
        
        
        adressString.addAttribute(.link, value: "address", range: NSRange(location: 7, length: 47))

        
        

    
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            
            self.updateStatus(timer: timer)
        }
        
        
        self.number.attributedText = numberString
        self.adress.attributedText = adressString
        //self.status.text = "kek"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isMovingFromParent {
            
            timer?.invalidate()
            timer = nil
            
        }
        
    }
    
    func updateStatus(timer: Timer) {
        
        
        DispatchQueue.main.async {
            
            print("UPDATING")
            
            
            let date = Date()
            
            let formatter = DateFormatter()
            
            formatter.dateFormat = "HH:mm"
            
            
            formatter.timeZone = TimeZone(secondsFromGMT: 3600 * 7)
            
            
            let getDate = formatter.string(from: date)
            
             
            
        
            self.status.text = self.findDateDiff(time1Str: getDate)
            
            
           
                
        }
        
        
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        
        if URL.absoluteString == "address" {
            print("ADDRESS")
            
            openMap(forAddress:" ул. Елизаровых, 86, Томск, Томская обл., 634021") {
                (location) in
                guard let location = location else {
                    return
                }
                
            	let placemark = MKPlacemark(coordinate: location)
                
                let mapItem = MKMapItem(placemark: placemark)
                
                mapItem.openInMaps(launchOptions: nil)
            }
        }
        
        if URL.scheme == "tel" {
            let phone = URL.absoluteString.replacingOccurrences(of: "tel:", with: "")
            
            if let callUr = Foundation.URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(callUr) {
                UIApplication.shared.open(callUr)
            }
            
        }
        return true
    }
    
    func openMap(forAddress address: String, completion: @escaping(CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            
            guard error == nil else {
                print("GEO ERROR")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
                
            }
            
        }
    
    
    func findDateDiff(time1Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "HH:mm"

        guard let time1 = timeformatter.date(from: time1Str) else { return ""}
        
        
        var calendar = Calendar.current
        
        let currentTime = calendar.component(.hour, from: time1)
        

        print(currentTime)
        
        
        if currentTime > 8 && currentTime < 20 {
            
            guard let time2 = timeformatter.date(from: "20:00") else { return "" }
            
            let interval = time2.timeIntervalSince(time1)
            let hour = interval / 3600;
            let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
            let intervalInt = Int(interval)
            return "Открыто (закроется через \(Int(hour)) ч. \(Int(minute)) м.)"
            
        } else {
            
            guard let time2 = timeformatter.date(from: "08:00") else { return "" }
                   
            let interval = time1.timeIntervalSince(time2)
            let hour = interval / 3600;
            let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
            let intervalInt = Int(interval)
            return "Закрыто (откроется через \(Int(hour)) ч. \(Int(minute)) м.)"
            
            
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
