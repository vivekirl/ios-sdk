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
import TradeoffAnalyticsV1

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

class CustomCollectionViewLayout: UICollectionViewLayout {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var numberOfColumns = 0
    var itemAttributes : NSMutableArray!
    var itemsSize : NSMutableArray!
    var contentSize : CGSize!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func sizeForItemWithColumnIndex(columnIndex: Int) -> CGSize {
        
        let aColumn = Storage.sharedObject().arrColumns[columnIndex]
        
        let size : CGSize = (aColumn.fullName! as NSString).sizeWithAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(17.0)])

        let width : CGFloat = self.collectionView!.bounds.width/CGFloat(Storage.sharedObject().arrColumns.count)
        return CGSizeMake(width, 30)
    }
    
    func calculateItemsSize() {
        self.itemsSize = NSMutableArray(capacity: numberOfColumns)
        for index in 0..<numberOfColumns {
            self.itemsSize.addObject(NSValue(CGSize: self.sizeForItemWithColumnIndex(index)))
        }
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func prepareLayout() {
        if self.collectionView?.numberOfSections() == 0 {
            return
        }
        
        numberOfColumns =  Storage.sharedObject().arrColumns.count
        
        if (self.itemAttributes != nil && self.itemAttributes.count > 0) {
            for section in 0..<self.collectionView!.numberOfSections() {
                let numberOfItems : Int = self.collectionView!.numberOfItemsInSection(section)
                for index in 0..<numberOfItems {
                    if section != 0 && index != 0 {
                        continue
                    }
                    
                    let attributes = self.layoutAttributesForItemAtIndexPath(
                        NSIndexPath(forItem: index, inSection: section))!
                    if section == 0 {
                        var frame = attributes.frame
                        frame.origin.y = self.collectionView!.contentOffset.y
                        attributes.frame = frame
                    }
                    
                    if index == 0 {
                        var frame = attributes.frame
                        frame.origin.x = self.collectionView!.contentOffset.x
                        attributes.frame = frame
                    }
                }
            }
            return
        }
        
        if (self.itemsSize == nil || self.itemsSize.count != numberOfColumns) {
            self.calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<self.collectionView!.numberOfSections() {
            let sectionAttributes = NSMutableArray()
            
            for index in 0..<numberOfColumns {
                let itemSize = self.itemsSize[index].CGSizeValue()
                let indexPath = NSIndexPath(forItem: index, inSection: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = CGRectIntegral(CGRectMake(xOffset,
                                                             yOffset,
                                                             itemSize.width,
                                                             itemSize.height))
                
                if section == 0 && index == 0 {
                    attributes.zIndex = 1024;
                } else  if section == 0 || index == 0 {
                    attributes.zIndex = 1023
                }
                
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    attributes.frame = frame
                }
                if index == 0 {
                    var frame = attributes.frame
                    frame.origin.x = self.collectionView!.contentOffset.x
                    attributes.frame = frame
                }
                
                sectionAttributes.addObject(attributes)
                
                xOffset += itemSize.width
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }
            if (self.itemAttributes == nil) {
                let sections = self.collectionView!.numberOfSections()
                self.itemAttributes = NSMutableArray(capacity: sections)
            }
            self.itemAttributes .addObject(sectionAttributes)
        }
        
        if let attributes = self.itemAttributes.lastObject?.lastObject
            as? UICollectionViewLayoutAttributes {
            contentHeight = attributes.frame.origin.y + attributes.frame.size.height
        }
        self.contentSize = CGSizeMake(contentWidth, contentHeight)
    }
    
    override func collectionViewContentSize() -> CGSize {
        return self.contentSize!
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
        -> UICollectionViewLayoutAttributes? {
        return self.itemAttributes.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row)
            as? UICollectionViewLayoutAttributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        if self.itemAttributes != nil {
            for section in self.itemAttributes {
                
                if let filteredArray = section.filteredArrayUsingPredicate(
                        NSPredicate(block: { (evaluatedObject, bindings) -> Bool in
                            return CGRectIntersectsRect(rect, evaluatedObject.frame)
                        })
                    ) as? [UICollectionViewLayoutAttributes] {
                    attributes.appendContentsOf(filteredArray)
                }
                
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
