class BmeCourseHocBu {
  int? id;
  String? ngayHocBu;
  String? maLop;
  String? tenFacebook;
  String? hoVaTen;
  String? ngaySinh;
  String? soDienThoai;
  String? giaoVienDayBu;
  String? lopHocBu;
  String? phiHocBu;
  String? baiHocBu;
  String? note;

  BmeCourseHocBu({
    this.id,
    this.ngayHocBu,
    this.maLop,
    this.tenFacebook,
    this.hoVaTen,
    this.ngaySinh,
    this.soDienThoai,
    this.giaoVienDayBu,
    this.lopHocBu,
    this.phiHocBu,
    this.baiHocBu,
    this.note,
  });

  factory BmeCourseHocBu.fromJson(Map<String, dynamic> json) => BmeCourseHocBu(
        id: json["id"],
        ngayHocBu: json["ngay_hoc_bu"],
        maLop: json["ma_lop"],
        tenFacebook: json["ten_facebook"],
        hoVaTen: json["ho_va_ten"],
        ngaySinh: json["ngay_sinh"],
        soDienThoai: json["so_dien_thoai"],
        giaoVienDayBu: json["giao_vien_day_bu"],
        lopHocBu: json["lop_hoc_bu"],
        phiHocBu: json["phi_hoc_bu"],
        baiHocBu: json["bai_hoc_bu"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ngay_hoc_bu": ngayHocBu,
        "ma_lop": maLop,
        "ten_facebook": tenFacebook,
        "ho_va_ten": hoVaTen,
        "ngay_sinh": ngaySinh,
        "so_dien_thoai": soDienThoai,
        "giao_vien_day_bu": giaoVienDayBu,
        "lop_hoc_bu": lopHocBu,
        "phi_hoc_bu": phiHocBu,
        "bai_hoc_bu": baiHocBu,
        "note": note,
      };
}
