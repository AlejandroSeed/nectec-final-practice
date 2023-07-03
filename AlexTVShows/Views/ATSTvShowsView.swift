//
//  ATSTvShowsView.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSTvShowsView: View {
    //MARK: - Enviroment
    @Environment(\.managedObjectContext) private var viewContext
    
    //MARK: - State
    @State
    var tvShows: [ATSTvShow] = []
    
    @State
    private var showingAlert: Bool = false
    
    @State
    var fetchingData: Bool = false
    
    @State
    var alertContent: ATSAlertContent? {
        didSet {
            showingAlert = alertContent != nil
        }
    }
    
    @State
    private var loadAgain = true
    //MARK: - Properties
    
    var type: ATSTvShowListType = .all
    
    var body: some View {
        NavigationStack {
            if fetchingData {
                ProgressView().navigationTitle(type.getTitle())
            } else {
                ATSShowList(tvShows: tvShows, action: getAction()).navigationTitle(type.getTitle())
            }
        }.onAppear {
            getTVShow()
        }.alert(alertContent?.title ?? "Alerta", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                alertContent = nil
            }
        } message: {
            Text(alertContent?.description ?? "")
        }
        
    }
}

//MARK: - Private functions
extension ATSTvShowsView {
    private func getTVShow() {
        guard loadAgain else {
            self.tvShows = self.tvShows.mapFavorites(context: viewContext)
            return
        }
        
        fetchingData = true
        type.getTvShows(context: viewContext) { result in
            switch result {
            case .success(let tvShows):
                
                if type == .all {
                    loadAgain = false
                    self.tvShows = tvShows.mapFavorites(context: viewContext)
                } else {
                    self.tvShows = tvShows
                }

                fetchingData = false
                
            case .failure:
                alertContent = ATSAlertContent(title: "Error", description: "Ocurrio un error al obtener los shows")
            }
        }
    }
    
    private func getAction() -> ATSAction {
        switch type {
        case .favorite:
            return ATSAction(color: .red, text: "Eliminar", swipeAction: { tvShow in
                do {
                    try ATSTvShowManager().deleteFavoriteTvShow(tvShow: tvShow, context: viewContext)
                    getTVShow()
                } catch {
                    alertContent = ATSAlertContent(title: "Error", description:  "Ocurrio un error al eleminar el favorito")
                }
            }, shouldGoToDetails: false)
        case .all:
            return ATSAction(color: .green, text: "Favorito", swipeAction: { tvShow in
                do {
                    try ATSTvShowManager().saveFavoriteTvShow(tvShow: tvShow, context: viewContext)
                    alertContent = ATSAlertContent(title: "Exito", description:  "Se agrego de forma exitosa el favorito")
                } catch {
                    alertContent = ATSAlertContent(title: "Error", description:  "Ocurrio un error al agregar un favorito")
                }
            }, shouldGoToDetails: true)
        }
    }
}

struct ATSTvShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ATSTvShowsView(type: .all).environment(\.managedObjectContext, ATSPersistenceController.preview.container.viewContext)
    }
}
