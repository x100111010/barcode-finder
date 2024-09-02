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
    var barcodeToFilter: BarcodeFormat?
    func tryFindBarcodeFrom(uiImage: UIImage, barcodeToFilter: BarcodeFormat = BarcodeFormat.all) -> String?{
        self.image = uiImage
        self.barcodeToFilter = barcodeToFilter
        let rotationAttemptResult = tryRotateImage(uiImage)
        return rotationAttemptResult
        
    }
    
    private func tryRotateImage(_ uiImage: UIImage) -> String?{
        let attemptList = createAttemptList()
        for attempFunction in attemptList{
            if let barcode = attempFunction(uiImage){
                if(!barcode.isEmpty){
                    return barcode
                }
            }
        }
        return nil;
    }
    
    private func createAttemptList() -> Array<((UIImage) ->String?)> {
        var attemptTransformList = Array<((UIImage) ->String?)>()
        attemptTransformList.append(decodeUnmodifiedImage)
        attemptTransformList.append(decodeRotated90DegreesImage)
        attemptTransformList.append(decodeRotated90DegreesImage)
        attemptTransformList.append(decodeRotated90DegreesImage)
        attemptTransformList.append(decodeCroppedPdf)
        
        return attemptTransformList
    }
    
    private func decodeRotated90DegreesImage(uiImage: UIImage) ->String?{
        let rotated = uiImage.rotate(radians: .pi/2)
        self.image = rotated
        return getBarcodeFromImage(uiImage: uiImage, barcodesToFilter: self.barcodeToFilter!)
    }
    
    private func decodeUnmodifiedImage(uiImage: UIImage) ->String?{
        return getBarcodeFromImage(uiImage: uiImage, barcodesToFilter: self.barcodeToFilter!)
        
    }
    
    private func decodeCroppedPdf(uiImage: UIImage) ->String?{
        let cropped = uiImage.cropHalf()
        return getBarcodeFromImage(uiImage: cropped, barcodesToFilter: self.barcodeToFilter!)
        
    }
    
}

