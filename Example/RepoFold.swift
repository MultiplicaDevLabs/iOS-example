//
//  RepoFold.swift
//  Example
//
//  Created by Daniel Cabello on 3/23/18.
//  Copyright © 2018 Daniel Cabello. All rights reserved.
//

import UIKit
class RepoFold : UIView{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RepoFold", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}
