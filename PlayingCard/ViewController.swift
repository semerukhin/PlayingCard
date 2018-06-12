//
//  ViewController.swift
//  PlayingCard
//
//  Created by Ilya Semerukhin on 06.05.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   private var deck = PlayingCardDeck()
   
   @IBOutlet private var cardViews: [PlayingCardView]!
   
//   @IBOutlet weak var playingCardView: PlayingCardView! {
//      didSet {
//         let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
//         swipe.direction = [.left, .right]
//         playingCardView.addGestureRecognizer(swipe)
//         let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
//         playingCardView.addGestureRecognizer(pinch)
//      }
//   }
//
//   @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
//      switch sender.state {
//      case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
//      default: break
//      }
//   }
//
//   @objc func nextCard() {
//      if let card = deck.draw() {
//         playingCardView.rank = card.rank.order
//         playingCardView.suit = card.suit.rawValue
//      }
//   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      var cards = [PlayingCard]()
      for _ in 1...((cardViews.count+1)/2) {
         let card = deck.draw()!
         cards += [card, card]
      }
      for cardView in cardViews {
         cardView.isFaceUp = false
         let card = cards.remove(at: cards.count.arc4random)
         cardView.rank = card.rank.order
         cardView.suit = card.suit.rawValue
         cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
      }
//      for _ in 1...52 {
//         if let card = deck.draw() { print("\(card)") }
//      }
   }
   
   @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
      switch recognizer.state {
      case .ended:
         if let chosenCardView = recognizer.view as? PlayingCardView {
            UIView.transition(with: chosenCardView, duration: 0.6, options: [.transitionFlipFromLeft], animations: {
               chosenCardView.isFaceUp = !chosenCardView.isFaceUp
            })
         }
      default:
         break
      }
   }
   
}





