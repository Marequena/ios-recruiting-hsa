//
//  NavigationView.swift
//  Movies
//
//  Created by Dani Riders on 3/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    
    @IBOutlet var ContainerView: UIView!
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var LeftButton: UIButton!
    @IBOutlet var RightButton: UIButton!
    
    var LeftCallBack : ((_ isSelect:Bool) -> Void)?
    var rightCallBack : ((_ isSelect:Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
        addSubview(self.ContainerView)
        self.ContainerView.backgroundColor = contsColor.yellow
        self.ContainerView.frame = self.bounds
        self.ContainerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        self.TitleLabel.textColor = contsColor.bluedark
        self.LeftButton.addTarget(self, action: #selector(actionLeft(_:)), for: .touchUpInside)
        self.RightButton.addTarget(self, action: #selector(actionRight(_:)), for: .touchUpInside)
        
    }
    @objc func actionLeft(_ sender : UIButton){
        self.LeftCallBack?(true)
    }
    
    @objc func actionRight(_ sender : UIButton){
        self.rightCallBack?(true)
    }
    
    func navTitle(title:String){
        self.TitleLabel.text = title
    }
    
    func leftButtonBack(state:Bool){
        var image:String = "back"
        if(!state){image = ""}
        self.LeftButton.setImage(UIImage(named: image),for:.normal)
    }
    
    
    func rightButtonFilter(state:Bool){
        var image:String = "FilterIcon"
        if(!state){image = ""}
        self.RightButton.setImage(UIImage(named: image),for:.normal)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
