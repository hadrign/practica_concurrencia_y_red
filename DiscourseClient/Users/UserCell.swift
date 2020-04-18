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

            /*
             Aunque la descarga de la imagen no está del todo mal hacerla aquí, como mejora te propondría hacerla
             en el init de UserCellViewModel, de forma que sólo la hacemos una vez. Ten en cuenta que esto se ejecuta
             cada vez que cellForRowAtIndexPath es llamado, y puede ser llamado varias veces para la misma celda
             cuando hacemos scroll.
             */
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
