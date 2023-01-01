//
//  LocationCell.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import UIKit

class LocationCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg
        textLabel?.textColor = .hex("#777777")
        textLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            backgroundColor = .primaryH
            textLabel?.textColor = .white
        } else {
            backgroundColor = .bg
            textLabel?.textColor = .hex("#777777")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            backgroundColor = .primary
            textLabel?.textColor = .white
        } else {
            backgroundColor = .bg
            textLabel?.textColor = .hex("#777777")
        }
    }
}

class LocationSubCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        textLabel?.textColor = .hex("#333333")
        textLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            textLabel?.textColor = .primary
        } else {
            textLabel?.textColor = .hex("#333333")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            textLabel?.textColor = .primary
        } else {
            textLabel?.textColor = .hex("#333333")
        }
    }
}

