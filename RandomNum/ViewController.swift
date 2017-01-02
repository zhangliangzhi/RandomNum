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
        if tfStartNum.isFirstResponder {
            print("start",tfStartNum.text)
        }
        
        if tfEndNum.isFirstResponder {
            print("end",tfEndNum.text)
        }
        
        if tfFontNum.isFirstResponder {
            print("font",tfFontNum.text)
        }
        
        if tfRepeatNum.isFirstResponder {
            print("count",tfRepeatNum.text)
        }
        
        self.view.endEditing(false)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        firstOpenAPP()
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
        oneGlobalSet.title = NSLocalizedString("Set Title", comment: "")
        oneGlobalSet.endID = 3
        oneGlobalSet.startID = 1
        oneGlobalSet.repeatNum = 0
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

