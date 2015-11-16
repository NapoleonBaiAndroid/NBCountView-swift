//
//  NBCountView.swift
//  NBCountView
//
//  Created by NapoleonBai on 15/9/20.
//  Copyright © 2015年 NapoleonBai. All rights reserved.
//

import UIKit

enum NBCountViewShowType{
    /// 圆角按钮
    case FilletButton
    /// 圆形按钮
    case CircleButton
}

struct NBCountConfig {
    /// 设置私有属性显示样式
    private var mCountViewType : NBCountViewShowType = .FilletButton
    var countViewShowType : NBCountViewShowType{
        get{
            return mCountViewType
        }
        set(newShowType){
            self.mCountViewType = newShowType
        }
    }
    
    /// 设置私有属性TintColor
    private var mTintColor : UIColor = UIColor.greenColor()
    var tintColor : UIColor {
        get{
            return mTintColor
        }
        set(newTintColor){
            self.mTintColor = newTintColor
        }
    }
    init(){}
    /**
    增加带参数的构造方法
    
    - parameter countViewShowType: 显示样式
    - parameter borderColor:       borderColor
    
    - returns: 当前结构体实例
    */
    init(countViewShowType:NBCountViewShowType,tintColor:UIColor){
        self.countViewShowType = countViewShowType
        self.tintColor = tintColor
    }
}

class NBCountView : UIView ,UITextFieldDelegate{

    
    /// 设置默认的两个按钮以及输入框
    private var lessBtn : UIButton = UIButton.init(type:.Custom)
    private var addBtn : UIButton = UIButton.init(type:.Custom)
    private var countTextField : UITextField = UITextField.init()
    
    private var mViewConfig : NBCountConfig = NBCountConfig()
    /// 修改之前的值
    private var updateAgainValue = 0
    /// 当前显示值,缺省为0
    private var mCurrentValue : Int = 0
    /// 当前显示值,动态设置
    var currentValue : Int{
        get{
            return mCurrentValue
        }
        set(newCurrentValue){
            self.mCurrentValue = newCurrentValue
            self.updateAgainValue = self.mCurrentValue
            self.countTextField.text = "\(self.mCurrentValue)"
        }
    }
    
    /// 每次增加或改变多少,缺省为1
    var stepValue : Int = 1
    /// 是否可以手动编辑数值
    var isEditTextField : Bool = false
    
    var viewConfig : NBCountConfig{
        set(newConfig){
            self.mViewConfig = newConfig
            //更新相关配置属性
            updateConfig()
        }
        get{
            return self.mViewConfig
        }
    }

    /// 当前数值改变回调(得到当前显示的数量)
    var notifyUpdateCurrentValue : ((currentValue : Int) ->Void)!
    /// 当前数值改变时回调(得到的是每次更改的数量)
    var notifyUpdateStepValue : ((updateStepValue : Int) -> Void)!
    /**
    无参构造函数
    */
    convenience init(){
        //默认调用init frame
        self.init(frame: CGRectZero)
    }
    
    /**
    重新构造方法,创建View
    
    - parameter frame: 指定frame
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    /**
    从视图控制器中拖此控件,从这里加载
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildUI()
    }

    /**
    创建UI
    */
    func buildUI(){
        lessBtn = UIButton.init(type: UIButtonType.Custom)
        addBtn = UIButton.init(type: .Custom)
        countTextField = UITextField.init()
        
        lessBtn.setTitle("-", forState: .Normal)
        addBtn.setTitle("+", forState: .Normal)
        countTextField.text = "\(mCurrentValue)"
        updateAgainValue = mCurrentValue
        
        lessBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        addBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        countTextField.textAlignment = .Center
        countTextField.keyboardType = .NumberPad
        countTextField.delegate = self
        countTextField .addTarget(self, action:"textFieldValueChange:", forControlEvents: .EditingChanged)
        
        self.addSubview(lessBtn)
        self.addSubview(addBtn)
        self.addSubview(countTextField)
        
        lessBtn.addTarget(self, action:"onClickLessBtn:", forControlEvents:.TouchUpInside)
        addBtn.addTarget(self, action:"onClickAddBtn:", forControlEvents:.TouchUpInside)

        //self.updateConfig()
        addAutoLayoutContas()
    }
    
    func onClickLessBtn(lessBtn : UIButton){
        self.updateDisplayCurrentValue(-stepValue)
    }
    
    func onClickAddBtn(addBtn : UIButton){
        self.updateDisplayCurrentValue(stepValue)
    }
    
    func updateDisplayCurrentValue(updateStepCount : Int){
        countTextField.resignFirstResponder()
        //获取当前数值
        let currentValueInt = (countTextField.text! as NSString).integerValue
        //改变当前数值
        mCurrentValue = currentValueInt + updateStepCount
        //重新设置当前数值
        countTextField.text = "\(mCurrentValue)"
        /**
        回调,传入当前显示值
        - parameter currentValue: 当前显示数值
        */
        notifyUpdateCurrentValue?(currentValue:mCurrentValue)
        /**
        回调,传入当前更改的数量
        
        - parameter updateStepValue: 当前更改的数量
        */
        notifyUpdateStepValue?(updateStepValue:updateStepCount)
        self.updateAgainValue = self.mCurrentValue
    }

    
    /**
    设置相关属性
    */
    func updateConfig(){
        //如果这是第一种类型,也就是圆角按钮,设置边框的那种
        if mViewConfig.countViewShowType == NBCountViewShowType.FilletButton {
            self.layer.borderColor = mViewConfig.mTintColor.CGColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
            
            self.lessBtn.layer.borderColor = mViewConfig.mTintColor.CGColor
            self.addBtn.layer.borderColor = mViewConfig.mTintColor.CGColor
            self.lessBtn.layer.borderWidth = 1
            self.addBtn.layer.borderWidth = 1
            
            self.lessBtn.setTitleColor(mViewConfig.mTintColor, forState:.Normal)
            self.addBtn.setTitleColor(mViewConfig.mTintColor, forState:.Normal)
        }else{
            //这是第二种类型,设置圆形按钮
            self.lessBtn.layer.masksToBounds = true
            self.addBtn.layer.masksToBounds = true
            self.lessBtn.layer.cornerRadius = self.frame.size.height / 2.0
            self.addBtn.layer.cornerRadius = self.frame.size.height / 2.0
            
            self.lessBtn.backgroundColor = mViewConfig.mTintColor
            self.addBtn.backgroundColor = mViewConfig.mTintColor
            
            self.lessBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.addBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
    }
    
    
    /**
    添加约束
    */
    func addAutoLayoutContas(){
        lessBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        countTextField.translatesAutoresizingMaskIntoConstraints = false
        let viewDicts = dictForViews([lessBtn,countTextField,addBtn])
        
        //设置水平布局,间距5,两个按钮宽度相等
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[lessBtn]-5-[countTextField]-5-[addBtn(lessBtn)]|", options:.DirectionLeadingToTrailing, metrics: nil, views: viewDicts))
        //设置按钮高度
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lessBtn]|", options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewDicts))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[countTextField]|", options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewDicts))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[addBtn]|", options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewDicts))
        
        //设置按钮宽高相等
        self.addConstraint(NSLayoutConstraint.init(item:lessBtn, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: lessBtn, attribute:NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
    }
    
    /**
    自定义生成键值对dicationary
    - parameter objecs: 数组对象 eg:[1,2,3]
    - returns: 键值对对象 eg:["1":1,"2":2,"3":3]
    */
    func dictForViews(objecs:[AnyObject]) -> [String : AnyObject] {
        var count:UInt32 = 0
        var dicts:[String : AnyObject] = [:]
        let ivars = class_copyIvarList(self.classForCoder, &count)
        for var i = 0; i < Int(count); ++i{
            let obj = object_getIvar(self, ivars[i])
            let name = String.fromCString(ivar_getName(ivars[i]))!
            dicts[name] = obj
            if dicts.count == objecs.count{
                break
            }
        }
        free(ivars)
        return dicts
    }
    /**
    UItextField delegate method
    
    - parameter textField: 就是界面显示当前值的textfield
    
    - returns: 当前textfield是否能编辑,true为可编辑,false为不可编辑
    */
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
        return isEditTextField
    }
    /**
    countTextField获取焦点是执行
    
    - parameter textField: <#textField description#>
    */
    func textFieldDidBeginEditing(textField: UITextField){
        //如果开始输入时,为0,就去掉0
        let changedValue = (textField.text! as NSString).integerValue
        if changedValue == 0{
            textField.text = ""
        }
    }
    /**
    countTextField 失去焦点时执行
    
    - parameter textField: <#textField description#>
    */
    func textFieldDidEndEditing(textField: UITextField){
        //如果结束时没有任何输入,就置为0
        if textField.text!.isEmpty{
            textField.text = "0"
        }
    }
    
    
    func textFieldValueChange(textField : UITextField){
        let changedValue = (textField.text! as NSString).integerValue
        let changedStep = changedValue - self.updateAgainValue
        self.mCurrentValue = changedValue
        self.updateAgainValue = self.mCurrentValue
        /**
        回调,传入当前显示值
        - parameter currentValue: 当前显示数值
        */
        notifyUpdateCurrentValue?(currentValue:mCurrentValue)
        /**
        回调,传入当前更改的数量
        
        - parameter updateStepValue: 当前更改的数量
        */
        notifyUpdateStepValue?(updateStepValue:changedStep)

    }
    
    /**
    移除焦点事件
    */
    override func resignFirstResponder() -> Bool {
        countTextField.resignFirstResponder()
        return true
    }

}
