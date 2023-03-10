//
//  CustomLayout.swift
//  CollectionViewFlowRotate
//
//  Created by Steven Curtis on 28/12/2020.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    // the cache store so we don't have to keep calcuating the attributes
    var cache = [UICollectionViewLayoutAttributes]()
    // this is the content bounds for the area of the content
    var contentBounds = CGRect.zero

    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        // when we rotate, clear the cached data
        cache = []
    }
    
    // the size of the content (without which we cannot scroll)
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    // update the current layout, setting the frame for each cell and store in a cache
    // prepare up-front calculations to provide layout information
    // whenever the layout is invalidated, preparelayout is called
    override func prepare() {
        super.prepare()
        // don't recalculate everything if we haven't cleared our cache (so we are on the same orientation)
         guard self.cache.isEmpty, let collectionView = collectionView else {
             return
         }
        
        // set the contentBounds to be the size of the collectionview, pinned at the top-left
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)

        // we need to know the last frame in order to sequentially show the UICollectionViewCells
        var lastFrame: CGRect = .zero
        
        // for each item in the UICollectionView
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            // the frame will be calculated from the last frame, with a height of 200
            let frame = CGRect(x: 0, y: lastFrame.maxY, width: collectionView.bounds.width, height: 200.0)
            // calculate the indexPath
            let indexPath = IndexPath(item: item, section: 0)
            // we are going to deal with the attributes for the current index path
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // set the frame of the attribute, which is for the current indexPath
            attributes.frame = frame
            // make sure we have a cache so we don't always recreate the same attributes
            cache.append(attributes)
            // set the last frame
            lastFrame = frame
            // calculate the bounds of the whole content
            contentBounds = contentBounds.union(lastFrame)
        }
    }
    
    // This method returns the attributes for every cell in a rectangle
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            // if the attributes insect the given CGRect
            if attributes.frame.intersects(rect) {
                // we are interested in these attributes! So we can prepare to return them!
                visibleLayoutAttributes.append(attributes)
            }
        }
        // return the attributes
        return visibleLayoutAttributes
    }
}
