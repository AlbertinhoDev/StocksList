import UIKit

struct UIElementsMainView {
    static func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .lightGray
        return indicator
    }
    
    static func createCommonStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = AppDimensions.CommonStackView.spacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }
    static func createSearchView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    static func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find company or ticker"
        searchBar.setupCustomSearchBar()
        return searchBar
    }

    static func scrollViewForButtons() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    static func containerView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = .none
        return view
    }
        
    static func stackViewForButtons() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = AppDimensions.ScrollViewForButtons.spacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }
        
    static func stocksTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }

    static func favouriteTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }
}
