//
//  UIImagePickerController.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 29/07/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    // Allow orientation to change during imagePicker
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all }
    
}
