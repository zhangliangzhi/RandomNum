//
//  LogTableViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2017/1/3.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class LogTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet var logTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Log", comment: "")
        logTextView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrRandomNum.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let oneData = arrRandomNum[indexPath.row]
        
        cell.textLabel?.text = String(oneData.num)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let strTime:String = dformatter.string(from: oneData.curTime as! Date)
        cell.detailTextLabel?.text = strTime
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logTextView.resignFirstResponder()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backAction(_ sender: Any) {
        let ranViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "RandomNum") as! RandomNumViewController
        
        self.present(ranViewController, animated: true) {
        }
    }

    @IBAction func delAll(_ sender: Any) {
        logTextView.resignFirstResponder()
        for i in 0..<arrRandomNum.count {
            let oneData = arrRandomNum[i]
            context.delete(oneData)
        }
        arrRandomNum.removeAll()
        logTableView.reloadData()
        logTextView.text = ""
        appDelegate.saveContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    // 初始化文本
    override func viewWillAppear(_ animated: Bool) {
        var strd:String = ""
        for i in 0..<arrRandomNum.count {
            let oneData = arrRandomNum[i]
            let strnum:String = String(oneData.num)
            
            if i == arrRandomNum.count - 1 {
                strd = strd + strnum
            }else {
                strd = strd + strnum + ", "
            }
        }
        logTextView.text = strd
        
        logTextView.inputAccessoryView = AddToolBar()
    }
    
    func AddToolBar() -> UIToolbar {
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        //        toolBar.tintColor = UIColor.blue
        toolBar.backgroundColor = UIColor.gray
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtn = UIBarButtonItem(title: NSLocalizedString("Copy", comment: ""), style: .plain, target: self, action: #selector(doneCopy))
        toolBar.items = [spaceBtn, barBtn]
        
        return toolBar
    }

    
    // textview 取消响应
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            doneCopy()
        }
        return true
    }
    
    
    func doneCopy() {
        let strd:String = logTextView.text!
        
        UIPasteboard.general.string = strd
        
        logTextView.resignFirstResponder()
        
        // 给提示
        if strd != "" {
            TipsSwift.showTopWithText(NSLocalizedString("CopyS", comment: ""))
        }
        
    }
}
