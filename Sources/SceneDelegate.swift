import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController.make())
        self.window = window
        window.makeKeyAndVisible()
    }
}

extension UIWindow {
    static var keyWindow: UIWindow {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
        
//        // ref. https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
//        return UIApplication.shared.connectedScenes
//            .filter { $0.activationState == .foregroundActive }
//            .compactMap { $0 as? UIWindowScene }
//            .first?.windows
//            .first(where: { $0.isKeyWindow })
    }
}

extension UIWindowScene {
    static var statusBarFrame: CGRect! {
        UIWindow.keyWindow.windowScene!.statusBarManager!.statusBarFrame
    }
}


// MARK: - Debug

func printConnectedScenes(on timing: String) {
    print("\(timing)----------")
            
    let scenes = UIApplication.shared.connectedScenes
    scenes.enumerated().forEach { indexedScene in
        print("\(type(of: indexedScene.element))-\(indexedScene.offset + 1): \(indexedScene.element.activationState)")
        
        if let windowScene = indexedScene.element as? UIWindowScene {
            windowScene.windows.enumerated().forEach { indexedWindow in
                let statusBarHeight = indexedWindow.element.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                print("  window-\(indexedWindow.offset + 1): isKeyWindow=\(indexedWindow.element.isKeyWindow), statusBarHeight=\(statusBarHeight)")
            }
        }
    }
    
//    let windows = UIApplication.shared.windows
//    print("Windows:")
//    windows.enumerated().forEach { indexedWindow in
//        print("  window-\(indexedWindow.offset + 1): isKeyWindow=\(indexedWindow.element.isKeyWindow)")
//    }
    
    print("------------------------------\n")
}

extension UIScene.ActivationState: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .background:
            return "background"
        case .foregroundActive:
            return "foregroundActive"
        case .foregroundInactive:
            return "foregroundInactive"
        case .unattached:
            return "unattached"
        @unknown default:
            return "uknown(\(self.rawValue)"
        }
    }
}
