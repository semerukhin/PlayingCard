//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Ilya Semerukhin on 09.05.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

@IBDesignable class PlayingCardView: UIView {
   
   @IBInspectable var rank: Int = 13 { didSet { setNeedsDisplay(); setNeedsLayout() } }
   @IBInspectable var suit: String = "♠️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
   @IBInspectable var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
   
   private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
      var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
      font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
   }
   
   private var cornerString: NSAttributedString {
      return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
   }
   
   private lazy var upperLeftCornerLabel = createCornerLabel()
   private lazy var lowerRightCornerLabel = createCornerLabel()
   
   private func createCornerLabel() -> UILabel {
      let label = UILabel()
      label.numberOfLines = 0
      addSubview(label)
      return label
   }
   
   private func configureCornerLabel(_ label: UILabel) {
      label.attributedText = cornerString
      label.frame.size = CGSize.zero
      label.sizeToFit()
      label.isHidden = !isFaceUp
   }
   
   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      setNeedsDisplay()
      setNeedsLayout()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      configureCornerLabel(upperLeftCornerLabel)
      upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
      configureCornerLabel(lowerRightCornerLabel)
      lowerRightCornerLabel.transform = CGAffineTransform.identity
         .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
         .rotated(by: CGFloat.pi)
      lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
         .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
         .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
   }
   
//   drawPips()
   
   override func draw(_ rect: CGRect) {
      let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      roundedRect.addClip()
      UIColor.white.setFill()
      roundedRect.fill()
      
      if isFaceUp {
         if let faceCardImage = UIImage(named: rankString, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
            faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
         } else {
//            drawPips()
         }
      } else {
         if let cardBackImage = UIImage(named: "back", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
            cardBackImage.draw(in: bounds)
         }
      }
      
//      if let context = UIGraphicsGetCurrentContext() {
//         context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//         context.setLineWidth(5.0)
//         UIColor.green.setFill()
//         UIColor.red.setStroke()
//         context.fillPath()
//         context.strokePath()
//      }

//      let path = UIBezierPath()
//      path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//      path.lineWidth = 5.0
//      UIColor.green.setFill()
//      UIColor.red.setStroke()
//      path.fill()
//      path.stroke()
   }
   
}

extension PlayingCardView {
   private struct SizeRatio {
      static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
      static let cornerRadiusToBoundsHeight: CGFloat = 0.03
      static let cornerOffsetToCornerRadius: CGFloat = 0.5
      static let faceCardImageSizeToBoundsSize: CGFloat = 1
   }
   private var cornerFontSize: CGFloat {
      return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
   }
   private var cornerRadius: CGFloat {
      return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
   }
   private var cornerOffset: CGFloat {
      return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
   }
   private var rankString: String {
      switch rank {
      case 1: return "A"
      case 2...10: return String(rank)
      case 11: return "J"
      case 12: return "Q"
      case 13: return "K"
      default: return "?"
      }
   }
}

extension CGRect {
   var leftHalf: CGRect {
      return CGRect(x: minX, y: minY, width: width / 2, height: height)
   }
   var rightHalf: CGRect {
      return CGRect(x: midX, y: minY, width: width / 2, height: height)
   }
   func inset(by size: CGSize) -> CGRect {
      return insetBy(dx: size.width, dy: size.height)
   }
   func sized(to size: CGSize) -> CGRect {
      return CGRect(origin: origin, size: size)
   }
   func zoom(by scale: CGFloat) -> CGRect {
      let newWidth = width * scale
      let newHeight = height * scale
      return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
   }
}

extension CGPoint {
   func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
      return CGPoint(x: x + dx, y: y + dy)
   }
}





