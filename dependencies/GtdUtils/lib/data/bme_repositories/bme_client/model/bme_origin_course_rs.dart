class BmeOriginCourse {
  int? id;
  String? ownerId;
  String? maLop;
  String? shvDanhSach;
  String? shvToiDa;
  String? shvBoSung;
  String? tongHvDangHoc;
  String? giaoVienHienTai;
  String? ngayKhaiGiang;
  String? dinhHuong;
  String? phatAm;
  String? nguPhap;
  String? nghe;
  String? noi;
  String? nkhtGv;
  String? nkhtHv;
  String? mau;
  String? note;
  String? content;
  String? maGV;

  BmeOriginCourse(
      {this.id,
      this.ownerId,
      this.maLop,
      this.shvDanhSach,
      this.shvToiDa,
      this.shvBoSung,
      this.tongHvDangHoc,
      this.giaoVienHienTai,
      this.ngayKhaiGiang,
      this.dinhHuong,
      this.phatAm,
      this.nguPhap,
      this.nghe,
      this.noi,
      this.nkhtGv,
      this.nkhtHv,
      this.mau,
      this.note,
      this.content,
      this.maGV});

  factory BmeOriginCourse.fromJson(Map<String, dynamic> json) => BmeOriginCourse(
        id: json["ID"],
        ownerId: json["owner_id"],
        maLop: json["ma_lop"],
        shvDanhSach: json["shv_danh_sach"],
        shvToiDa: json["shv_toi_da"],
        shvBoSung: json["shv_bo_sung"],
        tongHvDangHoc: json["tong_hv_dang_hoc"],
        giaoVienHienTai: json["giao_vien_hien_tai"],
        ngayKhaiGiang: json["ngay_khai_giang"],
        dinhHuong: json["dinh_huong"],
        phatAm: json["phat_am"],
        nguPhap: json["ngu_phap"],
        nghe: json["nghe"],
        noi: json["noi"],
        nkhtGv: json["nkht_gv"],
        nkhtHv: json["nkht_hv"],
        mau: json["mau"],
        note: json["note"],
        content: json["content"],
        maGV: json["maGV"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "owner_id": ownerId,
        "ma_lop": maLop,
        "shv_danh_sach": shvDanhSach,
        "shv_toi_da": shvToiDa,
        "shv_bo_sung": shvBoSung,
        "tong_hv_dang_hoc": tongHvDangHoc,
        "giao_vien_hien_tai": giaoVienHienTai,
        "ngay_khai_giang": ngayKhaiGiang,
        "dinh_huong": dinhHuong,
        "phat_am": phatAm,
        "ngu_phap": nguPhap,
        "nghe": nghe,
        "noi": noi,
        "nkht_gv": nkhtGv,
        "nkht_hv": nkhtHv,
        "mau": mau,
        "note": note,
        "content": content,
        "maGV": maGV,
      };

  Map<String, dynamic> toRequest() => {
        "ma_lop": maLop,
        "owner_id": maLop,
        "shv_danh_sach": shvDanhSach,
        "shv_toi_da": shvToiDa,
        "shv_bo_sung": shvBoSung,
        "tong_hv_dang_hoc": tongHvDangHoc,
        "giao_vien_hien_tai": giaoVienHienTai,
        "ngay_khai_giang": ngayKhaiGiang,
        "dinh_huong": dinhHuong,
        "phat_am": phatAm,
        "ngu_phap": nguPhap,
        "nghe": nghe,
        "noi": noi,
        "nkht_gv": nkhtGv,
        "nkht_hv": nkhtHv,
        "mau": mau,
        "note": note,
        "content": content,
        "maGV": maGV,
      };

  Map<String, dynamic> toDataSheet() => {
        "index": id,
        "Owner id": ownerId,
        "Ma lop": maLop,
        "shv danh sach": shvDanhSach,
        "shv toi da": shvToiDa,
        "shv bo sung": shvBoSung,
        "tong hv dang hoc": tongHvDangHoc,
        "giao vien hien tai": giaoVienHienTai,
        "ma giao vien": maGV,
        "ngay khai giang": ngayKhaiGiang,
        "dinh huong": dinhHuong,
        "phat am": phatAm,
        "ngu phap": nguPhap,
        "nghe": nghe,
        "noi": noi,
        "nkht gv": nkhtGv,
        "nkht hv": nkhtHv,
        "mau": mau,
        "note": note,
        "content": content,
      };
}
