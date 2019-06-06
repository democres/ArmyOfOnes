//
//  MainViewController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/4/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hugeIconBackground: UIView?
    @IBOutlet weak var hugeIconLabel: UILabel?
    @IBOutlet weak var hugeIconLabelOverlay: UILabel?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        colorAnimations()
        addBorderToTextView()
        addShadows()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func addShadows(){
        
        button?.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button?.layer.shadowOpacity = 1.0
        button?.layer.shadowRadius = 3.0
        button?.layer.masksToBounds = false
        button?.layer.cornerRadius = 4.0
        
        hugeIconBackground?.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        hugeIconBackground?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        hugeIconBackground?.layer.shadowOpacity = 1.0
        hugeIconBackground?.layer.shadowRadius = 3.0
        hugeIconBackground?.layer.masksToBounds = false
        hugeIconBackground?.layer.cornerRadius = 4.0
    }

    func addBorderToTextView() {
        guard let textField = textField else { return }
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    
    func colorAnimations(){
        
        //Background
        UIView.animate(withDuration: 8, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.allowUserInteraction], animations: {
            
            self.view.backgroundColor = hexToUIColor(hex: "#ec008c") //MAGENTA
            self.view.backgroundColor = hexToUIColor(hex: "#808080") //GRAY
            
        }, completion: nil)
        
        //Label
        UIView.animate(withDuration: 0.8, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.allowUserInteraction], animations: {
            
            self.hugeIconLabel?.alpha = 0
            self.hugeIconLabelOverlay?.alpha = 1
            
        }, completion: nil)
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        print("A")
    }
    
    //MARK: TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    

}

