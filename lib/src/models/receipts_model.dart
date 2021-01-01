class ReceiptsModel {
  String marcent, date, account, tags, notes;
  double total;
  int id, colorIndex;
  String category;
  int isBill;

  ReceiptsModel(
      {this.id,
      this.marcent,
      this.total,
      this.date,
      this.category,
      this.account,
      this.tags,
      this.notes,
      this.colorIndex,
      this.isBill});

  factory ReceiptsModel.fromMap(Map<String, dynamic> json) => ReceiptsModel(
        id: json["id"],
        marcent: json["marcent"],
        date: json["date"],
        total: json["total"],
        colorIndex: json["colorIndex"],
        category: json["category"],
        account: json["account"],
        tags: json["tags"],
        isBill: json["isBill"],
        notes: json["notes"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "marcent": marcent,
        "date": date,
        "total": total,
        "colorIndex": colorIndex,
        "category": category,
        "account": account,
        "tags": tags,
        "isBill": isBill,
        "notes": notes,
      };
}
