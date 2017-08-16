//
//  MelodeonHeaderCell.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit

open class MelodeonHeaderCell: UITableViewHeaderFooterView {

    // Default height of our header will be 44.0
    static let defaultHeight:CGFloat = 44.0

    public var isCollapsed:Bool {
        return collapsed
    }

    open var collapsed = true
    open var item: Any? {
        didSet {
            guard let itemString = item as? String else {
                self.textLabel?.text = "Header Cell"
                return
            }
            self.textLabel?.text = itemString
        }
    }

    var headerTapped:((_ section: Int) -> Void)?
    private var tapGestureRecognizer:UITapGestureRecognizer!

    public var section = -1

    open let separator: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        line.isHidden = false
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        setupViews()
    }

    open func setupViews() {
        contentView.backgroundColor = .white
        clipsToBounds = true
        addSubview(self.separator)
        separator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    var isInteractive:Bool = false {
        willSet {
            if newValue {
                addGestureRecognizer(tapGestureRecognizer)
            } else {
                removeGestureRecognizer(tapGestureRecognizer)
            }
        }
    }

    @objc private func headerTapped(_ sender: UIButton) {
        headerTapped?(self.section)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        setupViews()
    }
    
}
