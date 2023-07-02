//
//  MainVCCell.swift
//  blur_View
//
//  Created by Abdusamad Mamasoliyev on 02/05/23.
//

import UIKit

class MainVCCell: UITableViewCell {

  
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cellColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        cellColor.layer.cornerRadius = 20
       
        
    }
    
}
