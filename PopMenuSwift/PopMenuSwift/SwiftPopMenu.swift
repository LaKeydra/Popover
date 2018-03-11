//
//  SwiftPopMenu.swift
//  PopMenuSwift
//
//  Created by fenrir-32 on 2018/3/6.
//  Copyright © 2018年 fenrir-32. All rights reserved.
//
import UIKit

typealias didSelectMenuBlock = (IndexPath,PopoverDataProtocol) -> Void

class SwiftPopMenu: UIView {
    let ScreenW: CGFloat = UIScreen.main.bounds.size.width
    let ScreenH: CGFloat = UIScreen.main.bounds.size.height
    private var myFrame: CGRect!
    private var arrowView: UIView! = nil
    private var arrowViewWidth: CGFloat = 15
    private var arrowViewHeight: CGFloat = 8
    var arrowViewCenter: CGFloat = 0
    var cornorRadius: CGFloat = 5
    var popTextColor: UIColor = UIColor(red: 107 / 255.0, green: 107 / 255.0, blue: 107 / 255.0, alpha: 1.0)
    var popMenuBgColor: UIColor = UIColor.white
    var tableView: UITableView! = nil
    var orientation: UIInterfaceOrientation = .portraitUpsideDown
    var popMenuWidth: CGFloat = UIScreen.main.bounds.size.width / 3
    var popMenuHeight: CGFloat = UIScreen.main.bounds.size.height / 3
    var topOrBottomOriginX: CGFloat = UIScreen.main.bounds.size.width / 2 - UIScreen.main.bounds.size.width / 6
    var leftOrRightOriginY: CGFloat = UIScreen.main.bounds.size.height / 2 - UIScreen.main.bounds.size.height / 6
    var popMenuMarginBtn: CGFloat = 0
    var popData: [PopoverDataProtocol] = []
    var didSelectMenuBlock: didSelectMenuBlock?
    static let cellID: String = "SwiftPopMenuCellID"
    var rowHeightValue: CGFloat = 44
    var isShow: Bool = false
    var btnRect: CGRect = .zero
    
    init(popMenuBtn: UIView, datas: [PopoverDataProtocol], block: @escaping didSelectMenuBlock) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        btnRect = popMenuBtn.frame
        didSelectMenuBlock = block
        popData = datas
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    func show() {
        initViews()
        UIApplication.shared.keyWindow?.addSubview(self)
        self.isShow = true
    }
    
    func dismiss() {
        self.removeFromSuperview()
        self.isShow = false
    }
    
    func initViews() {
        var frame: CGRect = .zero
        var tableViewFrame: CGRect = .zero
        arrowView = UIView()
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        switch orientation {
        case .portraitUpsideDown:
            frame = CGRect(x: topOrBottomOriginX, y: btnRect.origin.y - popMenuHeight - popMenuMarginBtn, width: popMenuWidth, height: popMenuHeight)
            arrowViewCenter = btnRect.origin.x + btnRect.width / 2
            myFrame = frame
            tableViewFrame = CGRect(x: myFrame.origin.x,y: myFrame.origin.y,width: myFrame.width,height: myFrame.height - arrowViewHeight)
            tableView = UITableView(frame: tableViewFrame, style: .plain)
            arrowView.frame = CGRect(x: myFrame.origin.x, y: myFrame.origin.y + tableView.bounds.height, width: myFrame.width, height: arrowViewHeight)
            path.move(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x, y: arrowViewHeight))
            path.addLine(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x - arrowViewWidth / 2, y: 0))
            path.addLine(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x + arrowViewWidth / 2, y: 0))
            break;
        case .portrait:
            frame = CGRect(x: topOrBottomOriginX, y: btnRect.origin.y + btnRect.height + popMenuMarginBtn, width: popMenuWidth, height: popMenuHeight)
            arrowViewCenter = btnRect.origin.x + btnRect.width / 2
            myFrame = frame
            tableViewFrame = CGRect(x: myFrame.origin.x,y: myFrame.origin.y + arrowViewHeight, width: myFrame.width,height: myFrame.height - arrowViewHeight)
            tableView = UITableView(frame: tableViewFrame, style: .plain)
            arrowView.frame = CGRect(x: myFrame.origin.x, y: myFrame.origin.y, width: myFrame.width, height: arrowViewHeight)
            path.move(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x, y: 0))
            path.addLine(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x - arrowViewWidth / 2, y: arrowViewHeight))
            path.addLine(to: CGPoint(x: arrowViewCenter - arrowView.frame.origin.x + arrowViewWidth / 2, y: arrowViewHeight))
            break;
        case .landscapeLeft:
            frame = CGRect(x:btnRect.origin.x - popMenuWidth - popMenuMarginBtn , y: leftOrRightOriginY, width: popMenuWidth, height: popMenuHeight)
            arrowViewCenter = btnRect.origin.y + btnRect.height / 2
            myFrame = frame
            tableView = UITableView(frame: tableViewFrame, style: .plain)
            tableViewFrame = CGRect(x: myFrame.origin.x,y: myFrame.origin.y, width: myFrame.width - arrowViewHeight,height: myFrame.height)
            arrowView.frame = CGRect(x: myFrame.origin.x + tableViewFrame.width, y: myFrame.origin.y, width: arrowViewWidth, height: arrowViewHeight)
            path.move(to: CGPoint(x: arrowViewHeight, y: arrowViewCenter - arrowView.frame.origin.y))
            path.addLine(to: CGPoint(x: 0, y: arrowViewCenter - arrowView.frame.origin.y - arrowViewWidth / 2))
            path.addLine(to: CGPoint(x: 0, y: arrowViewCenter - arrowView.frame.origin.y + arrowViewWidth / 2))
            break;
        case .landscapeRight:
            frame = CGRect(x:btnRect.origin.x + btnRect.width + popMenuMarginBtn , y: leftOrRightOriginY, width: popMenuWidth, height: popMenuHeight)
            arrowViewCenter = btnRect.origin.y + btnRect.height / 2
            myFrame = frame
            tableViewFrame = CGRect(x: myFrame.origin.x + arrowViewHeight,y: myFrame.origin.y, width: myFrame.width - arrowViewHeight,height: myFrame.height)
            tableView = UITableView(frame: tableViewFrame, style: .plain)
            arrowView.frame = CGRect(x: myFrame.origin.x, y: myFrame.origin.y, width: arrowViewWidth, height: arrowViewHeight)
            path.move(to: CGPoint(x: 0, y: arrowViewCenter - arrowView.frame.origin.y))
            path.addLine(to: CGPoint(x: arrowViewHeight, y: arrowViewCenter - arrowView.frame.origin.y - arrowViewWidth / 2))
            path.addLine(to: CGPoint(x: arrowViewHeight, y: arrowViewCenter - arrowView.frame.origin.y + arrowViewWidth / 2))
            break;
        default:
            break
        }
        
        rowHeightValue = (self.myFrame.height - arrowViewHeight)/CGFloat(popData.count)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        tableView.register(SwiftPopMenuCell.classForCoder(), forCellReuseIdentifier: SwiftPopMenu.cellID)
        tableView.backgroundColor = popMenuBgColor
        tableView.layer.cornerRadius = cornorRadius
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.bounces = false
        UIView.animate(withDuration: 0.3) {
            self.addSubview(self.tableView)
        }
        
        layer.path = path.cgPath
        layer.fillColor = popMenuBgColor.cgColor
        arrowView.layer.addSublayer(layer)
        self.addSubview(arrowView)
    }
}


class SwiftPopMenuCell: UITableViewCell {
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(label)
        self.accessoryType = .checkmark
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCellUI(title: String,textColor: UIColor) {
        self.label.text = title
        label.textColor = textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = CGRect(x: 16, y: 0, width: self.bounds.size.width - 16, height: self.bounds.size.height)
    }
    
}

extension SwiftPopMenu : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if popData.count>indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: SwiftPopMenu.cellID) as! SwiftPopMenuCell
            let model = popData[indexPath.row]
            if indexPath.row == popData.count - 1 {
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width)
            }
            cell.refreshCellUI(title: model.title, textColor: popTextColor)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SwiftPopMenu : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeightValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if didSelectMenuBlock != nil {
            didSelectMenuBlock!(indexPath, popData[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if didSelectMenuBlock != nil {
            didSelectMenuBlock!(indexPath, popData[indexPath.row])
        }
    }
}
