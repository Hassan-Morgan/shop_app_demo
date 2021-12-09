class SearchModel{
  late bool status;
  late SearchDataModel data;

  SearchModel.fromJson(Map<String,dynamic>jsonData){
    status = jsonData['status'];
    data = SearchDataModel.fromJson(jsonData['data']);
  }

}

class SearchDataModel{
  List<DataModel> data = [];

  SearchDataModel.fromJson(Map<String,dynamic>jsonData){
    jsonData['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  late int id ;
  late dynamic price;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  DataModel.fromJson(Map<String,dynamic>jsonData){
    id = jsonData['id'];
    price = jsonData['price'];
    image = jsonData['image'];
    name = jsonData['name'];
    inFavorites = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}