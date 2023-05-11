//
//  FlowController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

protocol FlowController {

    associatedtype Destination

    // Navigate to different screen based on defined destination
    func navigate(to destination: Destination)
}
