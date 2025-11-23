import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api_client/recipe_remote_datasource.dart';
import '../../../../core/api_client/repositories/recipe_repository.dart';
import '../../data/models/recipe_model.dart';


// 1. Provider cho DataSource
final recipeRemoteDataSourceProvider = Provider((ref) => RecipeRemoteDataSource());

// 2. Provider cho Repository
final recipeRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(recipeRemoteDataSourceProvider);
  return RecipeRepository(remoteDataSource);
});

// 3. Provider chính để UI dùng (QUAN TRỌNG NHẤT)
// Family provider cho phép truyền tham số (list nguyên liệu) vào
final recipeSuggestionsProvider = FutureProvider.family<List<RecipeModel>, List<String>>((ref, ingredients) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getRecipesSuggest(ingredients);
});