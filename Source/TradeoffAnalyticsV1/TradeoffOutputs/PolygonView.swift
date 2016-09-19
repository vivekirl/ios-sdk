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


class PolygonView: UIView {

//*************************************************
// MARK: - Properties
//*************************************************
    
    var polygon4 : Array<CGPoint> = Array<CGPoint>()

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func calculatePolygonArray(anchorArr: NSArray) {
        
        var xMax: CGFloat = 0.0
        var yMax: CGFloat = 0.0
        
        for dict in anchorArr {
            if let dictionary = dict as? NSDictionary {
                if let positionDict = dictionary.valueForKey("position") as? NSDictionary {
                    if let xvalue = positionDict.valueForKey("x") as? NSNumber {
                        let xval = CGFloat(xvalue.floatValue)
                        if xval > xMax{
                            xMax = xval
                        }
                    }
                    if let yvalue = positionDict.valueForKey("y") as? NSNumber {
                        let yval = CGFloat(yvalue.floatValue)
                        if yval > yMax{
                            yMax = yval
                        }
                    }
                }
            }
        }

        for dict in anchorArr{
            var positionDict = NSDictionary()
            var name = ""
            
            if let dictionary = dict as? NSDictionary {
                if let posDict = dictionary.valueForKey("position") as? NSDictionary,
                    nameValue = dictionary.valueForKey("name") as? String {
                    positionDict = posDict
                    name = nameValue
                }
            }
            
            let nameLabel: UILabel = self.configNameLabel(name)

            if let xval = positionDict.valueForKey("x") as? NSNumber,
                yval = positionDict.valueForKey("y") as? NSNumber {
                let a = CGPoint(x:(((self.frame.size.width - 40) / xMax) *
                    CGFloat(xval.floatValue)) + 20,
                                 y: (((self.frame.size.height - 40) / yMax)
                                    * CGFloat(yval.floatValue)) + 20)
                nameLabel.center = a
                self.polygon4.append(a)
            }
        }
        setNeedsDisplay()
    }
    
    func configNameLabel(name: String) -> UILabel {
        let nameLabel : UILabel = UILabel (frame: CGRectMake(0, 0, 80, 80))
        
        nameLabel.layer.borderColor = UIColor.grayColor().CGColor
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.cornerRadius = 10
        nameLabel.clipsToBounds = true
        nameLabel.textColor = UIColor.whiteColor()
        
        if name.compare(managerTenureKey) == .OrderedSame{
            nameLabel.backgroundColor = managerTenureColor
        }
        if name.compare(assetsKey) == .OrderedSame{
            nameLabel.backgroundColor = assetsColor
        }
        if name.compare(shortTermKey) == .OrderedSame{
            nameLabel.backgroundColor = shortTermColor
        }
        if name.compare(midTermKey) == .OrderedSame{
            nameLabel.backgroundColor = midTermColor
        }
        if name.compare(longTermKey) == .OrderedSame{
            nameLabel.backgroundColor = longTermColor
        }
        if name.compare(riskKey) == .OrderedSame{
            nameLabel.backgroundColor = riskColor
        }
        if name.compare(personalityKey) == .OrderedSame{
            nameLabel.backgroundColor = personalityColor
        }
        if name.compare(morningStarRatingKey) == .OrderedSame{
            nameLabel.backgroundColor = morningstarRatingColor
        }
        if name.compare(ytdKey) == .OrderedSame{
            nameLabel.backgroundColor = YTDColor
        }
        if name.compare(netExpenseKey) == .OrderedSame{
            nameLabel.backgroundColor = netExpenseColor
        }
        nameLabel.layer.shadowColor = UIColor.blackColor().CGColor
        nameLabel.layer.shadowOffset = CGSizeMake(0, 2);
        nameLabel.layer.shadowRadius = 5.0
        nameLabel.layer.shadowOpacity = 0.7
        nameLabel.textAlignment = .Center
        nameLabel.text = name
        nameLabel.numberOfLines = 5
        self.addSubview(nameLabel)
        
        return nameLabel
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        var index = 0
        for startPoint in  self.polygon4 {
            if index == 0{
                CGContextMoveToPoint(context, startPoint.x, startPoint.y)
            } else{
                CGContextAddLineToPoint(context, startPoint.x, startPoint.y)
            }
            index = index + 1
        }
        CGContextClosePath(context)
        CGContextDrawPath(context, .Stroke)
    }

}
