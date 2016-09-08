// slightly updated version of drawableview.swift (created by nofel mahmood)
// swift 2.3
// https://github.com/nofelmahmood/SmoothDrawing-Swift

import UIKit

class DrawableView: UIView {
	
	let path = UIBezierPath()
	var previousPoint: CGPoint
	var lineWidth: CGFloat = 5.0
	
	override init(frame: CGRect) {
		previousPoint = CGPoint.zero
		super.init(frame: frame)
	}
	
	required init(coder aDecoder: NSCoder) {
		previousPoint = CGPoint.zero
		super.init(coder: aDecoder)!
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DrawableView.pan(_:)))
		panGestureRecognizer.maximumNumberOfTouches = 1
		self.addGestureRecognizer(panGestureRecognizer)
		
	}
	
	override func drawRect(rect: CGRect) {
		// Drawing code
		UIColor.whiteColor().setStroke()
		path.stroke()
		path.lineWidth = lineWidth
	}
	
	func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void {
		let currentPoint = panGestureRecognizer.locationInView(self)
		let midPoint = self.midPoint(previousPoint, p1: currentPoint)
		
		if panGestureRecognizer.state == .Began
		{
			path.moveToPoint(currentPoint)
		}
		else if panGestureRecognizer.state == .Changed
		{
			path.addQuadCurveToPoint(midPoint,controlPoint: previousPoint)
		}
		
		previousPoint = currentPoint
		self.setNeedsDisplay()
	}
	
	func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint {
		let x = (p0.x+p1.x) / 2
		let y = (p0.y+p1.y) / 2
		return CGPoint(x: x, y: y)
	}
	
}
