//MARK: - VIEWController
class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = AppDimensions.CommonStackView.spacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find company or ticker"
        searchBar.setupCustomSearchBar()
        return searchBar
    }()
    
    private lazy var scrollViewForButtons: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = .none
        return view
    }()
    
    private lazy var stackViewForButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = AppDimensions.ScrollViewForButtons.spacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var stocksTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var favouriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Data
    var presenter: MainPresenterLogic?
    
    private var buttons: [UIButton] = []
    
    private var searchViewHeightConstraint: NSLayoutConstraint!
    private let maxSearchViewHeight: CGFloat = AppDimensions.SearchView.maxHeight
    private let minSearchViewHeight: CGFloat = AppDimensions.SearchView.minHeight
    
    var ofSet: CGFloat = 0
    
    private var data1 = (1...40).map { "Item 1-\($0)" }
    private var data2 = (1...40).map { "Item 2-\($0)" }
    
    private var currentTableView: UITableView!
    
    private var isTableView1Active = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNesting()
        
        setupUI()
        setupConstraints()
        showTableView1(animated: false)
        setupButtons()

    }
    
    
    private func setupNesting() {
        view.addSubview(commonStackView)
        
        commonStackView.addArrangedSubview(searchView)
        commonStackView.addArrangedSubview(scrollViewForButtons)
        commonStackView.addArrangedSubview(containerView)
        
        searchView.addSubview(searchBar)
        scrollViewForButtons.addSubview(stackViewForButtons)
        containerView.addSubview(stocksTableView)
        containerView.addSubview(favouriteTableView)
    }
    
    private func setupConstraints() {
        searchViewHeightConstraint = searchView.heightAnchor.constraint(equalToConstant: maxSearchViewHeight)
        
        NSLayoutConstraint.activate([
            commonStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: AppDimensions.CommonStackView.topAnchor),
            commonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppDimensions.CommonStackView.leftAndRightAnchor),
            commonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (-1) * AppDimensions.CommonStackView.leftAndRightAnchor),
            commonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            searchViewHeightConstraint,
            searchView.widthAnchor.constraint(equalTo: commonStackView.widthAnchor),
            
            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            
            scrollViewForButtons.heightAnchor.constraint(equalToConstant: AppDimensions.Buttons.primaryHeight),
            scrollViewForButtons.widthAnchor.constraint(equalTo: commonStackView.widthAnchor),
            
            stackViewForButtons.leadingAnchor.constraint(equalTo: scrollViewForButtons.leadingAnchor),
            stackViewForButtons.trailingAnchor.constraint(equalTo: scrollViewForButtons.trailingAnchor),
            stackViewForButtons.topAnchor.constraint(equalTo: scrollViewForButtons.topAnchor),
            stackViewForButtons.bottomAnchor.constraint(equalTo: scrollViewForButtons.bottomAnchor),
            stackViewForButtons.heightAnchor.constraint(equalTo: scrollViewForButtons.heightAnchor),
            
            containerView.widthAnchor.constraint(equalTo: commonStackView.widthAnchor),
            
            stocksTableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stocksTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stocksTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stocksTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            favouriteTableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            favouriteTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            favouriteTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favouriteTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupButtons() {
        
        // Добавляем кнопки
        let buttonTitles = ButtonsForMain.allCases
        buttonTitles.forEach { title in
            let button = createButton(title: title.rawValue)
            buttons.append(button)
            stackViewForButtons.addArrangedSubview(button)
        }
        
        // Обновляем contentSize после добавления кнопок
        DispatchQueue.main.async {
            self.scrollViewForButtons.contentSize = CGSize(
                width: self.stackViewForButtons.frame.width + 32,
                height: self.scrollViewForButtons.frame.height
            )
        }
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.pressedButton
        
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = .none
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        print("Нажата кнопка: \(sender.currentTitle ?? "")")
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        configureTableView(stocksTableView)
        configureTableView(favouriteTableView)
        
        stocksTableView.dataSource = self
        favouriteTableView.dataSource = self
        stocksTableView.delegate = self
        favouriteTableView.delegate = self
    }
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    
    // MARK: - Table Management
    private func showTableView1(animated: Bool) {
        stocksTableView.isScrollEnabled = true
        favouriteTableView.isScrollEnabled = false
        
        if animated {
            UIView.animate(withDuration: 0.35) {
                self.stocksTableView.alpha = 1
                self.favouriteTableView.alpha = 0
            }
        } else {
            stocksTableView.alpha = 1
            favouriteTableView.alpha = 0
        }
        isTableView1Active = true
    }
    
    private func showTableView2(animated: Bool) {
        stocksTableView.isScrollEnabled = false
        favouriteTableView.isScrollEnabled = true
        
        if animated {
            UIView.animate(withDuration: 0.35) {
                self.stocksTableView.alpha = 0
                self.favouriteTableView.alpha = 1
            }
        } else {
            stocksTableView.alpha = 0
            favouriteTableView.alpha = 1
        }
        isTableView1Active = false
    }
    
    // MARK: - Actions
    @objc private func switchTables() {
        if isTableView1Active {
            showTableView2(animated: true)
        } else {
            showTableView1(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == stocksTableView ? data1.count : data2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = tableView == stocksTableView ? data1[indexPath.row] : data2[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Плавное изменение размера при скролле
        let offsetY = scrollView.contentOffset.y
        let newHeight = max(minSearchViewHeight, maxSearchViewHeight - offsetY)
        searchViewHeightConstraint.constant = min(maxSearchViewHeight, newHeight)
        
        let progress = (maxSearchViewHeight - newHeight) / (maxSearchViewHeight - minSearchViewHeight)
        searchView.alpha = 1 - progress
        searchBar.alpha = searchView.alpha
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Опционально: предварительный расчет для плавности
        if velocity.y < -0.5 {
            // Пользователь быстро скроллит вверх - сразу показываем
            snapSearchView(shouldHide: false)
        } else if velocity.y > 0.5 {
            // Быстро скроллит вниз - сразу скрываем
            snapSearchView(shouldHide: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // Если не будет инерционного скролла
            snapSearchView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // После завершения инерции
        snapSearchView()
    }
    
    private func snapSearchView(shouldHide: Bool? = nil) {
        let finalHide = shouldHide ?? (searchViewHeightConstraint.constant < maxSearchViewHeight / 2)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.searchViewHeightConstraint.constant = finalHide ? self.minSearchViewHeight : self.maxSearchViewHeight
            self.searchView.alpha = finalHide ? 0 : 1
            self.searchBar.alpha = self.searchView.alpha
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Реализация поиска (как в предыдущем примере)
    }
}
extension MainViewController: MainViewControllerDisplayLogic {}
