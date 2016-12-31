//
//  ViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = NSLocalizedString("Setting", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goRandom(_ sender: Any) {

        let ranViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "RandomNum") as! RandomNumViewController
        
        self.present(ranViewController, animated: true) {
        }
        
    }

}

