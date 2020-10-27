import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(onWillEnterForegroundNotification(notification:)),
            name: UIScene.willEnterForegroundNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(onDidEnterBackgroundNotification(notification:)),
            name: UIScene.didEnterBackgroundNotification,
            object: nil
        )
        
        printConnectedScenes(on: "#viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printConnectedScenes(on: "#viewDidAppear")
    }
    
    @objc
    private func onWillEnterForegroundNotification(notification: Any) {
        printConnectedScenes(on: "#onWillEnterForegroundNotification")
    }
    
    @objc
    private func onDidEnterBackgroundNotification(notification: Any) {
        printConnectedScenes(on: "#onDidEnterBackgroundNotification")
    }
}

extension ViewController {
    static func make() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateInitialViewController() as! ViewController
    }
}
