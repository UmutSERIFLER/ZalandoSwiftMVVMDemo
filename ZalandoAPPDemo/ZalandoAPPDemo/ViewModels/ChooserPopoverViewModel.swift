//
//  ChooserPopoverViewModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class ChooserPopoverViewModel: NSObject , UIPopoverPresentationControllerDelegate {
    
    // `sharedInstance` because the delegate property is weak - the delegate instance needs to be retained.
    private static let sharedInstance = ChooserPopoverViewModel()
    
    private override init() {
        super.init()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        presentationController.delegate = ChooserPopoverViewModel.sharedInstance
        return presentationController
    }
    
}
