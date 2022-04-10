//
//  GlobalVar.swift
//  nmBlock
//
//  Created by 林華淵 on 2022/3/28.
//

import Foundation
import UIKit

/// 取得裝置大小
let fullScreenSize = UIScreen.main.bounds.size

let statusBarHeight = UIApplication.shared.statusBarFrame.height

let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
