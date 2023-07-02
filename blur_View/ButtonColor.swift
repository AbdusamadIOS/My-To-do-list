//
//  ButtonColor.swift
//  blur_View
//
//  Created by Abdusamad Mamasoliyev on 02/05/23.
//

import UIKit

class ButtonColor: UIViewController {

    @IBOutlet weak var HighBtn: UIButton!
    @IBOutlet weak var MediumBtn: UIButton!
    @IBOutlet weak var NoneBtn: UIButton!
    @IBOutlet weak var LowBtn: UIButton!
    
    var closure: ((UIColor) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        buttonRadius()
        
    }
    
    func buttonRadius() {
       
        HighBtn.layer.cornerRadius = 25
        MediumBtn.layer.cornerRadius = 25
        NoneBtn.layer.cornerRadius = 25
        LowBtn.layer.cornerRadius = 25
        
    }
   
    @IBAction func ColorBtns(_ sender: UIButton) {
        
        let  color = sender.backgroundColor ?? UIColor.clear
        
        if let closure {
            closure(color)
        }
        dismiss(animated: true )
    }
    
}
