//
//  RandomNumViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit
import CoreData

class RandomNumViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var btnClick: UIButton!
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var numLabel: UILabel!
    
    var isStart:Bool = true
    var tmpID:Int64 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewBtnStatue()
        numLabel.text = "-"
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    // 点击开始
    @IBAction func btnClickAction(_ sender: Any) {
        let startID:Int64 = (nowGlobalSet?.startID)!
        let endID:Int64 = (nowGlobalSet?.endID)!
        let dID = endID - startID
        
        // 改变了一次状态
        if self.isStart {
            // 开始 播放随机数动画
            let ndID:UInt32 = UInt32(dID)
            tmpID = Int64(arc4random_uniform(ndID+1))
            tmpID = tmpID + startID
            numLabel.text = String(tmpID)
        }else {
            // 结束 保存数据
            let oneRandomData = NSEntityDescription.insertNewObject(forEntityName: "RandomData", into: context) as! RandomData
            oneRandomData.curTime = NSDate()
            oneRandomData.num = tmpID
            appDelegate.saveContext()
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
            btnClick.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        }else {
            self.isStart = true
            btnClick.setTitle(NSLocalizedString("Stop", comment: ""), for: .normal)
        }
        
    }
}
