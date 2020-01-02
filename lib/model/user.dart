
class User{
  String email, password, displayName, personURL = '0';
  int zip;

  String uid;

  User({
    this.password,
    this.email,
    this.displayName,
    this.zip,
    this.uid,
    this.personURL,
  });

  Map<String, dynamic> serialize(){
    return <String, dynamic>{
      EMAIL: email,
      DISPLAYNAME: displayName,
      ZIP: zip,
      UID: uid,
      IMAGE: personURL,
    };
  }

  static User deserialize(Map<String, dynamic> document){
    return User(
      email: document[EMAIL],
      displayName: document[DISPLAYNAME],
      zip: document[ZIP],
      uid: document[UID],
      personURL: document[IMAGE],
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const DISPLAYNAME = 'displayName';
  static const ZIP = 'zip';
  static const UID = 'uid';
  static const IMAGE = 'personURL';
  
  
}