//
//  Grid.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 23/06/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

enum Grid {

   case layout1, layout2, layout3
    
    var display: [Bool] {
        switch self {
        case .layout1:
            return [false, true, false, false]
        case .layout2:
            return [false, false, false, true]
        case .layout3:
            return [false, false, false, false]
        }
    }
}
