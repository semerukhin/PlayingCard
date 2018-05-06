//
//  ViewController.swift
//  PlayingCard
//
//  Created by Ilya Semerukhin on 06.05.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   var deck = PlayingCardDeck()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      for _ in 1...10 {
         if let card = deck.draw() {
            print("\(card)")
         }
      }
   }
   
}





