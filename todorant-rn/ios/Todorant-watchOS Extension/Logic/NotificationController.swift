//
//  NotificationController.swift
//  Todomaster-watchOS Extension
//
//  Created by Яков Карпов on 28.10.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import SwiftUI
import UserNotifications
import WatchKit

class NotificationController: WKUserNotificationHostingController<NotificationView> {
  override var body: NotificationView {
    return NotificationView()
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

  override func didReceive(_: UNNotification) {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
  }
}
