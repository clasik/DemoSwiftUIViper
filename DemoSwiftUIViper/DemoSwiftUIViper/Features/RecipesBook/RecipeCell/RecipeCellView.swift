import SwiftUI
import URLImage

struct RecipeCellView: View {
    let recipe: RecipeViewModel
    
    var body: some View {
        recipeImage
    }
    
    var recipeImage: some View {
        VStack{
            ZStack{
                URLImage(URL(string: recipe.thumbnail)!) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 100)
            }
            HStack{
                VStack{
                    Text(recipe.title)
                    Text(recipe.ingredients)
                }
                Button(action: {
                    
                }){
                    if recipe.isFavourite{
                        Image("heart.fill")
                    } else {
                        Image("heart")
                    }
                }
            }
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
