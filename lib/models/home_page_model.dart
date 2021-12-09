class HomePageModel{

  late bool status ;
  late DataModel data;

  
  HomePageModel.fromJson(Map<String,dynamic> jsonData){
     status = jsonData['status'];
     data = DataModel.fromJson(jsonData['data']);
  }
}

class DataModel{
  List<BannerModel> banners = [] ;
  List<ProductModel> products = [] ;

  DataModel.fromJson(Map<String,dynamic> jsonData){
      jsonData['banners'].forEach((element){
        banners.add(BannerModel.fromJson(element));
      });
      jsonData['products'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });
    }
}

class BannerModel{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['id'];
    image = jsonData['image'];
  }
}

class ProductModel{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String,dynamic>jsonData){
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    inFavorites = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }

}