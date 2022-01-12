//
//  CircleButton.swift
//  MyCekikapeye
//
//  Created by Toto on 22/10/2021.
//

import UIKit

class CircleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }

    private func addCornerRadius(){
        self.layer.cornerRadius = bounds.height/2
    }
}
