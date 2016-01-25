//
//  ViewController.swift
//  TipCalc
//
//  Created by Ben Wilkins on 1/19/16.
//  Copyright © 2016 This is After. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var billAmount: Double = 100.00
    var tipPercentage: Double = 20.00
    
    @IBOutlet var inputsView: UIView!
    @IBOutlet var totalView: UIView!
    @IBOutlet var billInput: UITextField!
    @IBOutlet var tipInput: UITextField!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var dragIconImage: UIImageView!
    
    @IBAction func onBillAmountChanged(sender: AnyObject) {
        if let billInputAmount = Double(billInput.text!) {
            billAmount = billInputAmount
        } else {
            billAmount = 100
        }
        calculateTip()
    }
    @IBAction func onTipPercentChanged(sender: AnyObject) {
        if let tipInputAmount = Double(tipInput.text!) {
            tipPercentage = tipInputAmount
        } else {
            tipPercentage = 20.00
        }
        calculateTip()
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onScrub(sender: AnyObject) {
        let velocity = Double(sender.velocityInView(self.view).x)
        let incrementer = velocity / 1000
        
        if round(tipPercentage + incrementer) >= 0 {
            tipPercentage += Double(incrementer)
            tipInput.text = String(format: "%.00f", abs(round(tipPercentage)))
            calculateTip()
        }
    }
    
    func calculateTip() {
        var totalAmount: Double
        if billInput.text != "" {
            totalAmount = billAmount + (billAmount * (round(tipPercentage) / 100))
            totalLabel.text = String(format: "%.02f", totalAmount)
        } else {
            totalLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calculateTip()
        let translate = CGAffineTransformMakeTranslation(0, -198)
        inputsView.transform = translate
        totalView.alpha = 0
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.inputsView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: {(value: Bool) in
            self.billInput.becomeFirstResponder()
        })
        
        UIView.animateWithDuration(0.5, delay: 2.0, options: [], animations: {
            self.totalView.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            let transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.dragIconImage.transform = transform
            }, completion: nil)
    }
}

