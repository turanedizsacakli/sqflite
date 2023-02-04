class Product{
  final int? id;
  final String name;
  final String description;
  final int unitPrice;

  Product({this.id,required this.name,required this.description,required this.unitPrice});

  factory Product.fromJson(Map<String,dynamic> json)=> Product(
    id:json['id'],
    name:json['name'],
    description:json['description'],
    unitPrice:json['unitPrice'],
  );

  Map<String,dynamic> toJson()=>
      {
        'name' : name,
        'description' : description,
        'unitPrice' : unitPrice,
      };

}