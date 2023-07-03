//
//  ATSTvShowDetailView.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSTvShowDetailView: View {
    //MARK: - Enviroment
    @Environment(\.managedObjectContext) private var viewContext
    
    var tvShow: ATSTvShow
    
    @State
    private var showingAlert: Bool = false
    @State
    var alertContent: ATSAlertContent? {
        didSet {
            showingAlert = alertContent != nil
        }
    }
    
    var body: some View {
        VStack(spacing: 16){
            Spacer()
            AsyncImage(url: URL(string: tvShow.image?.medium ?? "")) { phase in
                if let image = phase.image {
                    image.renderingMode(.original)
                        .resizable()
                } else {
                    Image(systemName: "tv")
                }
            }
            .frame(width: 80, height: 120)
            .cornerRadius(5)
            Text(tvShow.name ?? "NA")
                .foregroundColor(.primary)
                .font(.callout)
            Text(tvShow.summary ?? "")
                .foregroundColor(.primary)
                .font(.caption)
            Button("Agregar a favoritos") {
                do {
                    try ATSTvShowManager().saveFavoriteTvShow(tvShow: tvShow, context: viewContext)
                    alertContent = ATSAlertContent(title: "Exito", description: "Se guardo de forma exitosa el favorito")
                } catch {
                    alertContent = ATSAlertContent(title: "Error", description: "Ocurrio un error al guardar el favorito")
                }
            }
            Spacer()
        }
        .navigationTitle("Detalle del show")
        .alert(alertContent?.title ?? "Alerta", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                alertContent = nil
            }
        } message: {
            Text(alertContent?.description ?? "")
        }
    }
}

struct ATSTvShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ATSTvShowDetailView(tvShow: ATSTvShow(id: 1, name: "Prueba", rating: .init(average: 4.0), image: .init(medium: "", original: ""), summary: "Descripcion")).environment(\.managedObjectContext, ATSPersistenceController.preview.container.viewContext)
    }
}
