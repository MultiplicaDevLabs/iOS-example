//
//  RepoUnfold.swift
//  Example
//
//  Created by Daniel Cabello on 3/23/18.
//  Copyright © 2018 Daniel Cabello. All rights reserved.
//

import UIKit

class RepoUnfold : UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositorySize: UILabel!
    @IBOutlet weak var repositoryLanguage: UILabel!
    @IBOutlet weak var repositoryUrl: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RepoUnfold", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    @IBAction func openLink(_ sender: Any) {
        
    }
}
