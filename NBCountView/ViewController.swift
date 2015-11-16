//
//  ViewController.swift
//  NBCountView
//
//  Created by NapoleonBai on 15/9/20.
//  Copyright © 2015年 NapoleonBai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countView : NBCountView = NBCountView.init(frame: CGRectMake(50, 100, 200, 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        countView.isEditTextField = true
        self.view.addSubview(countView)
        countView.viewConfig = NBCountConfig(countViewShowType:.FilletButton,tintColor:UIColor.redColor())
        countView.currentValue = 20
        countView.notifyUpdateStepValue = {(updateStepValue : Int) in
            print("更改的数量为:\(updateStepValue)")
        }
        countView.notifyUpdateCurrentValue = {(currentValue : Int) in
            print("当前显示数值为:\(currentValue)")
        }
        
        let countView1 : NBCountView = NBCountView.init(frame: CGRectMake(50, 160, 120, 40))
        self.view.addSubview(countView1)
        
        countView1.viewConfig = NBCountConfig(countViewShowType:.CircleButton,tintColor:UIColor.greenColor())
        countView1.notifyUpdateStepValue = {(updateStepValue : Int) in
            print("更改的数量为:\(updateStepValue)")
        }
        countView1.notifyUpdateCurrentValue = {(currentValue : Int) in
            print("当前显示数值为:\(currentValue)")
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        countView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

