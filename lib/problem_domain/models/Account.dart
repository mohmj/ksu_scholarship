import 'package:cloud_firestore/cloud_firestore.dart';

class Account {


  String uid; // Database ID of the user
  bool isSuperAdmin;
  bool isAdmin;
  String universityID;
  String nameAr;
  String nameEn;
  String email; // Use the university by default .
  bool gender; // 0 is male and 1 is female .
  String nationality;
  String country;
  Timestamp dateOfBirth;
  String iqamaNumber;
  Timestamp iqamaExpireDate;
  String phoneNumber;
  double GPA; // total GPA .
  String degree;
  String college;
  String department;
  int level; // Change to int later .
  String academicStatus; // Change to enum later .
  String housingType;

  // Map<String, int> housingInfo; //
  bool familyInSaudiArabia;
  int numberOfFamily;
  String addressInCountry;
  String phoneInCountry;

  Account(
      String uid,bool isSuperAdmin,bool isAdmin,String universityId,String nameAr,String nameEn,String email,bool gender,String nationality,String country,Timestamp dateOfBirth,String iqamaNumber,Timestamp iqamaExpDate,String phoneNumber,double GPA,String degree,String college,String department,int level,String academicStatus,String housingType,bool familyInSaudiArabia,int numberOfFamily,String addressInCountry,String phoneInCountry){
    this.uid=uid;
    this.isSuperAdmin = isSuperAdmin;
    this.isAdmin = isAdmin;
    this.universityID=universityId;
    this.nameAr=nameAr;
    this.nameEn=nameEn;
    this.email=email;
    this.gender=gender;
    this.nationality=nationality;
    this.country=country;
    this.dateOfBirth=dateOfBirth;
    this.iqamaNumber=iqamaNumber;
    this.iqamaExpireDate=iqamaExpireDate;
    this.phoneNumber=phoneNumber;
    this.GPA=GPA;
    this.degree=degree;
    this.college=college;
    this.department=department;
    this.level=level;
    this.academicStatus=academicStatus;
    this.housingType=housingType;
    // this.housingInfo,
    this.familyInSaudiArabia=familyInSaudiArabia;
    this.numberOfFamily = numberOfFamily;
    this.addressInCountry=addressInCountry;
    this.phoneInCountry=phoneInCountry;
  }
  // User(
  //     {
  //     this.uid,
  //     this.isSuperAdmin = false,
  //     this.isAdmin = false,
  //     this.universityID,
  //     this.nameAr,
  //     this.nameEn,
  //     this.email,
  //     this.gender,
  //     this.nationality,
  //     this.country,
  //     this.dateOfBirth,
  //     this.iqamaNumber,
  //     this.iqamaExpireDate,
  //     this.phoneNumber,
  //     this.GPA,
  //     this.degree,
  //     this.college,
  //     this.department,
  //     this.level,
  //     this.academicStatus,
  //     this.housingType,
  //     // this.housingInfo,
  //     this.familyInSaudiArabia,
  //     this.numberOfFamily = 0,
  //     this.addressInCountry,
  //     this.phoneInCountry
  //     }
  //     );


  Account.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    isSuperAdmin = data['isSuperAdmin'];
    isAdmin = data['isAdmin'];
    universityID = data['universityID'];
    nameAr = data['nameAr'];
    nameEn = data['nameEn'];
    email = data['email'];
    gender = data['gender'];
    nationality = data['nationality'];
    country = data['country'];
    dateOfBirth = data['dateOfBirth'];
    iqamaNumber = data['iqamaNumber'];
    iqamaExpireDate = data['iqamaExpireDate'];
    phoneNumber = data['phoneNumber'];
    GPA = data['GPA'];
    degree = data['degree'];
    college = data['college'];
    department = data['department'];
    level = data['level'];
    academicStatus = data['academicStatus'];
    housingType = data['housingType'];
    // housingInfo=data['housingInfo'];
    familyInSaudiArabia = data['familyInSaudiArabia'];
    numberOfFamily = data['numberOfFamily'];
    addressInCountry = data['addressInCountry'];
    phoneInCountry = data['phoneInCountry'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "isSuperAdmin": isSuperAdmin,
      "isAdmin": isAdmin,
      "universityID": universityID,
      "nameAr": nameAr,
      "nameEn": nameEn,
      "email": email,
      "gender": gender,
      "nationality": nationality,
      "country": country,
      "dateOfBirth": dateOfBirth,
      "iqamaNumber": iqamaNumber,
      "iqamaExpireDate": iqamaExpireDate,
      "phoneNumber": phoneNumber,
      "GPA": GPA,
      "degree": degree,
      "college": college,
      "department": department,
      "level": level,
      "academicStatus": academicStatus,
      "housingType": housingType,
      // "housingInfo":housingInfo,
      "familyInSaudiArabia": familyInSaudiArabia,
      "numberOfFamily": numberOfFamily,
      "addressInCountry": addressInCountry,
      "phoneInCountry": phoneInCountry
    };
  }
}