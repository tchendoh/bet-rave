//
//  ViewController.swift
//  bet-rave
//
//  Created by Eric Chandonnet on 2024-07-14.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let sportService = SportService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchFights()
        }
    }
    
    func fetchFights() async {
        let logger = Logger()

        do {
            let fights = try await sportService.getFights()
            fights.forEach { fight in
                logger.info("\(fight.fighters.first.name) VS \(fight.fighters.second.name)")
            }
            
        } catch {
            logger.info("Error fetching fights: \(error)")
        }
    }
    
    
}
