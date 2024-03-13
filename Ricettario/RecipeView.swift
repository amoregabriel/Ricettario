import Foundation
import SwiftUI

// Recipes clickable cards
struct RecipeCard: View {
    var recipe: Recipe
    var isHeartRed: Bool
    var toggleHeart: () -> Void
    
    @StateObject private var watchConnector:WatchConnector = WatchConnector()
   
    @State private var isPopoverPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .edgesIgnoringSafeArea(.horizontal)
                    .aspectRatio(4/3, contentMode: .fill)
                    .frame(height: 180)
                    .clipped()
                
                Button(action:  {
                    toggleHeart()
                    if(isHeartRed){
                        watchConnector.sendMessage(key: "rmvPref", value: recipe.title)}
                    else if (!isHeartRed){
                        watchConnector.sendMessage(key: "addPref", value: recipe.title)}
                }){
                    Image(systemName: isHeartRed ? "heart.fill" : "heart")
                        .foregroundColor(isHeartRed ? .red : .white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Text(recipe.description)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.system(size: 15))
                    .lineLimit(3)
            }
            .padding(5)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .onTapGesture {
            isPopoverPresented.toggle()
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .bottom) {
            RecipeDetailView(recipe: recipe, isHeartRed: isHeartRed, toggleHeart: toggleHeart)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
