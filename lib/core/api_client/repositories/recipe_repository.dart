import '../recipe_remote_datasource.dart';
import '../../../features/recipe_recommender/data/models/recipe_model.dart';

class RecipeRepository {
  final RecipeRemoteDataSource _remoteDataSource;

  RecipeRepository(this._remoteDataSource);

  Future<List<RecipeModel>> getRecipesSuggest(List<String> ingredients) async {
    // Ở đây sau này bạn có thể thêm logic:
    // Check Cache Firebase trước -> Nếu có thì trả về -> Nếu không mới gọi API
    // Hiện tại cứ gọi thẳng API đã:
    return await _remoteDataSource.findRecipesByIngredients(ingredients);
  }
}