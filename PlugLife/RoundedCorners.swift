//
//  RoundedCorners.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-02-02.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation
import UIKit

func roundBlackCorners(view: UIView, radius: CGFloat, width: CGFloat) {
    view.layer.borderWidth = width
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.cornerRadius = radius
    view.clipsToBounds = true
}
