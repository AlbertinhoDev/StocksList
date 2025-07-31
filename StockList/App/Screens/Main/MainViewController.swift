import UIKit

class MainViewController: UIViewController {
    var presenter: MainPresenterLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: MainViewControllerDisplayLogic {
}
