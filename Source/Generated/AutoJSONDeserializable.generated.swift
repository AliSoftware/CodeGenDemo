// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



extension Avatar: JSONDeserializable {
  init?(json: [String: Any]) {
      self.imageURL = json["imageURL"] as? String
  }
}


extension Contact: JSONDeserializable {
  init?(json: [String: Any]) {
      self.id = json["id"] as? String
      self.firstName = json["firstName"] as? String
      self.lastName = json["lastName"] as? String
      self.dateOfBirth = (json["dateOfBirth"] as? String)
        .flatMap(JSONDateFormatter.date(from:))
      self.avatar = (json["avatar"] as? [String: Any])
        .flatMap(Avatar.init(json:))
  }
}

