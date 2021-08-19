//
//  UIFont+Extention.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-19.
//

import Foundation
import UIKit

extension UIFont {
    
    ///Size :- 17 , Weight:- medium
    class var title:UIFont {
        return .systemFont(ofSize: 17, weight: .medium)
    }
    
    ///Size :- 16 , Weight:- regular
    class var subTitle:UIFont {
        return .systemFont(ofSize: 16)
    }
    
    ///Size :- 15 , Weight:- medium
    class var heading:UIFont {
        return .systemFont(ofSize: 15, weight: .medium)
    }
    
    ///Size :- 15 , Weight:- regular
    class var lightHeading: UIFont {
        .systemFont(ofSize: 15, weight: .regular)
    }
    
    ///Size :- 14 , Weight:- semibold
    class var subHeading: UIFont {
        return .systemFont(ofSize: 14, weight: .semibold)
    }
    
    ///Size :- 14 , Weight:- regular
    class var body: UIFont {
        return .systemFont(ofSize: 14)
    }
    
    
    ///Size :- 20 , Weight:- medium
    class var jumbo: UIFont {
        return .systemFont(ofSize: 20, weight: .medium)
    }

    ///Size :- 18 , Weight:- regular
    class var huge: UIFont {
        return .systemFont(ofSize: 18)
    }
    
    ///Size :- 22 , Weight:- regular
    class var tabBarButtonTitle : UIFont {
        return .systemFont(ofSize: 22)
    }
    
    ///Size :- 13 , Weight:- regular
    class var smallText: UIFont {
        return .systemFont(ofSize: 13)
    }
    
    ///Size :- 12 , Weight:- regular
    class var extraSmallText: UIFont {
        return .systemFont(ofSize: 12)
    }
    
    ///Size :- 28, Weight:- semibold
    class var largeTitle: UIFont {
        return .systemFont(ofSize: 28, weight: .semibold)
    }
    
    ///Size :- 13 , Weight:- semibold
    class var extraSmallSemiBoldText: UIFont {
        return .systemFont(ofSize: 10, weight: .semibold)
    }
    
//    title - Size :- 20 , Weight:- medium
//    subTitle - systemFont(ofSize: 18)
//     heading - Size :- 16 , Weight:- medium
//   subHeading - Size :- 15 , Weight:- medium
//   body - .systemFont(ofSize: 14)
}
