//
//  PopOverDataModel.swift
//  demio
//
//  Created by fenrir-32 on 2018/3/12.
//  Copyright © 2018年 Dalian Fenrir. All rights reserved.
//

import Foundation

struct PopoverData: PopoverDataProtocol {
    var title: String
    var content: String
}

class PopoverDataClass: PopoverDataProtocol {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

protocol PopoverDataProtocol {
    var title: String { get set }
    var content: String { get set }
}
