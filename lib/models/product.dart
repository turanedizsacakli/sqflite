class Product{
  int? id;
  String? name;
  String? description;
  double? unitPrice;
  Product(this.name,this.description,this.unitPrice);
  Product.withId(this.id,this.name,this.description,this.unitPrice);

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if (id!=null){
      map["id"]=id;
    }
    return map;
  }

  Product.fromObject(dynamic obj){
    this.id=int.tryParse(obj["id"]);
    this.name=obj["name"];
    this.description=obj["description"];
    this.unitPrice=double.tryParse(obj["unitPrice"].toString());
  }
}