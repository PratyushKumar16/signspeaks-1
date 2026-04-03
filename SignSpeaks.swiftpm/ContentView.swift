import SwiftUI
import Vision
import CoreML
@preconcurrency import AVFoundation

struct ContentView: View {
    @State private var statusText: String = "Initializing AI..."
    
    var body: some View {
        ZStack {
            CameraView(statusText: $statusText)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text(statusText)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(BlurView(style: .systemThinMaterialDark))
                    .cornerRadius(25)
                    .padding(.bottom, 60)
            }
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var statusText: String
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    class Coordinator: NSObject, PredictionDelegate {
        var parent: CameraView
        init(_ parent: CameraView) { self.parent = parent }
        
        func didUpdate(_ text: String) {
            DispatchQueue.main.async { self.parent.statusText = text }
        }
    }
}

protocol PredictionDelegate: AnyObject {
    func didUpdate(_ text: String)
}

class VideoCaptureDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, @unchecked Sendable {
    weak var parentController: CameraViewController?
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        parentController?.processFrame(sampleBuffer)
    }
}

class CameraViewController: UIViewController {
    weak var delegate: PredictionDelegate?
    private let captureSession = AVCaptureSession()
    private let videoDelegate = VideoCaptureDelegate()
    
    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 1
        return request
    }()
    
    private var dynamicModel: MLModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoDelegate.parentController = self
        
        do {
            if let modelURL = Bundle.main.url(forResource: "Model", withExtension: "mlmodel") {
                let compiledURL = try MLModel.compileModel(at: modelURL)
                self.dynamicModel = try MLModel(contentsOf: compiledURL)
            }
        } catch {
            print("Model compilation failed.")
        }
        
        setupCamera()
    }
    
    func setupCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.startCameraSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted { DispatchQueue.main.async { self.startCameraSession() } }
            }
        default:
            delegate?.didUpdate("Camera permission required.")
        }
    }
    
    func startCameraSession() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        if captureSession.canAddInput(input) { captureSession.addInput(input) }
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(videoDelegate, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(output) { captureSession.addOutput(output) }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        let sessionToStart = self.captureSession
        DispatchQueue.global(qos: .userInitiated).async {
            sessionToStart.startRunning()
        }
    }
    
    func processFrame(_ sampleBuffer: CMSampleBuffer) {
        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        do {
            try handler.perform([handPoseRequest])
            
            // CLEAN DISPLAY: Shows this when your hand is down
            guard let observations = handPoseRequest.results, !observations.isEmpty else { 
                delegate?.didUpdate("Waiting for Sign...")
                return 
            }
            
            let keypoints = try observations.first!.keypointsMultiArray()
            
            if let mlModel = self.dynamicModel {
                let input = try MLDictionaryFeatureProvider(dictionary: ["poses": keypoints])
                let prediction = try mlModel.prediction(from: input)
                
                if let probsValue = prediction.featureValue(for: "labelProbabilities")?.dictionaryValue as? [String: Double] {
                    
                    if let bestMatch = probsValue.max(by: { a, b in a.value < b.value }) {
                        // Only show the letter if it's over 10% confident to stop random flickering
                        if bestMatch.value > 0.10 {
                            let cleanLabel = bestMatch.key.replacingOccurrences(of: "Label_", with: "")
                            let percent = Int(bestMatch.value * 100)
                            delegate?.didUpdate("\(cleanLabel) (\(percent)%)")
                        }
                    }
                }
            }
        } catch {
            // Ignoring frame errors so video stays smooth
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
