//
// Created by 延澤拓郎 on 2019-03-24.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

protocol SearchViewModelProtocol {
    init(mediator: SearchTaskMediatorProtocol)
}

class SearchViewModel: SearchViewModelProtocol {
    let mediator: SearchTaskMediatorProtocol

    required init(mediator: SearchTaskMediatorProtocol) {
        self.mediator = mediator
    }
}
