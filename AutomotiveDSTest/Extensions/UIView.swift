//
//  UIView.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-03.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /// Method to load a View from the bundle
    ///
    /// - Returns: View to return
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
