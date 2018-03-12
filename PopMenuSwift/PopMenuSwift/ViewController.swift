//
//  ViewController.swift
//  PopMenuSwift
//
//  Created by fenrir-32 on 2018/3/6.
//  Copyright © 2018年 fenrir-32. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var popMenu: PopOverView!
    
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
        let data: [PopoverDataProtocol] = [
            PopoverData(title: "扫一扫", content: ""),
            PopoverDataClass(title: "签到规则", content: ""),
            PopoverDataClass(title: "扫一扫", content: ""),
            PopoverData(title: "签到规则", content: "")
        ]
        
        let block: DidSelectedBlock = { [weak self] indexPath,data in
            print("block selected section = \(indexPath.section) row = \(indexPath.row) title = \(data.title) content = \(data.content)")
        }
        
        popMenu = PopOverView(popMenuBtn: popMenuBtn, datas: data, block: block)
        popMenu.popMenuWidth = 300
        popMenu.topOrBottomOriginX = UIScreen.main.bounds.size.width - 10 - 300
        popMenu.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popMenuAction(_ sender: Any) {
        showMenu()
    }
    
}


