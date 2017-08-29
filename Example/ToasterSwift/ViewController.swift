//
//  ViewController.swift
//  ToasterSwift
//
//  Created by jonathan-leininger on 08/29/2017.
//  Copyright (c) 2017 jonathan-leininger. All rights reserved.
//

import UIKit
import ToasterSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ToasterSwift.shared.show(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", keep: true, close: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

