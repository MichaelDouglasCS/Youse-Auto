//
//  CarRepairDetailsCellProtocol.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

protocol CarRepairDetailsCellProtocol {
    var section: CarRepairDetailsViewModel.Sections { get }
    var height: CGFloat { get }
}
