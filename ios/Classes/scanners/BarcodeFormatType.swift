//
//  BarcodeFormatType.swift
//  barcode_finder
//
//  Created by Rafael Aquila on 25/12/20.
//

import Foundation
import MLKitBarcodeScanning

enum BarcodeFormatType {
    case all, code128, code39, code93, codaBar, dataMatrix, EAN13, EAN8, ITF, qrCode, UPCA, UPCE, PDF417, Aztec
    
    static func createBarcodeFormatTypeFromString(format: String) ->BarcodeFormatType{
        if format.isEmpty {
            return BarcodeFormatType.all
        }
        return barcodeFormatTypeFromString(format)
    }
    
    static private func barcodeFormatTypeFromString(_ name: String) -> BarcodeFormatType{
        switch name {
        case "UPC_A":
            return BarcodeFormatType.UPCA
        case "UPC_E":
            return BarcodeFormatType.UPCE
        case "EAN_8":
            return BarcodeFormatType.EAN8
        case "EAN_13":
            return BarcodeFormatType.EAN13
        case "CODE_39":
            return BarcodeFormatType.code39
        case "CODE_93":
            return BarcodeFormatType.code93
        case "CODE_128":
            return BarcodeFormatType.code128
        case "CODABAR":
            return BarcodeFormatType.codaBar
        case "ITF":
            return BarcodeFormatType.ITF
        case "QR_CODE":
            return BarcodeFormatType.qrCode
        case "DATA_MATRIX":
            return BarcodeFormatType.dataMatrix
        case "AZTEC":
            return BarcodeFormatType.Aztec
        case "PDF_417":
            return BarcodeFormatType.PDF417
        default:
            return BarcodeFormatType.all
        
        }
    }
    
    static func barcodeFromType(_ barcode: BarcodeFormatType) -> BarcodeFormat{
        switch barcode {
        case .UPCA:
            return BarcodeFormat.UPCA
        case .UPCE:
            return BarcodeFormat.UPCE
        case .EAN8:
            return BarcodeFormat.EAN8
        case . EAN13:
            return BarcodeFormat.EAN13
        case .code39:
            return BarcodeFormat.code39
        case .code93:
            return BarcodeFormat.code93
        case .code128:
            return BarcodeFormat.code128
        case .codaBar:
            return BarcodeFormat.codaBar
        case .ITF:
            return BarcodeFormat.ITF
        case .qrCode:
            return BarcodeFormat.qrCode
        case .dataMatrix:
            return BarcodeFormat.dataMatrix
        case .Aztec:
            return BarcodeFormat.aztec
        case .PDF417:
            return BarcodeFormat.PDF417
        default:
            return BarcodeFormat.all
        
        }
    }

}
