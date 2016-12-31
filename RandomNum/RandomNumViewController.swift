//
//  RandomNumViewController.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2016/12/31.
//  Copyright © 2016年 xigk. All rights reserved.
//

import UIKit

class RandomNumViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnTitle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
//        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as! ViewController
//        
//        self.present(mainViewController, animated: true) {
//        
//        }
        self.removeFromParentViewController()
    
//        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
