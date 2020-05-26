import UIKit

extension KeyButton {
        
        func setupKeyActions() {
                if keyboardEvent == .backspace {
                        self.addTarget(self, action: #selector(handleBackspace), for: .touchDown)
                        self.addTarget(self, action: #selector(stopBackspace), for: .touchUpInside)
                } else if keyboardEvent != .space {
                        self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
                }
        }
        @objc private func handleTap() {
                switch keyboardEvent {
                case .text(let text):
                        if viewController.keyboardLayout == .jyutping {
                                viewController.currentInputText += text
                        } else {
                                viewController.textDocumentProxy.insertText(text)
                        }
                        if viewController.keyboardLayout == .alphabetUppercase {
                                viewController.keyboardLayout = .alphabetLowercase
                        }
                case .newLine:
                        if viewController.currentInputText.isEmpty {
                                viewController.textDocumentProxy.insertText("\n")
                        } else {
                                viewController.textDocumentProxy.insertText(viewController.currentInputText)
                                viewController.currentInputText = ""
                        }
                case .switchTo(let layout):
                        viewController.keyboardLayout = layout
                case .shiftUp:
                        viewController.keyboardLayout = .alphabetUppercase
                case .shiftDown:
                        viewController.keyboardLayout = .alphabetLowercase
                default:
                        break
                }
                DispatchQueue.global().async {
                        AudioFeedback.play(for: self.keyboardEvent)
                }
        }
        @objc private func handleBackspace() {
                performBackspace()
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(performBackspace), userInfo: nil, repeats: true)
        }
        @objc private func performBackspace() {
                if viewController.currentInputText.isEmpty {
                        viewController.textDocumentProxy.deleteBackward()
                } else {
                        viewController.currentInputText = String(viewController.currentInputText.dropLast())
                }
                DispatchQueue.global().async {
                        AudioFeedback.play(for: .backspace)
                }
        }
        @objc private func stopBackspace() {
                timer?.invalidate()
        }
}
