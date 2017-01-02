//
//  RandomNumViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit

class RandomNumViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var btnClick: UIButton!
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // 点击开始
    @IBAction func btnClickAction(_ sender: Any) {
    }
    
    // 点击显示日志
    @IBAction func showLogAction(_ sender: Any) {
        print("show ok log")
    }

    // 返回
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
        // 名称
        let txtColor = UIColor(netHex: Int((nowGlobalSet?.titleRGB)!))

        titleLabel.textColor = txtColor
        titleLabel.text = nowGlobalSet?.title
        
        // 数字
        let numColor = UIColor(netHex: Int((nowGlobalSet?.numRGB)!))
        numLabel.textColor = numColor
        let isize:Int = Int((nowGlobalSet?.numFont)!)
        numLabel.font = UIFont(name: "Arial-BoldMT", size: CGFloat(isize))

        numLabel.adjustsFontSizeToFitWidth = true
        numLabel.isHighlighted = true
        
        // 背景颜色
        let bgColor = UIColor(netHex: Int((nowGlobalSet?.bgRGB)!))
        self.view.backgroundColor = bgColor
        bgView.backgroundColor = bgColor

        // 按钮颜色
        btnClick.setTitleColor(numColor, for: .normal)

    }

}
