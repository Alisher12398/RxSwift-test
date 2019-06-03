//
//  SecondExampleViewController.swift
//  RxSwift-test1
//
//  Created by Алишер Халыкбаев on 03/06/2019.
//  Copyright © 2019 Алишер Халыкбаев. All rights reserved.
//

import UIKit

class SecondExampleViewController: UIViewController {

    @IBOutlet weak var toCitiesButton: UIButton!

    @IBOutlet weak var elementView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UIPanGestureRecognizer(target: elementView, action: Selector(("circleMoved:")))
        elementView?.addGestureRecognizer(gestureRecognizer)
    }

    func circleMoved(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.elementView?.center = location
        }
    }
    
}
