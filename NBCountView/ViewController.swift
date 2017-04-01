//
//  ViewController.swift
//  NBCountView
//
//  Created by NapoleonBai on 15/9/20.
//  Copyright © 2015年 NapoleonBai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countView : NBCountView = NBCountView.init(frame: CGRect(x: 50, y: 100, width: 200, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        countView.isEditTextField = true
        self.view.addSubview(countView)
        countView.viewConfig = NBCountConfig(countViewShowType:.filletButton,tintColor:UIColor.red)
        countView.currentValue = 20
        countView.notifyUpdateStepValue = {(updateStepValue : Int) in
            print("更改的数量为:\(updateStepValue)")
        }
        countView.notifyUpdateCurrentValue = {(currentValue : Int) in
            print("当前显示数值为:\(currentValue)")
        }
        
        let countView1 : NBCountView = NBCountView.init(frame: CGRect(x: 50, y: 160, width: 120, height: 40))
        self.view.addSubview(countView1)
        
        countView1.viewConfig = NBCountConfig(countViewShowType:.circleButton,tintColor:UIColor.green)
        countView1.notifyUpdateStepValue = {(updateStepValue : Int) in
            print("更改的数量为:\(updateStepValue)")
        }
        countView1.notifyUpdateCurrentValue = {(currentValue : Int) in
            print("当前显示数值为:\(currentValue)")
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        countView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

