import Foundation
import ZXingObjC

func zxingScanImage(_ image: UIImage, barcodeToFilter: BarcodeFormatType) -> String? {
    let source: ZXLuminanceSource = ZXCGImageLuminanceSource(cgImage: image.cgImage!)
    guard let bitmap = ZXBinaryBitmap(binarizer: ZXHybridBinarizer(source: source)),
          let hints = createZxingHintsFor(barcodeTypes: [barcodeToFilter]),
          let reader = ZXMultiFormatReader.reader() as? ZXMultiFormatReader,
          let result = try? reader.decode(bitmap, hints: hints) else {
        return nil
    }
    return result.text
}

private func mapBarcodeFormatTypeToZxingFormat(_ barcodeType: BarcodeFormatType) -> ZXBarcodeFormat?{
    switch barcodeType {
    case .UPCA:
        return kBarcodeFormatUPCA
    case .UPCE:
        return kBarcodeFormatUPCE
    case .EAN8:
        return kBarcodeFormatEan8
    case .EAN13:
        return kBarcodeFormatEan13
    case .code39:
        return kBarcodeFormatCode39
    case .code93:
        return kBarcodeFormatCode93
    case .code128:
        return kBarcodeFormatCode128
    case .codaBar:
        return kBarcodeFormatCodabar
    case .ITF:
        return kBarcodeFormatITF
    case .qrCode:
        return kBarcodeFormatQRCode
    case .dataMatrix:
        return kBarcodeFormatDataMatrix
    case .Aztec:
        return kBarcodeFormatAztec
    case .PDF417:
        return kBarcodeFormatPDF417
    case .all:
        return nil
    }
}

private func createZxingHintsFor(barcodeTypes: [BarcodeFormatType]) ->ZXDecodeHints?{
    let hints = ZXDecodeHints()
    for barcodeType in barcodeTypes{
        if(barcodeType == .all){
            return allFormatsZxingHints()
        }
        if let zxingFormat = mapBarcodeFormatTypeToZxingFormat(barcodeType) {
            hints.addPossibleFormat(zxingFormat)
        }

    }
    hints.tryHarder = true
    hints.pureBarcode = false
    return hints
}

private func allFormatsZxingHints() -> ZXDecodeHints {
    let hints = ZXDecodeHints()
    hints.addPossibleFormat(kBarcodeFormatCodabar)
    hints.addPossibleFormat(kBarcodeFormatQRCode)
    hints.addPossibleFormat(kBarcodeFormatMaxiCode)
    hints.addPossibleFormat(kBarcodeFormatDataMatrix)
    hints.addPossibleFormat(kBarcodeFormatITF)
    hints.addPossibleFormat(kBarcodeFormatEan8)
    hints.addPossibleFormat(kBarcodeFormatEan13)
    hints.addPossibleFormat(kBarcodeFormatCode128)
    hints.addPossibleFormat(kBarcodeFormatCode93)
    hints.addPossibleFormat(kBarcodeFormatCode39)
    hints.addPossibleFormat(kBarcodeFormatAztec)
    hints.addPossibleFormat(kBarcodeFormatUPCA)
    hints.addPossibleFormat(kBarcodeFormatUPCE)
    hints.tryHarder = true
    hints.pureBarcode = false
    return hints
}
