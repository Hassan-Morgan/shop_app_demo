class Favorites{
  late bool status;
  late FavoritesDataModel data;

  Favorites.fromJson(Map<String,dynamic>jsonData){
    data = FavoritesDataModel.fromJson(jsonData['data']);
  }
}

class FavoritesDataModel{
  List<DataModel> data =[];

  FavoritesDataModel.fromJson(Map<String,dynamic>jsonData){
    jsonData['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  late int id;
  late ProductModel product;

  DataModel.fromJson(Map<String,dynamic>jsonData){
  id = jsonData['id'];
  product = ProductModel.fromJson(jsonData['product']);
  }
}

class ProductModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  ProductModel.fromJson(Map<String,dynamic>jsonData){
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
  }
}