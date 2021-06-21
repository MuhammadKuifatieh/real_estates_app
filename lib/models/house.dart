class House {
  final int id;
  DateTime date;
  int bedrooms;
  int bathrooms;
  int sqftLiving;
  int sqftLandSpace;
  int floors;
  bool waterFront;
  int view;
  int condition;
  int grade;
  int sqftAbove;
  int sqftBasement;
  int yearBuilt;
  int zipcode;
  double lattitude;
  double longitude;
  int regionId;
  int price;

  House({
    this.bathrooms,
    this.price,
    this.bedrooms,
    this.condition,
    this.date,
    this.floors,
    this.grade,
    this.id,
    this.lattitude,
    this.longitude,
    this.regionId,
    this.sqftAbove,
    this.sqftBasement,
    this.sqftLiving,
    this.sqftLandSpace,
    this.view,
    this.waterFront,
    this.yearBuilt,
    this.zipcode,
  });
}
