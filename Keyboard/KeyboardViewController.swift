import UIKit

final class KeyboardViewController: UIInputViewController {
        
        lazy var toolBar: ToolBar = ToolBar(viewController: self)
        lazy var settingsView: SettingsView = SettingsView()
        lazy var wordsBoard: WordsBoard = WordsBoard()
        lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        lazy var keyboardStackView: UIStackView = {
                let stackView = UIStackView(frame: .zero)
                stackView.axis = .vertical
                stackView.alignment = .fill
                stackView.distribution = .equalSpacing
                return stackView
        }()
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.register(WordsCollectionViewCell.self, forCellWithReuseIdentifier: "WordsCell")
                self.collectionView.backgroundColor = self.view.backgroundColor
                
                self.view.addSubview(keyboardStackView)
                keyboardStackView.translatesAutoresizingMaskIntoConstraints = false
                keyboardStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                keyboardStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                keyboardStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                keyboardStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
                ensurePreferences()
                setupToolBarActions()
        }
        
        override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                setupKeyboard()
        }
        
        var isDarkAppearance: Bool {
                textDocumentProxy.keyboardAppearance == .dark ||
                traitCollection.userInterfaceStyle == .dark
        }
        
        var keyboardLayout: KeyboardLayout = .jyutping {
                didSet {
                        setupKeyboard()
                        if keyboardLayout != .jyutping && keyboardLayout != .wordsBoard {
                                currentInputText = ""
                        }
                }
        }
        
        private let candidateQueue: DispatchQueue = DispatchQueue(label: "im.cantonese.cantoneseim.candidate", qos: .userInitiated)
        var currentInputText: String = "" {
                didSet {
                        DispatchQueue.main.async {
                                self.toolBar.update()
                                self.toolBar.inputLabel.text = self.currentInputText
                        }
                        candidateQueue.async {
                                self.requestSuggestion()
                        }
                }
        }
        
        var candidates: [Candidate] = [] {
                didSet {
                        DispatchQueue.main.async {
                                self.collectionView.reloadData()
                                if self.collectionView.contentOffset.x > 1 {
                                        self.collectionView.setContentOffset(.zero, animated: false)
                                }
                        }
                }
        }
        
        private let engine: Engine = Engine()
        func requestSuggestion() {
                candidates = engine.suggest(for: currentInputText)
        }
        
        private func ensurePreferences() {
                if !UserDefaults.standard.bool(forKey: "has_preferences") {
                        UserDefaults.standard.set(true, forKey: "has_preferences")
                        UserDefaults.standard.set(false, forKey: "audio_feedback")
                }
        }
        
        private func setupToolBarActions() {
                toolBar.settingsButton.addTarget(self, action: #selector(handleSettingsButtonEvent), for: .allTouchEvents)
                toolBar.downArrowButton.addTarget(self, action: #selector(handleDownArrowEvent), for: .allTouchEvents)
                toolBar.keyboardDownButton.addTarget(self, action: #selector(handleDismissKeyboard), for: .allTouchEvents)
        }
        @objc private func handleDownArrowEvent() {
                self.wordsBoard.height = self.view.bounds.height
                self.keyboardLayout = .wordsBoard
        }
        @objc private func handleDismissKeyboard() {
                self.dismissKeyboard()
        }
        @objc private func handleSettingsButtonEvent() {
                self.settingsView.height = self.view.bounds.height
                self.keyboardLayout = .settingsView
        }
}
