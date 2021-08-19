//
//  Extension.swift
//  gifted-company-task
//
//  Created by Thathsara Senarathne on 2021-08-16.
//

import Foundation
import UIKit

//-------------------------------------------//
//UIView Extenstions
//-------------------------------------------//
public extension UIView{
    ///Root view of the current view
    var rootView: UIView? {
        var root: UIView? = self
        while root?.superview != nil {
            root = root?.superview
        }
        return root
    }
    
    enum LayoutKeys {
        case top
        case leading
        case traling
        case bottom
        case centerX
        case centerY
        case height
        case width
    }
    
    func activeShadow(using color:UIColor,opacity:Float = 0.1,shadowRadius:CGFloat = 8,_ offSet:CGSize = CGSize(width: 0, height: 1)){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    
    func addCornerRadius(){
        self.layer.cornerRadius = self.bounds.size.width * 0.03
        self.clipsToBounds = true
    }
    
    func addCornerRadius(to corners:UIRectCorner,_ radius:CGFloat){
        
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: radius, height:  radius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    
    //UIView layout extensions
    func activateLayouts(equalConstant value:CGFloat = 0,to view:UIView? = nil,_ isSafeAreaActivate:Bool = false){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var parentView:UIView!
        
        if view == nil{
            parentView = self.superview
        }else{
            parentView = view
        }
        
        guard parentView != nil else{
            fatalError("First add \(self.description) to view hirachy before layout")
        }
        
        NSLayoutConstraint.activate([self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor,
                                                                   constant: value),
                                     self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor,
                                                                    constant: -value),
                                     self.topAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor,
                                                               constant: value),
                                     self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor,
                                                                  constant: -value)])
    }
    
    func activateLayouts(to parentView:UIView? = nil,_ layouts:[LayoutKeys:CGFloat],_ isSafeAreaActivate:Bool = false){
        for val in layouts{
            activateLayout(to: parentView, val.key, val.value,isSafeAreaActivate)
        }
    }
    
    func activateLayouts(to layoutsConfig:[UIView:[LayoutKeys:CGFloat]],_ isSafeAreaActivate:Bool = false){
        for config in layoutsConfig{
            for layout in config.value{
                activateLayout(to: config.key, layout.key, layout.value,isSafeAreaActivate)
            }
        }
    }
    
    func activateLayout(to view:UIView?,_ layoutKey:LayoutKeys,_ constant:CGFloat,_ isSafeAreaActivate:Bool = false){
        
        var parentView:UIView!
        
        if view == nil{
            parentView = self.superview
        }else{
            parentView = view
        }
        
        guard parentView != nil else{
            fatalError("First add \(self.description) to view hirachy before layout")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch layoutKey{
        case .traling:
            self.trailingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor,
                                           constant: constant).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor,
                                          constant: constant).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor,
                                      constant:constant).isActive = true
        case .centerY:
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: constant).isActive = true
        case .centerX:
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant:constant).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: isSafeAreaActivate ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor,
                                         constant:constant).isActive = true
        case .height:
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
        
    }
    
    ///Add borders to specific corners
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.tag = 3002
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
    
    func removeViewBorders() {
        self.subviews.filter{ $0.tag == 3002 }.forEach {
            $0.removeFromSuperview()
        }
    }

    ///Inser gradient layer to view
    func insertGradientLayer(top topColor: UIColor, bottom bottomColor: UIColor) {
        let layer = CAGradientLayer()
        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.locations = [0.0,1.0]
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
    }
    
    ///Remove all constraint
    func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
}

open class BaseViewController: UIViewController {
    
    public enum RepeatState {
        case once, always
    }
    
    open var fetchingState: RepeatState {
        .once
    }
    
    public private(set)var isDisplayOnce = false
    
    public var safeAreaEdgeInsets:UIEdgeInsets{
        guard let window = UIApplication.shared.windows.first else{return .zero}
        return window.safeAreaInsets
    }
    
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func fetchData(){}
    open func updateUIWithNewData(){}
    open func config(){}
    ///Call on viewWill Appear. Single exicution in UIViewController life cycle.
    open func setAppSetting(){}
    
    private func doLoadThings(){
        view.backgroundColor = .white
        config()
    }
    
    open override func loadView() {
        super.loadView()
        createViews()
        insertAndLayoutSubviews()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        doLoadThings()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch fetchingState {
        case .once:
            guard !isDisplayOnce else { return }
            fetchData()
            
        case .always:
            fetchData()
        }
        
        if !isDisplayOnce {
            setAppSetting()
        }
        
        isDisplayOnce = true
    }
}
