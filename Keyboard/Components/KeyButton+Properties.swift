import UIKit

extension KeyButton {
        
        var width: CGFloat {
                switch keyboardEvent {
                case .none:
                        return 10
                case .backspace, .shiftUp, .shiftDown, .switchTo(_), .switchInputMethod:
                        return 50
                case .newLine:
                        return 80
                case .space:
                        return 200
                default:
                        return 40
                }
        }
        
        var height: CGFloat {
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                        if UIScreen.main.bounds.height < 700 {
                                // iPhone 7, 8, SE2
                                return 53
                        } else {
                                return 55
                        }
                case .pad:
                        return 65
                default:
                        return 55
                }
        }
        
        var buttonColor: UIColor {
                let systemColor: UIColor = isDarkAppearance ? .darkActionButton : .lightActionButton
                let notSystemColor: UIColor = isDarkAppearance ? .darkButton : .lightButton
                let color: UIColor = shouldBeDarker ? systemColor : notSystemColor
                return color
        }
        
        var buttonTintColor: UIColor {
                let color: UIColor = isDarkAppearance ? .darkButtonText : .lightButtonText
                return color
        }
        
        var styledFont: UIFont {
                // Font sizes reference: https://www.iosfontsizes.com
                switch keyboardEvent {
                case .text:
                        return UIFontMetrics(forTextStyle: .title2).scaledFont(for: .systemFont(ofSize: 24))
                default:
                        return .preferredFont(forTextStyle: .body)
                }
        }
        
        var keyText: String? {
                switch keyboardEvent {
                case .text(let text):
                        return text
                case .space:
                        let currentLayout = viewController.keyboardLayout
                        if currentLayout == .alphabetLowercase ||
                                currentLayout == .alphabetUppercase ||
                                currentLayout == .numericAlphabet ||
                                currentLayout == .symbolicAlphabet {
                                return "English"
                        } else {
                                return "粵  拼"
                        }
                case .switchTo(let type):
                        return keyText(for: type)
                default:
                        return nil
                }
        }
        
        private func keyText(for keyboardType: KeyboardLayout) -> String {
                switch keyboardType {
                case .numericJyutping, .numericAlphabet:
                        return "123"
                case .symbolicJyutping, .symbolicAlphabet:
                        return "#+="
                case .jyutping:
                        return "粵"
                case .cantoneseSymbolic:
                        return "符"
                case .alphabetLowercase:
                        return "EN"
                default:
                        return "??"
                }
        }
        
        var keyImage: UIImage? {
                switch keyboardEvent {
                case .switchInputMethod:
                        return UIImage(systemName: "globe")
                case .backspace:
                        return UIImage(systemName: "delete.left")
                case .newLine:
                        return UIImage(systemName: "return")
                case .shiftUp:
                        return UIImage(systemName: "shift")
                case .shiftDown:
                        return UIImage(systemName: "shift.fill")
                default:
                        return nil
                }
        }
        
        var highlightButtonColor: UIColor {
                let systemColor: UIColor = isDarkAppearance ? .darkButton : .lightButton
                let notSystemColor: UIColor = isDarkAppearance ? .darkActionButton : .lightActionButton
                let color: UIColor = shouldBeDarker ? systemColor : notSystemColor
                return color
        }
        
        private var isDarkAppearance: Bool {
                let appearance: UIKeyboardAppearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
                return appearance == .dark || viewController.traitCollection.userInterfaceStyle == .dark
        }
        
        private var shouldBeDarker: Bool {
                switch keyboardEvent {
                case .text, .space:
                        return false
                default:
                        return true
                }
        }
}
