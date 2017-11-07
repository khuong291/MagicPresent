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
    
    @IBAction func showTopPosition(_ sender: Any) {
        let vc = ViewController3()
        presentationVC = MagicPresent(presentedViewController: vc, presenting: self)
        presentationVC?.position = .top
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showCenterPosition(_ sender: Any) {
        let vc = ViewController2()
        presentationVC = MagicPresent(presentedViewController: vc, presenting: self)
        presentationVC?.cornerRadius = 6
        presentationVC?.position = .center
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showBottomPosition(_ sender: Any) {
        let vc = ViewController3()
        presentationVC = MagicPresent(presentedViewController: vc, presenting: self)
        presentationVC?.position = .bottom
        present(vc, animated: true, completion: nil)
    }
}

