//
//  ComplicationController.swift
//  Todomaster-watchOS Extension
//
//  Created by Яков Карпов on 28.10.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
  var store = Store.shared
  
  // MARK: - Complication Descriptors Configuration

  func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
    let descriptors = [
      CLKComplicationDescriptor(
        identifier: "complication",
        displayName: "Todomaster",
        supportedFamilies: [
          CLKComplicationFamily.circularSmall,
          CLKComplicationFamily.graphicCircular,
          CLKComplicationFamily.graphicCorner,
          CLKComplicationFamily.graphicExtraLarge,
          CLKComplicationFamily.utilitarianSmall,
          CLKComplicationFamily.graphicRectangular
        ]
      ),
    ]
    handler(descriptors)
  }

  // MARK: - Timeline Population

  func getCurrentTimelineEntry(
    for complication: CLKComplication,
    withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void
  ) {
    if let template = getComplicationTemplate(for: complication, using: Date()) {
      let entry = CLKComplicationTimelineEntry(
        date: Date(),
        complicationTemplate: template
      )
      handler(entry)
    } else {
      handler(nil)
    }
  }

  // MARK: - Timeline Entries Configuration

  func getTimelineEntries(
    for _: CLKComplication,
    after _: Date,
    limit _: Int,
    withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void
  ) {
    handler(nil)
  }

  // MARK: - Templates Configuration

  func getComplicationTemplate(for complication: CLKComplication,
                               using _: Date, snapshot: Bool = false) -> CLKComplicationTemplate?
  {
    switch complication.family {
    
    case .graphicCircular:
      if snapshot {
        return CLKComplicationTemplateGraphicCircularView(GraphicCircularComplicationView(store: store, snapshot: true))
      }
      return CLKComplicationTemplateGraphicCircularView(GraphicCircularComplicationView(store: store))
      
    case .graphicRectangular:
      if snapshot {
        return CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangularComplicationView(store: store, snapshot: true))
      }
      return CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangularComplicationView(store: store))
    
    case .circularSmall:
      guard let image = UIImage(named: "Complication/Circular") else {
        fatalError("Unable to load an image")
      }
      let loadedImageProvider = CLKImageProvider(onePieceImage: image)
      return CLKComplicationTemplateCircularSmallSimpleImage(
        imageProvider: loadedImageProvider
      )
      
    case .graphicCorner:
      guard let image = UIImage(named: "Complication/Graphic Corner") else {
        fatalError("Unable to load an image")
      }
      let loadedImageProvider = CLKFullColorImageProvider(fullColorImage: image)
      return CLKComplicationTemplateGraphicCornerCircularImage(
        imageProvider: loadedImageProvider
      )
      
    case .graphicExtraLarge:
      guard let image = UIImage(named: "Complication/Graphic Extra Large") else {
        fatalError("Unable to load an image")
      }
      let loadedImageProvider = CLKFullColorImageProvider(fullColorImage: image)
      return CLKComplicationTemplateGraphicExtraLargeCircularImage(
        imageProvider: loadedImageProvider
      )
      
    case .utilitarianSmall:
      guard let image = UIImage(named: "Complication/Utilitarian") else {
        fatalError("Unable to load an image")
      }
      let loadedImageProvider = CLKImageProvider(onePieceImage: image)
      return CLKComplicationTemplateUtilitarianSmallSquare(
        imageProvider: loadedImageProvider
      )
      
    default:
      return nil
    }
  }
  
    // MARK: - Sample Templates

    func getLocalizableSampleTemplate(
      for complication: CLKComplication,
      withHandler handler: @escaping (CLKComplicationTemplate?) -> Void
    ) {
      let template = getComplicationTemplate(for: complication, using: Date(), snapshot: true)
      if let t = template {
        handler(t)
      } else {
        handler(nil)
      }
    }

  // MARK: - Privacy Configuration

  func getPrivacyBehavior(
    for _: CLKComplication,
    withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void
  ) { handler(.showOnLockScreen) }
  
}
