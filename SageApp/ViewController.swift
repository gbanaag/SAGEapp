//
//  ViewController.swift
//  SageApp
//
//  Created by Gabby Banaag on 7/15/20.
//  Copyright © 2020 Gabbyy. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var quotes = [
        "I am Beyoncé, always.” – Michael Scott",
        " “‘You miss 100% of the shots you don’t take.’” – Wayne Gretsky’ – Michael Scott",
        " “There’s a lot of beauty in ordinary things. Isn’t that kind of the point?” – Pam Beesly",
        "“I wish there was a way to know you’re in the good old days, before you’ve actually left them.” – Andy Bernard",
        
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        // Create notification content
          let content = UNMutableNotificationContent()
          content.title = "Here's your quote of the day ☀️"
          content.body = quotes[2]
        
        // Notif trigger
        let date = Date().addingTimeInterval(15)
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        dateComponents.hour = 11
        dateComponents.minute = 58
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Register request
        center.add(request) { (error) in
        }
    }

  

}

