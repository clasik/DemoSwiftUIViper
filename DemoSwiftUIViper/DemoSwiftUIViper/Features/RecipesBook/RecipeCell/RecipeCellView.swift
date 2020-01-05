import SwiftUI
import URLImage

struct RecipeCellView: View {
    let recipe: RecipeViewModel

    var body: some View {
        VStack {
            ZStack {
                URLImage(URL(string: self.recipe.thumbnail)!) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(height: 150)
                GeometryReader { g in
                    if self.recipe.hasLactose {
                        Text("has_lactose".localized)
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                            .background(Color.red)
                            .rotationEffect(Angle(degrees: 45))
                            .position(x: g.size.width-35, y: 35)
                    }
                }
            }.clipped()
            HStack {
                Text(self.recipe.title).font(.headline).lineLimit(nil)
                Spacer()
                Image(systemName: self.recipe.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(CGFloat(40))
                    .onTapGesture {
                        debugPrint("Favorite")
                }
            }
            Text(self.recipe.ingredients).lineLimit(nil)
        }
    }
}

#if DEBUG
struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel(title: "", href: "", ingredients: "", thumbnail: "")
        return RecipeCellView(recipe: recipe)
    }
}
#endif
