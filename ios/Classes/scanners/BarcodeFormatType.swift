//
//  BarcodeFormatType.swift
//  barcode_finder
//
//  Created by Rafael Aquila on 25/12/20.
//

import Foundation
import MLKitBarcodeScanning

enum BarcodeFormatType {
    case all, code128, code39, code93, codaBar, dataMatrix, EAN13, EAN8, ITF, qrCode, UPCA, UPCE
                , PDF417, Aztec
    
    static func createBarcodeFormatTypeFromString(format: String) ->BarcodeFormat{
        if format.isEmpty {
            return BarcodeFormat.all
        }
        return barcodeFormatTypeFromString(format)
    }
    
    static private func barcodeFormatTypeFromString(_ name: String) -> BarcodeFormat{
        switch name {
        case "UPC_A":
            return BarcodeFormat.UPCA
        case "UPC_E":
            return BarcodeFormat.UPCE
        case "EAN_8":
            return BarcodeFormat.EAN8
        case "EAN_13":
            return BarcodeFormat.EAN13
        case "CODE_39":
            return BarcodeFormat.code39
        case "CODE_93":
            return BarcodeFormat.code93
        case "CODE_128":
            return BarcodeFormat.code128
        case "CODABAR":
            return BarcodeFormat.codaBar
        case "ITF":
            return BarcodeFormat.ITF
        case "QR_CODE":
            return BarcodeFormat.qrCode
        case "DATA_MATRIX":
            return BarcodeFormat.dataMatrix
        case "AZTEC":
            return BarcodeFormat.aztec
        case "PDF_417":
            return BarcodeFormat.PDF417
        default:
            return BarcodeFormat.all
        
        }
    }

}
