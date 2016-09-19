/*
 * Assembly Kit
 * Licensed Materials - Property of IBM
 * Copyright (C) 2016 IBM Corp. All Rights Reserved.
 * 6949 - XXX
 *
 * IMPORTANT:  This IBM software is supplied to you by IBM
 * Corp. ("IBM") in consideration of your agreement to the following
 * terms, and your use, installation, modification or redistribution of
 * this IBM software constitutes acceptance of these terms. If you do
 * not agree with these terms, please do not use, install, modify or
 * redistribute this IBM software.
 */

import UIKit
import QuartzCore

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class RangeSliderTrackLayer: CALayer {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    weak var rangeSlider: RangeSlider?

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func drawInContext(ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        // Clip
        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        CGContextAddPath(ctx, path.CGPath)
        
        // Fill the track
        CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
        CGContextAddPath(ctx, path.CGPath)
        CGContextFillPath(ctx)
        
        // Fill the highlighted range
        CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
        let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
        let rect = CGRect(x: lowerValuePosition,
                          y: 0.0,
                          width: upperValuePosition - lowerValuePosition,
                          height: bounds.height)
        CGContextFillRect(ctx, rect)
    }
}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class RangeSliderThumbLayer: CALayer {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: RangeSlider?
    
//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func drawInContext(ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        
        let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
        let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
        
        // Fill
        CGContextSetFillColorWithColor(ctx, slider.thumbTintColor.CGColor)
        CGContextAddPath(ctx, thumbPath.CGPath)
        CGContextFillPath(ctx)
        
        // Outline
        let strokeColor = UIColor.grayColor()
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor)
        CGContextSetLineWidth(ctx, 0.5)
        CGContextAddPath(ctx, thumbPath.CGPath)
        CGContextStrokePath(ctx)
        
        if highlighted {
            CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextFillPath(ctx)
        }
    }
}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************
@IBDesignable
class RangeSlider: UIControl {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    
    private var previouslocation = CGPoint()
    
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbLayer = RangeSliderThumbLayer()
    private let upperThumbLayer = RangeSliderThumbLayer()
    
    private var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    @IBInspectable var minimumValue: Float = 0.0 {
        didSet {
            self.updateLayerFrames()
        }
    }
    
    @IBInspectable var maximumValue: Float = 1.0 {
        willSet(newValue) {
            assert(newValue > self.minimumValue,
                   "RangeSlider: maximumValue should be greater than minimumValue")
        }
        didSet {
            self.updateLayerFrames()
        }
    }
    
    @IBInspectable var lowerValue: Float = 0.2 {
        didSet {
            if self.lowerValue < self.minimumValue {
                self.lowerValue = self.minimumValue
            }
            self.updateLayerFrames()
        }
    }
    
    @IBInspectable var upperValue: Float = 0.8 {
        didSet {
            if self.upperValue > self.maximumValue {
                self.upperValue = self.maximumValue
            }
            self.updateLayerFrames()
        }
    }
    
    var gapBetweenThumbs: Float {
        return Float(self.thumbWidth)*(self.maximumValue - self.minimumValue) / Float(bounds.width)
    }
    
    @IBInspectable var trackTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            self.trackLayer.setNeedsDisplay()
        }
    }
    
    @IBInspectable var trackHighlightTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94,
                                                         alpha: 1.0) {
        didSet {
            self.trackLayer.setNeedsDisplay()
        }
    }
    
    @IBInspectable var thumbTintColor = UIColor.whiteColor() {
        didSet {
            self.lowerThumbLayer.setNeedsDisplay()
            self.upperThumbLayer.setNeedsDisplay()
        }
    }
    
    @IBInspectable var curvaceousness: CGFloat = 1.0 {
        didSet {
            if self.curvaceousness < 0.0 {
                self.curvaceousness = 0.0
            }
            
            if self.curvaceousness > 1.0 {
                self.curvaceousness = 1.0
            }
            
            self.trackLayer.setNeedsDisplay()
            self.lowerThumbLayer.setNeedsDisplay()
            self.upperThumbLayer.setNeedsDisplay()
        }
    }
    
    override var frame: CGRect {
        didSet {
            self.updateLayerFrames()
        }
    }
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initializeLayers()
    }

//*************************************************
// MARK: - Private Methods
//*************************************************
    
    private func initializeLayers() {
        layer.backgroundColor = UIColor.clearColor().CGColor
        
        self.trackLayer.rangeSlider = self
        self.trackLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(self.trackLayer)
        
        self.lowerThumbLayer.rangeSlider = self
        self.lowerThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(self.lowerThumbLayer)
        
        self.upperThumbLayer.rangeSlider = self
        self.upperThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(self.upperThumbLayer)
    }
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height/3)
        self.trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(self.positionForValue(self.lowerValue))
        self.lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - self.thumbWidth/2.0,
                                            y: 0.0, width: self.thumbWidth, height: self.thumbWidth)
        self.lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(self.positionForValue(self.upperValue))
        self.upperThumbLayer.frame = CGRect(x: upperThumbCenter - self.thumbWidth/2.0,
                                            y: 0.0, width: self.thumbWidth, height: self.thumbWidth)
        self.upperThumbLayer.setNeedsDisplay()

        CATransaction.commit()
    }
    
    func positionForValue(value: Float) -> Float {
        return Float(bounds.width - self.thumbWidth) * (value - self.minimumValue) /
            (self.maximumValue - self.minimumValue) + Float(self.thumbWidth/2.0)
    }
    
    func boundValue(value: Float, toLowerValue lowerValue: Float, upperValue: Float) -> Float {
        return min(max(value, lowerValue), upperValue)
    }
    
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        self.updateLayerFrames()
    }
    
    //*************************
    // Touches
    //*************************
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        self.previouslocation = touch.locationInView(self)
        
        // Hit test the thumb layers
        if self.lowerThumbLayer.frame.contains(self.previouslocation) {
            self.lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(self.previouslocation) {
            self.upperThumbLayer.highlighted = true
        }
        
        return self.lowerThumbLayer.highlighted || self.upperThumbLayer.highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        // Determine by how much the user has dragged
        let deltaLocation = Float(location.x - self.previouslocation.x)
        let deltaValue = (self.maximumValue - self.minimumValue) * deltaLocation /
            Float(bounds.width - bounds.height)
        
        self.previouslocation = location
        
        // Update the values
        if self.lowerThumbLayer.highlighted {
            self.lowerValue = self.boundValue(self.lowerValue + deltaValue,
                                              toLowerValue: self.minimumValue,
                                              upperValue: self.upperValue - self.gapBetweenThumbs)
        } else if self.upperThumbLayer.highlighted {
            self.upperValue = self.boundValue(self.upperValue + deltaValue,
                                              toLowerValue: self.lowerValue + self.gapBetweenThumbs,
                                              upperValue: self.maximumValue)
        }
        
        sendActionsForControlEvents(.ValueChanged)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        self.lowerThumbLayer.highlighted = false
        self.upperThumbLayer.highlighted = false
    }
}
