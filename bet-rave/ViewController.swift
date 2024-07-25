//
//  ViewController.swift
//  bet-rave
//
//  Created by Eric Chandonnet on 2024-07-14.
//

import UIKit

class ViewController: UIViewController {
    
    let sportService = SportService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchFights()
        }
    }
    
    func fetchFights() async {
        do {
            let fights = try await sportService.getFights()
            fights.forEach { fight in
                print("\(fight.fighters.first.name) VS \(fight.fighters.second.name)")
            }
            
        } catch {
            print("Error fetching fights: \(error)")
        }
    }


}

