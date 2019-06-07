//
//  MainViewController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/4/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var hugeIconBackground: UIView?
    @IBOutlet weak var hugeIconLabel: UILabel?
    @IBOutlet weak var hugeIconLabelOverlay: UILabel?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        colorAnimations()
        addShadows()
        textField?.addBorderToTextField()
        self.hideKeyboardWhenTappedAround()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openHuge(sender:)))
        tap.delegate = self
        hugeIconBackground?.isUserInteractionEnabled = true
        hugeIconBackground?.addGestureRecognizer(tap)
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
    
    @objc func openHuge(sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: "https://www.hugeinc.com/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        controller.currencyAmount = Float(textField?.text ?? "10.0")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    

}

