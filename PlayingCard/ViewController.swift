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
   
   @IBOutlet weak var playingCardView: PlayingCardView! {
      didSet {
         let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
         swipe.direction = [.left, .right]
         playingCardView.addGestureRecognizer(swipe)
         let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
         playingCardView.addGestureRecognizer(pinch)
      }
   }
   
   @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
      switch sender.state {
      case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
      default: break
      }
   }
   
   @objc func nextCard() {
      if let card = deck.draw() {
         playingCardView.rank = card.rank.order
         playingCardView.suit = card.suit.rawValue
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
//      for _ in 1...52 {
//         if let card = deck.draw() { print("\(card)") }
//      }
   }
   
}





