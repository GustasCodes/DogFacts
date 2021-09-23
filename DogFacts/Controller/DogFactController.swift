//
//  MainTabController.swift
//  DogFacts
//
//  Created by Gustas on 2021-09-23.
//

import UIKit

class DogFactController: UIViewController {
    
    // MARK: - Properties
    
    var fact: Fact?
    
    private let factTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textColor = .label
        textView.textAlignment = .center
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        getFact()
    }
    
    // MARK: - API
    
    func getFact() {
        DogService.shared.getRandomFact { (fact) in
            self.fact = fact
            self.factTextView.text = fact.fact
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(factTextView)
        factTextView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        factTextView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        if let storedFact = UserDefaults.standard.object(forKey: "myDogFact") as? String {
            factTextView.text = storedFact
        }
    }
}
