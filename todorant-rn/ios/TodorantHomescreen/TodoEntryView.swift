//
//  TodoEntryView.swift
//  TodorantWidget
//
//  Created by Yakov Karpov on 04.10.2020.
//  Copyright © 2020 Todomaster. All rights reserved.
//

import SwiftUI

struct TodoEntryView: View {
  let model: TodoWidgetContent

  var body: some View {
    VStack {
      if let title = model.title {
        VStack {
          Text(title)
            .widgetTitleStyle()
          Text(model.text)
            .widgetTextStyle()
          if let warning = model.warning {
            Text(warning)
              .widgetWarningTextModifier()
          }
        }
      } else if let currentProgress = model.currentProgress,
        let maximumProgress = model.maximumProgress
      {
        SegmentedProgressBarView(
          currentProgress: currentProgress,
          maximumProgress: maximumProgress
        )
        .widgetTopElementPadding()
        
        Text(model.text)
          .widgetTextStyle()
        
        if let warning = model.warning {
          Text(warning)
            .widgetWarningTextModifier()
        }
        
      } else {
      Text(model.text)
        .widgetTextStyle()
        .padding(.top)
      }
    }
  }
}



