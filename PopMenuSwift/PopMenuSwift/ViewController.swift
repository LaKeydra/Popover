//
//  ViewController.swift
//  PopMenuSwift
//
//  Created by fenrir-32 on 2018/3/6.
//  Copyright © 2018年 fenrir-32. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var popMenu: SwiftPopMenu!
    
    @IBOutlet weak var popMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.refreshPopoverUI()
    }
    
    func refreshPopoverUI() {
        if (popMenu != nil && popMenu.isShow) {
            popMenu.dismiss()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3){
                self.showMenu()
            }
        }
    }
    
    func showMenu() {
        popMenu = SwiftPopMenu(popMenuBtn: popMenuBtn, popMenuWidth: 300, popMenuHeight: 200, topOrBottomOriginX: UIScreen.main.bounds.size.width - 10 - 300)
        popMenu.popData = [
            PopoverData(title: "扫一扫", content: ""),
            PopoverData(title: "签到规则", content: ""),
            PopoverData(title: "扫一扫", content: ""),
            PopoverData(title: "签到规则", content: "")
        ]
        
        popMenu.didSelectMenuBlock = { [weak self] indexPath,data in
            print("block selected section = \(indexPath.section) row = \(indexPath.row) data = \(data)")
        }
        popMenu.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popMenuAction(_ sender: Any) {
        showMenu()
    }
    
}
