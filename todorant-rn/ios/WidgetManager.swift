//
//  WidgetManager.swift
//  Todomaster
//
//  Created by Nikita Kolmogorov on 2020-10-05.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import WidgetKit

@objc(WidgetManager)
class WidgetManager: NSObject {

  @objc
  func refresh() -> Void {
    if #available(iOS 14.0, *) {
      WidgetCenter.shared.reloadTimelines(ofKind: "TodorantWidget")
    }
  }
}
