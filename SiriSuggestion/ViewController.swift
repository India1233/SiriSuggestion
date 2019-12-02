//
//  ViewController.swift
//  SiriSuggestion
//
//  Created by shiga on 02/12/19.
//  Copyright © 2019 Shigas. All rights reserved.
//

import UIKit
import IntentsUI


class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        
    }
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.displayNotifications), name: NSNotification.Name(rawValue: "ShowNotifications"), object: nil)
        
        setupIntentsForSiri()
    }
    
    func setupIntentsForSiri()  {
        
        let actionIdentifier = "Shigas.SiriSuggestion.shownotifications"
        let activity = NSUserActivity(activityType: actionIdentifier)
        activity.title = "Show Notifictions"
        activity.userInfo = ["speech" : "show notifications"]
        activity.isEligibleForSearch = true
        
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.persistentIdentifier = NSUserActivityPersistentIdentifier(actionIdentifier)
        }
        
        view.userActivity = activity
        activity.becomeCurrent()
    }
    
    @objc func displayNotifications() {
        if #available(iOS 12.0, *) {
            guard let userActivity = view.userActivity else { return }
            let shortcut = INShortcut(userActivity: userActivity)
            let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            
        }
    }
}

