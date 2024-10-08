import Flutter
import UIKit

public class SwiftBarcodeFinderPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "popcode.com.br/barcode_finder", binaryMessenger: registrar.messenger())
        let instance = SwiftBarcodeFinderPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "scan_pdf") {
            guard let args = call.arguments else {
                result(FlutterError(code: "no-arguments", message: "No arguments provided", details: nil))
                return
            }
            if let myArgs = args as? [String: Any]{
                let filePath = myArgs["filePath"] as! String
                let barcodeFormat = myArgs["barcodeFormat"] as? String
                let url = URL(fileURLWithPath: filePath)
                let scanner = BarcodeFinder()
                
                DispatchQueue.global().async {
                    let pdfImages = url.pdfPagesToImages()
                    DispatchQueue.main.async {
                        if pdfImages == nil{
                            result(FlutterError(code: "not-found" , message: "Pdf not found", details: nil))
                            return
                        }
                        let barcodeToFilter = BarcodeFormatType.createBarcodeFormatTypeFromString(format: barcodeFormat!)
                        for uiImage in pdfImages ?? [UIImage](){                       
                            if let barcode =  scanner.tryFindBarcodeFrom(uiImage: uiImage, barcodeToFilter: barcodeToFilter){
                                result(barcode)
                                return;
                            }
                        }
                        
                        result(FlutterError(code: "not-found" , message: "No barcode found on the file", details: nil))
                        return
                    }
                }        
            } else {
                result(FlutterError(code: "no-arguments", message: "No arguments provided", details: nil))
                return
            }
        }
        if(call.method == "scan_image") {
            guard let args = call.arguments else {
                result(FlutterMethodNotImplemented)
                return
            }
            if let myArgs = args as? [String: Any]{
                let filePath = myArgs["filePath"] as! String
                let barcodeFormat = myArgs["barcodeFormat"] as? String
                let url = URL(fileURLWithPath: filePath)
                let scanner = BarcodeFinder()
                let uiImage = UIImage.init(contentsOfFile: url.path)
                if uiImage == nil{
                    result(FlutterError(code: "not-found" , message: "Image not found", details: nil))
                    return
                }
                let image = grayscale(image: uiImage!)
                if image == nil{
                    result(FlutterError(code: "not-found" , message: "The image cannot be treated", details: nil))
                    return
                }
                let barcodeToFilter = BarcodeFormatType.createBarcodeFormatTypeFromString(format: barcodeFormat!)
                if let barcode =  scanner.tryFindBarcodeFrom(uiImage: image!, barcodeToFilter: barcodeToFilter){
                    result(barcode)
                    return;
                }
                result(FlutterError(code: "not-found" , message: "No barcode found on the file", details: nil))
                return
            } else {
                result(FlutterError(code: "no-arguments", message: "No arguments provided", details: nil))

            }
        }
    }
    
    func grayscale(image: UIImage) -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectMono") {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}
