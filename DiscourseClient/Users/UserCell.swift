//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Hadrian Grille Negreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class UserCell: UITableViewCell {
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
            guard let imageURL = URL(string: viewModel.urlAvatar ?? "") else {return}
            
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                guard let imageData = try? Data(contentsOf: imageURL) else {return}
                DispatchQueue.main.async {
                    self?.imageView?.image = UIImage(data: imageData)
                    self?.setNeedsLayout()
                }
            }
        }
    }
}
