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

    var timer:Timer!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var btnClick: UIButton!
    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var numLabel: UILabel!
    
    var isStart:Bool = false
    var tmpID:Int64 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNewBtnStatue()
        numLabel.text = "0"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        initNewBtnStatue()
    }
    
    func setRtxt() {
        let startID:Int64 = (nowGlobalSet?.startID)!
        let endID:Int64 = (nowGlobalSet?.endID)!
        let dID = endID - startID
        let ndID:UInt32 = UInt32(dID)
        
        var genID:Int64 = Int64(arc4random_uniform(ndID+1))
        // 3次还一样就算了，反正是假的显示用的
        if tmpID == genID {
            genID = Int64(arc4random_uniform(ndID+1))
            if tmpID == genID {
                genID = Int64(arc4random_uniform(ndID+1))
                if tmpID == genID {
                    genID = Int64(arc4random_uniform(ndID+1))
                }
            }
        }
        
        tmpID = genID
        numLabel.text = String(tmpID + startID)
        
    }
    
    // 点击开始
    @IBAction func btnClickAction(_ sender: Any) {
        let startID:Int64 = (nowGlobalSet?.startID)!
//        let endID:Int64 = (nowGlobalSet?.endID)!
        // 改变了一次状态
        if self.isStart == false {
            // 开始 播放随机数动画
            timer = Timer.scheduledTimer(timeInterval: 0.08, target: self, selector: #selector(setRtxt), userInfo: nil, repeats: true)
        }else {
            // 定时器取消
            timer.invalidate()
            
            // 结束 保存数据
            let realNum = getRealRandomNum()
            numLabel.text = String(realNum)
            
            let oneRandomData = NSEntityDescription.insertNewObject(forEntityName: "RandomData", into: context) as! RandomData
            oneRandomData.curTime = NSDate()
            oneRandomData.num = realNum
            arrRandomNum.insert(oneRandomData, at: 0)
            appDelegate.saveContext()
        }
        
        // 改变按钮 文字显示状态
        setNewBtnStatue()
    }
    
    // num:次数
    struct NumCount {
        let num:Int64    // member
        var count:Int   // count
    }
    
    // 获取随机数值
    func getRealRandomNum() -> Int64 {
        let dCount:Int = Int((nowGlobalSet?.repeatNum)!)
        
        let startID:Int64 = (nowGlobalSet?.startID)!
        let endID:Int64 = (nowGlobalSet?.endID)!

        // 1.次数全为0先
        var arrNumCount:[NumCount] = []
        for i in startID...endID {
            arrNumCount.append(NumCount(num: i, count: 0))
        }
        
        
        // 2. 统计次数
        for i in 0..<arrRandomNum.count {
            let one = arrRandomNum[i]
            for j in 0..<arrNumCount.count {
                if arrNumCount[j].num == one.num {
                    arrNumCount[j].count = arrNumCount[j].count + 1
                }
            }
        }
        
        // 3.按次数排序
        arrNumCount.sort(by: {$0.count < $1.count})
        
        // 4.提取可以加入随机的数字
        var arrMinNumCount:[NumCount] = []
        let minCount = arrNumCount[0].count
        for i in 0..<arrNumCount.count {
            let one = arrNumCount[i]
            if one.count <= minCount + dCount {
                arrMinNumCount.append(one)
            }
        }
        
        // 5. 开始随机啦
        let nCount:UInt32 = UInt32(arrMinNumCount.count)
        let getRanIndex:Int = Int(arc4random_uniform(nCount))
        let getNewNumCount = arrMinNumCount[getRanIndex]
        
        
        return getNewNumCount.num
    }
    
    // 点击显示日志
    @IBAction func showLogAction(_ sender: Any) {
//        print("show ok log")
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
    
    func initNewBtnStatue() {
        self.isStart = false
        btnClick.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
    }
}
