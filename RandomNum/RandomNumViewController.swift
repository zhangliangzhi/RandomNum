//
//  RandomNumViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit

class RandomNumViewController: UIViewController {

    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var btnClick: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnClickAction(_ sender: Any) {
    }

    @IBAction func goBack(_ sender: Any) {
        let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! as UIViewController
        
        self.present(rootViewController, animated: true) { 
            
        }
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let txtColor = UIColor(netHex: Int((nowGlobalSet?.titleRGB)!))
        btnTitle.setTitleColor(txtColor, for: .normal)
        btnClick.setTitleColor(txtColor, for: .normal)
        
        let numColor = UIColor(netHex: Int((nowGlobalSet?.numRGB)!))
        numLabel.textColor = numColor
        
        let bgColor = UIColor(netHex: Int((nowGlobalSet?.bgRGB)!))
        self.view.backgroundColor = bgColor
        bgView.backgroundColor = bgColor

    }

}
