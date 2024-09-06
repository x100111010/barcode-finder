//
//  GetBarcodeFromImage.swift
//  barcode_finder
//
//  Created by Rafael Aquila on 25/12/20.
//

import Foundation
import MLKitBarcodeScanning
import MLKitVision
import ZXingObjC

func getBarcodeFromImage(uiImage: UIImage, barcodeToFilter: BarcodeFormatType = BarcodeFormatType.all) -> String?{
    let scanners = [scanMlKit, scanZXing, scanZBar]
    for scanner in scanners{
        if let barcodeFound = scanner(uiImage, barcodeToFilter){
            return barcodeFound
        }
    }
    return nil
}

private func scanMlKit(_ image: UIImage, barcodeToFilter: BarcodeFormatType) ->String?{
    let format = BarcodeFormatType.barcodeFromType(barcodeToFilter)
    let barcodeOptions = BarcodeScannerOptions(formats: format)
    let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)

    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation
    
    var code: String?
    barcodeScanner.process(visionImage){features, error in
          guard error == nil, let features = features, !features.isEmpty else {
             return
          }
        for barcode in features {
            if (barcode.rawValue != nil){
                code = barcode.rawValue
            }
        }
    }
    if(code != nil){
        return code
    }
    return nil
}

private func scanZXing(_ image: UIImage, barcodeToFilter: BarcodeFormatType) ->String?{
    let result: String? = zxingScanImage(image, barcodeToFilter: barcodeToFilter)
    if let barcode = result{
        if(!barcode.isEmpty){
            return barcode
        }
    }
    return nil
}

private func scanZBar(_ image: UIImage, barcodeToFilter: BarcodeFormatType) ->String?{
    let result: String? = zbarScanImage(image, barcodeToFilter: [barcodeToFilter])
    if let barcode = result{
        if(!barcode.isEmpty){
            return barcode
        }
    }
    return nil
}
