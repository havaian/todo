//
//  String+Today.swift
//  Todomaster
//
//  Created by Dmitriy Karachentsov on 20/10/19.
//  Copyright © 2019 Todomaster. All rights reserved.
//

import Foundation

extension String {
  static var today: String {
    let date = Date()
    return DateFormatter
      .appDate
      .string(from: date)
  }
}
