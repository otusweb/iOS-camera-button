//
//  CameraButton.swift
//  TenStats
//
//  Created by Olivier Destrebecq on 1/16/16.
//  Copyright © 2016 MobDesign. All rights reserved.
//

import UIKit

@IBDesignable
class CameraButton: UIButton {
    var pathLayer:CAShapeLayer!
    override var isSelected:Bool{
        didSet{
            //change the shape of the button based on the selected state
            let colorChange = CABasicAnimation(keyPath: "fillColor")
            colorChange.duration = 0.4;
            colorChange.toValue = UIColor.red.cgColor
            colorChange.fillMode = kCAFillModeForwards
            colorChange.isRemovedOnCompletion = false
            colorChange.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.pathLayer.add(colorChange, forKey:"darkColor")
            
            let morph = CABasicAnimation(keyPath: "path")
            morph.duration = 0.4;
            morph.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            if (self.isSelected)
            {
                morph.toValue = self.innerSquarePath().cgPath
            }
            else
            {
                morph.toValue = self.innerCirclePath().cgPath
            }
            morph.fillMode = kCAFillModeForwards
            morph.isRemovedOnCompletion = false
            self.pathLayer.add(morph, forKey:"")
        }
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    func setup()
    {
        //add a shape layer for the inner shape to be able to animate it
        self.pathLayer = CAShapeLayer()
        self.pathLayer.path = self.innerCirclePath().cgPath
        self.pathLayer.strokeColor = nil
        self.pathLayer.fillColor = UIColor.red.cgColor
        
        self.setTitleColor(UIColor.clear, for: UIControlState.normal)
        self.setTitleColor(UIColor.clear, for: UIControlState.selected)
        
        self.layer.addSublayer(self.pathLayer)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //lock the size to match the size of the camera button
        self.addConstraint(NSLayoutConstraint(item: self, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.width, multiplier:1, constant:66.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.width, multiplier:1, constant:66.0))
        
        //clear the title
        self.setTitle("", for:UIControlState.normal)
        
        //add out target for event handling
        self.addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: UIControlEvents.touchDown)
        self.isSelected = false
    }
    
    override func prepareForInterfaceBuilder()
    {
        //clear the title
        self.setTitle("", for:UIControlState.normal)
    }
    
    func touchUpInside(sender:UIButton)
    {
        self.isSelected = !self.isSelected
    }
    
    func touchDown(sender:UIButton)
    {
        //make it slightly transparent
        let morph = CABasicAnimation(keyPath: "fillColor")
        morph.duration = 0.4;
        morph.toValue = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.5).cgColor
        morph.fillMode = kCAFillModeForwards
        morph.isRemovedOnCompletion = false
        morph.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.pathLayer.add(morph, forKey:"")
    }
    
    override func draw(_ rect: CGRect) {
        let outerRing = UIBezierPath(ovalIn: CGRect(x:3, y:3, width:60, height:60))
        outerRing.lineWidth = 6
        UIColor.white.setStroke()
        outerRing.stroke()
    }
    
    func innerCirclePath () -> UIBezierPath
    {
        return UIBezierPath(roundedRect: CGRect(x:8, y:8, width:50, height:50), cornerRadius: 25)
    }
    
    func innerSquarePath () -> UIBezierPath
    {
        return UIBezierPath(roundedRect: CGRect(x:18, y:18, width:30, height:30), cornerRadius: 4)
    }
}
