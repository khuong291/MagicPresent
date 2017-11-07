//
//  ViewController.swift
//  Example
//
//  Created by KhuongPham on 11/7/17.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import UIKit
import MagicPresent

class ViewController: UIViewController {
    
    private var presentationVC: MagicPresent?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showVC2(_ sender: Any) {
        let vc = ViewController2()
        presentationVC = MagicPresent(presentedViewController: vc, presenting: self)
        present(vc, animated: true, completion: nil)
    }
}

