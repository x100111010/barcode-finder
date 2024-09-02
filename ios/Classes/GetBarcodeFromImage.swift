//
//  GetBarcodeFromImage.swift
//  barcode_finder
//
//  Created by Rafael Aquila on 25/12/20.
//

import Foundation
import MLKitBarcodeScanning
import MLKitVision

func getBarcodeFromImage(uiImage: UIImage, barcodesToFilter: BarcodeFormat = [BarcodeFormat.all]) -> String?{
    let scanners = [scanMlKit]
    for scanner in scanners{
        if let barcodeFound = scanner(uiImage, barcodesToFilter){
            return barcodeFound
        }
    }
    return nil
}

private func scanMlKit(_ image: UIImage, barcodesToFilter: BarcodeFormat) ->String?{
    let barcodeOptions = BarcodeScannerOptions(formats: [barcodesToFilter])
    let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)

    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation
    
    var code: String?
    barcodeScanner.process(visionImage){features, error in
          guard error == nil, let features = features, !features.isEmpty else {
             return
          }
        code = features[0].rawValue
    }
    return code
}
