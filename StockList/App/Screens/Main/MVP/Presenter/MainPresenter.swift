import UIKit

final class MainPresenter {
    weak var viewController: MainViewControllerDisplayLogic?
    var router: MainRoutingLogic?
}

extension MainPresenter: MainPresenterLogic {
}
