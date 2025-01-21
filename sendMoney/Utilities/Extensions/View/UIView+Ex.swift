//
//  UIView+Ex.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 19/01/2025.
//

import UIKit

extension UIView {

    func addCorner(_ value: CGFloat = 20) {
        layer.cornerRadius = value
        layer.masksToBounds = true
    }
    
    func loadViewFromNib() {
        guard let nibView = Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)?.first as? UIView else {
            fatalError("Could not load CustomView from nib.")
        }
        
        // Set the custom view's frame and add it to the current view
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }
}
