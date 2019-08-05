//
//  UIView.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 29/07/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

import UIKit

extension UIView {
    /// Screenshot gridView
    var transformToImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
}
