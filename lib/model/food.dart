class Food{
  String name, description, image, createdBy, documentID;
  int amount, barcode;
  DateTime lastUpdatedAt;
  List<dynamic> sharedWith;



  Food({
    this.name,
    this.description,
    this.amount,
    this.barcode,
    this.image,
    this.createdBy,
    this.lastUpdatedAt, 
    this.sharedWith
  });
  Food.empty(){
    this.name = '';
    this.description = '';
    this.amount = 0;
    this.barcode = 000000000000;
    this.image = '';
    this.createdBy = '';
    this.sharedWith = <dynamic>[];
  }

  Food.clone(Food f){
    this.documentID = f.documentID;
    this.name = f.name; 
    this.description = f.description;
    this.amount = f.amount;
    this.barcode = f.barcode;
    this.image = f.image;
    this.createdBy = f.createdBy;
    this.sharedWith = <dynamic>[]..addAll(f.sharedWith);
    this.lastUpdatedAt = f.lastUpdatedAt;
  }

  Map<String, dynamic> serialize(){
    return <String, dynamic>{
      NAME: name,
      DESCRIPTION: description,
      BARCODE: barcode,
      IMAGE: image,
      AMOUNT: amount,
      CREATEDBY: createdBy,
      LASTUPDATEDAT: lastUpdatedAt,
      SHAREDWITH: sharedWith
    };
  }

  static Food deserialize(Map<String, dynamic> data, String docID){
    var food = Food(
      name: data[NAME],
      description: data[DESCRIPTION],
      barcode: data[BARCODE],
      amount: data[AMOUNT],
      image: data[IMAGE],
      createdBy: data[Food.CREATEDBY],
      sharedWith: data[Food.SHAREDWITH],
    );
    if(data[Food.LASTUPDATEDAT] != null){
      food.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(
        data[Food.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    food.documentID = docID;
    return food;
  }

  static const FRIDGEITEM_COLLECTION = 'fridgeitem';
  static const NAME = 'name';
  static const DESCRIPTION = 'description';
  static const BARCODE = 'barcode';
  static const AMOUNT = 'amount';
  static const IMAGE = 'image';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  static const SHAREDWITH = 'sharedWith';
}