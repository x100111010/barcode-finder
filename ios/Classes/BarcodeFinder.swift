//
//  PDFtoBarcodeConversor.swift
//  iosbarcodefrompdf
//
//  Created by Rafael Aquila on 01/12/20.
//

import Foundation
import MLKitBarcodeScanning

class BarcodeFinder {
    
    var image: UIImage?
    var barcodeToFilter: BarcodeFormatType?
    func tryFindBarcodeFrom(uiImage: UIImage, barcodeToFilter: BarcodeFormatType = BarcodeFormatType.all) -> String?{
        self.image = uiImage
        self.barcodeToFilter = barcodeToFilter
        let barcode = getBarcodeFromImage(uiImage: uiImage, barcodeToFilter: barcodeToFilter)
        return barcode
    }
}
