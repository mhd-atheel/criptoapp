class DataModel {
    final String name;
    final String subname;
    final String price;
    final String increase;
    final String image;
     List<dynamic> history;

    DataModel({
      required this.name,
      required this.subname,
      required this.price,
      required this.increase,
      required this.image,
      required this.history
});
    factory DataModel.fromJson(Map<String,dynamic > json) {
      print(json['history'][0].runtimeType);
      return DataModel(
        name: json['name'],
        subname: json['subname'],
        price: json['price'],
        increase: json['increase'],
        image: json['image'],
        history: json['history'],
      );
    }

}