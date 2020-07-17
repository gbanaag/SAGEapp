//
//  ViewController.swift
//  SageApp
//
//  Created by Gabby Banaag on 7/15/20.
//  Copyright © 2020 Gabbyy. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var switchOne: UISwitch!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var switchThree: UISwitch!
    @IBOutlet weak var switchFour: UISwitch!
    @IBOutlet weak var switchFive: UISwitch!
    
    
    var switchOneOn = false
    var switchTwoOn = false
    var switchThreeOn = false
    var switchFourOn = false
    
    
    @IBOutlet weak var hellooLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    // SCORE LABEL AND VAR
    @IBOutlet weak var scoreLabel: UILabel!
    var score = Int()
    
    var theOfficeQuotes = [
        "”I am Beyoncé, always.” – Michael Scott",
        " “‘You miss 100% of the shots you don’t take.’” – Wayne Gretsky’ – Michael Scott",
        " “There’s a lot of beauty in ordinary things. Isn’t that kind of the point?” – Pam Beesly",
        "“I wish there was a way to know you’re in the good old days, before you’ve actually left them.” – Andy Bernard",
        "“And I knew exactly what to do. But in a much more real sense, I had no idea what to do.” - Michael Scott"
    ]
    
    var greysQuotes = [
          " “Don't let what he wants eclipse what you need. He's very dreamy, but he's not the sun. You are.“ —Cristina Ya season 10, episode 24",
          "”Walk tall. All you can do is be brave enough to get out there. You fought. You loved. You lost. Walk tall.“ —Mark Sloan, season 5, episode 12",
          "”Choose me. Love me.“ —Meredith Grey, season 2, episode 5",
          "”Be unstoppable. Be a force of nature. --- You’re on your own. Be on your own.” —Cristina Yang, season 4, episode 15",
          "”It's good to be scared. It means you still have something to lose.” —Richard Weber, season 4, episode 10"
       ]
    
    var friendsQuotes = [
        "”What if I don't want to be a shoe? What if I want to be a purse, you know? Or, a hat?” -Rachel",
        "”You can’t just give up! Is that what a dinosaur would do?” - Joey",
        "”How you doin’?” - Joey",
        "”Sure, I have my bad days, but then I remember what a cute smile I have.” - Chandler",
        "”It's like a cow’s opinion. It just doesn’t matter. It’s moo.” -Joey"
    ]
    
    var avatarQuotes = [
        "”In the darkest of times, hope is something you give yourself.” - Zuko",
        "”Sometimes the best way to solve a problem is to help others.” - Iroh",
        "”Life happens wherever you are, whether you make it or not.” - Iroh",
        "“Sometimes life is like this tunnel. You can’t always see the light at the end of the tunnel, but if you keep moving, you will come to a better place.” - Iroh",
        "“You can’t knock me down!” - Katara",
        "“”Life happens wherever you are, whether you make it or not.“ -Iroh"
    ]
    
    var criminalQuotes = [
        "”The best and most beautful things can not be seen or even touched.” - Helen Keller",
        "”Love is giving someone the ability to destroy you, but trusting them not to”",
        "”Nothing is so common as the wish to be remarkable.” - Shakespeare",
        "”In the end, Its not the years in your life that counts. Its the life in your years.” - Abraham Lincoln",
        "”I remained to inside my head and ended up loosing my mind” - Edgar Allen Poe"
    ]
    
    var goodPlaceQuotes = [
        "“What matters isn’t if people are good or bad. What matters is, if they’re trying to be better today than they were yesterday.“ -Michael",
        "”Enlightenment comes from within. The Dalai Llama texted me that.“ – Tahani Al-Jamil",
        "”Ya basic. And that’s okay.” – Eleanor Shellstrop",
        "”In case you were wondering, I am, by definition, the best version of myself.” – Janet",
        "”Pobody’s nerfect.” – Eleanor Shellstrop"
    ]
    
    var strangerQuotes = [
        "”Friends don't lie.” — Eleven",
        "”You shouldn't like things because people tell you you're supposed to.” — Jonathan",
        "”You can't spell America without Erica.” — Erica",
        "”If we’re both going crazy, then we’ll go crazy together, right?” — Mike",
        "”If you believe in this story... Finish it.” — Mrs Wheeler"
    ]
    
    var flashQuotes = [
        "Felicity Smoak: Boom. Drop the mic. It's metaphorical, of course, because we don't have a real mic.",
        "Cisco Ramon: He's a bad guy; I'm calling it a lair.",
        "Cisco Ramon: It's a work in progress, Elsa.",
        "Dr. Harrison Wells: Acceptance is a powerful thing.",
        "Cisco Ramon: In your dreams, Sister Cold. You know I could call The Flash. He'd be here in like two seconds - probably one."
    ]
    
    var euphoriaQuotes = [
        "Plenty Of Great, Intelligent, Funny, Interesting, And Creative People Have Struggled With The Same Things You Struggle With.",
        "That it's about balance, stability. The need to organize her feelings and thoughts, so she can breathe easier.",
        "“I definitely haven't reached my full power.” - Jules Vaughn",
        "”I wasn't going to stop until I got the truth.“ - Rue",
        "“Suddenly, the whole world goes dark and nothing else matters except the person standing in front of you.” - Rue Bennett"
    ]
    
    var umbrellaQuotes = [
        "“I love you! Even if you can’t love yourself!“ -Klaus",
        "“Life is short. Future doesn’t come with any guarantees. You want something in life, you gotta go for it.“",
        "“If you believe in yourself for once, just once, great things are gonna happen for you.“ -Leonard",
        "The ties that bind you together make you stronger than you are alone. They will make you impervious to the pain and hardship the world will thrust upon you.",
        "“What’s meant to be is meant to be. That’s our raison d’être.“ -Number 5"
    ]
    
//    var quotes = [
//        theOfficeQuotes, greysQuotes, friendsQuotes, avatarQuotes,  criminalQuotes, goodPlaceQuotes, strangerQuotes, flashQuotes, euphoriaQuotes, umbrellaQuotes
//    ]
    
    var quotesArray: [[String]] = [[]]
    

    override func viewDidLoad() {
        getData()
        scoreLabel.text = "\(score)"
        
        super.viewDidLoad()
        
        quotesArray = [theOfficeQuotes, greysQuotes, friendsQuotes, avatarQuotes, criminalQuotes, goodPlaceQuotes, strangerQuotes, flashQuotes, euphoriaQuotes, umbrellaQuotes]
        
        // Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        // Create notification content
          let content = UNMutableNotificationContent()
          content.title = "Here's your quote of the day ☀️"
          content.body = umbrellaQuotes[1]
        
        // Notif trigger
        let date = Date().addingTimeInterval(15)
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        dateComponents.hour = 14
        dateComponents.minute = 14
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Register request
        center.add(request) { (error) in
        }
    }
    
    @IBAction func twiceADay(_ sender: UISwitch) {
        switchOne.setOn(true, animated: true)
        switchTwo.setOn(false, animated: true)
        switchThree.setOn(false, animated: true)
        switchFour.setOn(false, animated: true)
        switchFive.setOn(false, animated: true)
    }
    
    @IBAction func onceADay(_ sender: UISwitch) {
        switchOne.setOn(false, animated: true)
        switchTwo.setOn(true, animated: true)
        switchThree.setOn(false, animated: true)
        switchFour.setOn(false, animated: true)
        switchFive.setOn(false, animated: true)
    }
    
    @IBAction func everyOtherDay(_ sender: UISwitch) {
        switchOne.setOn(false, animated: true)
        switchTwo.setOn(false, animated: true)
        switchThree.setOn(true, animated: true)
        switchFour.setOn(false, animated: true)
        switchFive.setOn(false, animated: true)
    }
    
    @IBAction func onceAWeek(_ sender: UISwitch) {
        switchOne.setOn(false, animated: true)
        switchTwo.setOn(false, animated: true)
        switchThree.setOn(false, animated: true)
        switchFour.setOn(true, animated: true)
        switchFive.setOn(false, animated: true)
    }
    
    @IBAction func turnOff(_ sender: UISwitch) {
        switchOne.setOn(false, animated: true)
        switchTwo.setOn(false, animated: true)
        switchThree.setOn(false, animated: true)
        switchFour.setOn(false, animated: true)
        switchFive.setOn(true, animated: true)
    }
    
    @IBAction func clickClick(_ sender: UIButton) {
        changeLabel.text = "aaAAaaaaaAAhHHHHHh"
    }
    
//    let defaults = UserDefaults.standard
//
//
//
//
//    var nameInputted = ""
//    @IBAction func submitName(_ sender: UIButton) {
//        nameInputted = textField.text
//        print(nameInputted)
//    }
//
//    let name = nameInputted
//    defaults.set(name, forKey: "name")
//
//
//



    @IBAction func askForFood(_ sender: UIButton) {
//        hellooLabel.text = newTitle + " aight"
    }
    
    
    @IBAction func increaseScore(_ sender: Any) {
        score += 1
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func saveData(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(score, forKey: "number")
        
        do {
            try context.save()
            print("saved")
        }   catch {
            print("Failed saving")
        }
        
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                score = data.value(forKey: "number") as! Int
            }
        } catch {
                print("Failed")
            }
        }
    }
    
    
    
    




//switchOneOn = false
//switchTwoOn = true
//switchThreeOn = false
//switchFourOn = false

