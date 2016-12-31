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

class ViewController: UIViewController {

    @IBOutlet weak var btnGo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = NSLocalizedString("Setting", comment: "")
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
    

}

