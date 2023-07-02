//
//  AddTextVC.swift
//  blur_View
//
//  Created by Abdusamad Mamasoliyev on 02/05/23.
//

import UIKit

class AddTextVC: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var desTV: UITextView!
    @IBOutlet weak var choosebtn: UIButton!
    
    var closure:((Task) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addBtn.layer.cornerRadius = 25
        choosebtn.layer.cornerRadius = 25
    }

    @IBAction func ColorBtn(_ sender: UIButton) {
        
        let vc = ButtonColor(nibName: "ButtonColor", bundle: nil)
       
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.closure = { color in
            self.choosebtn.backgroundColor = color
            

            
        }
        
        self.present(vc, animated: true)
    }
    
      @IBAction func addBtn(_ sender: Any) {
          
          
          let task = Task(title: titleTF.text ?? "Yangi vazifa",
                          description: desTV.text ?? "Malumot" ,
                          color: choosebtn.backgroundColor ?? UIColor.clear, viewColor: UIColor.systemGray6)
        
         
          
          if let closure {
              closure(task)
          }
          dismiss(animated: true)
    }
    
}
