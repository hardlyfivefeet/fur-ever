import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        if !url.isEmpty {
            let myURL = URL(string: url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            webView.navigationDelegate = self
        } else {
            let alert = UIAlertController(title: "URL not found",
               message: "Sorry, this web page is not available.",
               preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingView.startAnimating()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingView.stopAnimating()
    }
}
