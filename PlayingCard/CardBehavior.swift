//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by Ilya Semerukhin on 12.06.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
   
   lazy var collisionBehavior: UICollisionBehavior = {
      let behavior = UICollisionBehavior()
      behavior.translatesReferenceBoundsIntoBoundary = true
      return behavior
   }()
   
   lazy var itemBehavior: UIDynamicItemBehavior = {
      let behavior = UIDynamicItemBehavior()
      behavior.allowsRotation = false
      behavior.elasticity = 1.0
      behavior.resistance = 0
      return behavior
   }()
   
   private func push(_ item: UIDynamicItem) {
      let push = UIPushBehavior(items: [item], mode: .instantaneous)
      push.angle = (2*CGFloat.pi).arc4random
      push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
      push.action = { [unowned push, weak self] in
         self?.removeChildBehavior(push)
      }
      addChildBehavior(push)
   }
   
   func addItem(_ item: UIDynamicItem) {
      collisionBehavior.addItem(item)
      itemBehavior.addItem(item)
      push(item)
   }
   
   override init() {
      super.init()
      addChildBehavior(collisionBehavior)
      addChildBehavior(itemBehavior)
   }
   
   convenience init(in animator: UIDynamicAnimator) {
      self.init()
      animator.addBehavior(self)
   }

}





