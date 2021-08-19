//
//  MainLoader.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import UIKit

class MainLoader: BaseView {
    private var activityIndicator: UIActivityIndicatorView!
    private var loadingLabel: UILabel!
    
    override func createViews() {
        activityIndicator = UIActivityIndicatorView.init(style: .white)
        
        loadingLabel = UILabel()
        loadingLabel.font = .body
        loadingLabel.textColor = .erieBlack
    }
    
    override func insertAndLayoutSubviews() {
        addSubview(activityIndicator)
        activityIndicator.activateLayouts([.centerX: 0, .centerY: 0])
        
        addSubview(loadingLabel)
        loadingLabel.activateLayouts([.leading: 20, .traling: -20, .centerY: 30])
    }
    
    override func config() {
        backgroundColor = .white
    }
}
