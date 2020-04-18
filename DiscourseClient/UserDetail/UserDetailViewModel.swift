//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Hadrian Grille Negreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    func userDetailChangeButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func usernameChanged()
    func errorChangingUsername()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelUserNameText: String?
    var buttonCanEdit: Bool?

    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let userName: String

    init(userName: String, userDetailDataManager: UserDetailDataManager) {
        self.userName = userName
        self.userDetailDataManager = userDetailDataManager
    }

    func viewDidLoad() {
        userDetailDataManager.fetchUser(userName: self.userName) {[weak self] (result) in
            switch result {
            case .success(let userDetail):
                //Preguntar se esto no tendriamos que bloquear el hilo principal.
                /*
                 No necesitamos main.async porque SessionAPI llama al closure siempre con main.async, así que lo estaríamos haciendo
                 dos veces. Como lo tienes, está bien.
                 */
                guard let response = userDetail else {return}
                self?.labelUserIDText = String(response.user.id)
                self?.labelUserNameText = response.user.username
                /*
                 Era canEditName lo que se pedía, no canEditUsername
                 Además, si response.user.canEditUsername no es optional, no tiene sentido compararlo con nil
                 */
                if response.user.canEditUsername != nil {
                    self?.buttonCanEdit = response.user.canEditUsername
                    //self?.buttonCanEdit = true
                } else {
                    self?.buttonCanEdit = false
                }

                self?.viewDelegate?.userDetailFetched()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingUserDetail()
            }
            
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
    
    func changeButtonTapped(userName: String, newUserName: String) {
        userDetailDataManager.changeUserName(userName: userName, newUserName: newUserName) {[weak self] (result) in
            switch result {
            case .success:
                self?.viewDelegate?.usernameChanged()
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorChangingUsername()
            }
            
        }
        /** TODO:
         Realizar la llamada deleteTopic sobre el dataManager.
         Si el resultado es success, avisar al coordinator
         Si la llamada falla, avisar al viewDelegate
         */
    }
    
}
