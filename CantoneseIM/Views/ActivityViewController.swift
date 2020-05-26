import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
        
        let activityItems: [Any]
        let applicationActivities: [UIActivity]? = nil
        let excludedActivityTypes: [UIActivity.ActivityType]? = nil
        let callback: UIActivityViewController.CompletionWithItemsHandler? = nil
        
        func makeUIViewController(context: Context) -> UIActivityViewController {
                let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
                controller.excludedActivityTypes = excludedActivityTypes
                controller.completionWithItemsHandler = callback
                return controller
        }
        
        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct ActivityViewController_Previews: PreviewProvider {
        static var previews: some View {
                ActivityViewController(activityItems: ["test"])
        }
}
