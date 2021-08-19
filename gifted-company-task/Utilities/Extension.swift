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

open class BaseView: UIView {
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    open func updateUIWithNewData(){}
    open func setAppSetting(){}
    
    private func doLoadThings(){
        backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doLoadThings()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
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

open class BaseCollectionViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    open var layout:UICollectionViewLayout = UICollectionViewFlowLayout()
    
    public var cellID:String = "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    public var cellDisplayViewBounds:CGRect{
        let topPadding = (navigationController?.navigationBar.frame.size.height ?? 0) + safeAreaEdgeInsets.top
        let bottomPadding = (tabBarController?.tabBar.frame.size.height ?? 0) + safeAreaEdgeInsets.bottom
        let mainSreenRect = UIScreen.main.bounds
        return CGRect.init(origin: .zero,
                           size: CGSize.init(width: mainSreenRect.width,
                                             height: mainSreenRect.height - topPadding - bottomPadding))
    }
    
    public var collectionView:UICollectionView!
    
    open override func createViews() {
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(collectionView)
        collectionView.activateLayouts(to: self.view)
    }
    
    dynamic open func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    
    dynamic open  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 0}
    dynamic open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {return UICollectionViewCell()}
    
    dynamic open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {return .zero}
    
    dynamic open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    dynamic open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {return UICollectionReusableView()}
    dynamic open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {return .zero}
    dynamic open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {return .zero}
    dynamic open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    dynamic open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {return .zero}
    
    dynamic open func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}
    dynamic open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    dynamic open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {}
    dynamic open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {}
}

open class BaseCollectionViewCell: UICollectionViewCell {
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    open func setAppSetting(){}
    
    private func doLoadThings(){
        backgroundColor = .white
        createViews()
        insertAndLayoutSubviews()
        config()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doLoadThings()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
}

open class BaseTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    public var cellID:String =  "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    public var tableview:UITableView!
    
    public var cellDisplayViewBounds:CGRect{
        let topPadding = (navigationController?.navigationBar.frame.size.height ?? 0) + safeAreaEdgeInsets.top
        let bottomPadding = (tabBarController?.tabBar.frame.size.height ?? 0) + safeAreaEdgeInsets.bottom
        let mainSreenRect = UIScreen.main.bounds
        return CGRect.init(origin: .zero,
                           size: CGSize.init(width: mainSreenRect.width,
                                             height: mainSreenRect.height - topPadding - bottomPadding))
    }
    
    open override func createViews() {
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(tableview)
        tableview.activateLayouts(to: self.view)
    }
    
    open override func config() {
        tableview.tableFooterView = UIView()
    }
    
    dynamic open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    dynamic open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 0}
    dynamic open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {return UITableViewCell()}
    
    dynamic open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {return nil}
    dynamic open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {0}
    
    dynamic open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension}
    
    dynamic open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    dynamic open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {0}
    
}

open class BaseTableViewCell: UITableViewCell {
    open func createViews(){}
    open func insertAndLayoutSubviews(){}
    open func config(){}
    
    open func setAppSetting(){}
    
    private func doLoadThings(){
        createViews()
        insertAndLayoutSubviews()
        backgroundColor = .white
        contentView.isUserInteractionEnabled = false
        config()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        doLoadThings()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doLoadThings()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setAppSetting()
    }
}
