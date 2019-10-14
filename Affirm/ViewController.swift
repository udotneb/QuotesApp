//
//  ViewController.swift
//  Affirm
//
//  Created by Benjamin Ulrich on 10/2/19.
//  Copyright © 2019 Benjamin Ulrich. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    let links = ["http://www.brainyquote.com/authors/lil-wayne-quotes", "https://www.brainyquote.com/authors/asap-rocky-quotes"]
    
    var mainView: View?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(scrapeLink), name: NSNotification.Name("buttonPressed"), object: nil)
        mainView = View()
        self.view.addSubview(mainView!)
        mainView!.bindFrameToSuperviewBounds()
    }
    
    @objc private func scrapeLink() -> Void {
        // chooses a random link from links and scrapes it. If nil quoteMessage, try another
        if let link = links.randomElement() {
            if let author = link.slices(from: "/", to: "-quotes") {
                Alamofire.request(link).responseString { response in
                    print("able to connect to link: \(response.result.isSuccess)")
                    if let html = response.result.value {
                        if let quoteMessage = self.parseHTML(html: html) {
                            let quote = Quote(message:quoteMessage, author: author[0])
                            self.mainView?.quote = quote
                        }
                    }
                }
            }
        }
    }
    
    
    private func parseHTML(html: String) -> String? {
        // parses the html string, and returns a random quote or nil
        let from = "title=\"view quote\">"
        let to = "</a>"
        let quoteMessages = html.slices(from: from, to: to)
        return quoteMessages?.randomElement()
    }
}

