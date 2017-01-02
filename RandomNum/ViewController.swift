//
//  ViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var arrRandomNum:[RandomData] = []
var arrGlobalSet:[CurGlobalSet] = []
var nowGlobalSet:CurGlobalSet?


class ViewController: UIViewController, ColorPickerDelegate, UITextFieldDelegate {


    
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var btnbgColor: UIButton!
    @IBOutlet weak var btnNumColor: UIButton!
    @IBOutlet weak var btnTitleColor: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblFont: UILabel!
    @IBOutlet weak var lblRange: UILabel!
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfRepeatNum: UITextField!
    @IBOutlet weak var tfFontNum: UITextField!
    @IBOutlet weak var tfEndNum: UITextField!
    @IBOutlet weak var tfStartNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        tfStartNum.delegate = self
        tfEndNum.delegate = self
        
        tfStartNum.inputAccessoryView = AddToolBar()
        tfEndNum.inputAccessoryView = AddToolBar()
        tfFontNum.inputAccessoryView = AddToolBar()
        tfRepeatNum.inputAccessoryView = AddToolBar()
        
        self.title = NSLocalizedString("Setting", comment: "")
    }
    
    // 点击空白，取消键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        doneNum()
        self.view.endEditing(false)
    }
    
    func AddToolBar() -> UIToolbar {
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
//        toolBar.tintColor = UIColor.blue
        toolBar.backgroundColor = UIColor.gray
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtn = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: self, action: #selector(doneNum))
        toolBar.items = [spaceBtn, barBtn]
        
        return toolBar
    }
    
    func doneNum() {
        // 关闭界面
        DispatchQueue.main.async {
            self.view.endEditing(false)
        }
        
        // 保持数值
        if tfStartNum.isFirstResponder {
//            print("start",tfStartNum.text)
            var strStartID:String = tfStartNum.text!
            strStartID = strStartID.trimmingCharacters(in: .whitespaces)
            if strStartID == "" {
                TipsSwift.showTopWithText(NSLocalizedString("Can not be empty", comment: ""))
                return
            }
            let iNum = Int64(strStartID)
            if iNum == nil {
                TipsSwift.showTopWithText(NSLocalizedString("Must be number", comment: ""))
                return
            }
            
            nowGlobalSet?.startID = iNum!
            appDelegate.saveContext()
            TipsSwift.showTopWithText(NSLocalizedString("Set success", comment: ""))
            return
        }
        
        if tfEndNum.isFirstResponder {
//            print("end",tfEndNum.text)
            var strStartID:String = tfEndNum.text!
            strStartID = strStartID.trimmingCharacters(in: .whitespaces)
            if strStartID == "" {
                TipsSwift.showTopWithText(NSLocalizedString("Can not be empty", comment: ""))
                return
            }
            let iNum = Int64(strStartID)
            if iNum == nil {
                TipsSwift.showTopWithText(NSLocalizedString("Must be number", comment: ""))
                return
            }
            
            nowGlobalSet?.endID = iNum!
            appDelegate.saveContext()
            TipsSwift.showTopWithText(NSLocalizedString("Set success", comment: ""))
            return
        }
        
        if tfFontNum.isFirstResponder {
//            print("font",tfFontNum.text)
            var strStartID:String = tfFontNum.text!
            strStartID = strStartID.trimmingCharacters(in: .whitespaces)
            if strStartID == "" {
                TipsSwift.showTopWithText(NSLocalizedString("Can not be empty", comment: ""))
                return
            }
            let iNum = Int32(strStartID)
            if iNum == nil {
                TipsSwift.showTopWithText(NSLocalizedString("Must be number", comment: ""))
                return
            }
            
            nowGlobalSet?.numFont = iNum!
            appDelegate.saveContext()
            TipsSwift.showTopWithText(NSLocalizedString("Set success", comment: ""))
            return
        }
        
        if tfRepeatNum.isFirstResponder {
//            print("count",tfRepeatNum.text)
            var strStartID:String = tfRepeatNum.text!
            strStartID = strStartID.trimmingCharacters(in: .whitespaces)
            if strStartID == "" {
                TipsSwift.showTopWithText(NSLocalizedString("Can not be empty", comment: ""))
                return
            }
            let iNum = Int64(strStartID)
            if iNum == nil {
                TipsSwift.showTopWithText(NSLocalizedString("Must be number", comment: ""))
                return
            }
            
            nowGlobalSet?.repeatNum = iNum!
            appDelegate.saveContext()
            TipsSwift.showTopWithText(NSLocalizedString("Set success", comment: ""))
            return
        }
        
    }
    
    func initDataFromCoreData() {
        // coreData数据
        tfStartNum.text = String(format: "%d", (nowGlobalSet?.startID)!)
        tfEndNum.text = String(format: "%d", (nowGlobalSet?.endID)!)
        tfFontNum.text = String(format: "%d", (nowGlobalSet?.numFont)!)
        tfRepeatNum.text = String(format: "%d", (nowGlobalSet?.repeatNum)!)
        tfTitle.text = nowGlobalSet?.title
        
        tfStartNum.placeholder = NSLocalizedString("Start Number", comment: "")
        tfEndNum.placeholder = NSLocalizedString("End Number", comment: "")
        tfFontNum.placeholder = NSLocalizedString("Enter Num Font" , comment: "")
        tfRepeatNum.placeholder = NSLocalizedString("Enter Repeat Count", comment: "")
        tfTitle.placeholder = NSLocalizedString("Enter custom title", comment: "")
        
        // 文本多语言数据
        lblRange.text = NSLocalizedString("Random range:", comment: "")
        lblFont.text = NSLocalizedString("Number Font:", comment: "")
        lblCount.text = NSLocalizedString("Repeat Count:", comment: "")
        lblTitle.text = NSLocalizedString("Set View Title:", comment: "")
        
        // 按钮名字多语言
        btnTitleColor.setTitle(NSLocalizedString("Set Title color:", comment: ""), for: .normal)
        btnNumColor.setTitle(NSLocalizedString("Set number color:" , comment: ""), for: .normal)
        btnbgColor.setTitle(NSLocalizedString("Set bakcground color:", comment: ""), for: .normal)
        btnGo.setTitle(NSLocalizedString("MY UI", comment: ""), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        firstOpenAPP()
        initDataFromCoreData()
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

    func getCoreData() -> Void {
        arrRandomNum = []
        arrGlobalSet = []
        
        do {
            arrRandomNum = try context.fetch(RandomData.fetchRequest())
        }catch {
            print("RandomData coreData error")
        }
        
        do {
            arrGlobalSet = try context.fetch(CurGlobalSet.fetchRequest())
        }catch {
            print("Setting coreData error")
        }

        if arrGlobalSet.count > 0 {
            nowGlobalSet = arrGlobalSet[0]
        }
        print(nowGlobalSet)
    }
    
    // 第一次打开app，加入测试数据
    func firstOpenAPP() -> Void {
        // 初始化
        if arrGlobalSet.count > 0 {
            return
        }
        
        let oneGlobalSet = NSEntityDescription.insertNewObject(forEntityName: "CurGlobalSet", into: context) as! CurGlobalSet
        
        oneGlobalSet.title = NSLocalizedString("Set custom title", comment: "")
        oneGlobalSet.endID = 3
        oneGlobalSet.startID = 1
        oneGlobalSet.repeatNum = 0
        oneGlobalSet.numFont = 60
        
        context.insert(oneGlobalSet)
        appDelegate.saveContext()
        getCoreData()
    }
    
    
    func ColorColorPickerTouched(sender: ColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState)
    {
        btnGo.backgroundColor = color
        sender.removeFromSuperview()
    }

    // 打开颜色选择器
    func openSelColorView() -> Void {
        let pickerWidth = self.view.frame.size.width
        let pickerHeight = (pickerWidth * 11) / 19
        let colorPicker = ColorPicker(frame: CGRect(
            x: 0,
            y: self.view.frame.size.height / 2 - pickerHeight / 2,
            width: pickerWidth,
            height: pickerHeight
        ))
        
        colorPicker.delegate = self
        self.view.addSubview(colorPicker)
    }
}

