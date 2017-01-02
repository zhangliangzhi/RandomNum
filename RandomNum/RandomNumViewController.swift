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
    
    var isStart:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 是否开始了
        setNewBtnStatue()
    }
    
    // 点击开始
    @IBAction func btnClickAction(_ sender: Any) {

        
        // 改变了一次状态
        if self.isStart {
            // 开始 播放随机数动画
            
        }else {
            // 结束 保存数据
            
        }
        
        // 改变按钮 文字显示状态
        setNewBtnStatue()
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

    func setNewBtnStatue() {
        let issta:Bool = self.isStart
        if issta {
            self.isStart = false
            btnClick.setTitle(NSLocalizedString("Stop", comment: ""), for: .normal)
        }else {
            self.isStart = true
            btnClick.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        }
        
    }
}
