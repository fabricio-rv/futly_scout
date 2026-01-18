/// UserProfile model representing a scout user in the Futly Scout app.
class UserProfile {
  final String id;
  final String name;
  final String email;
  final bool onboardingCompleted;
  final bool isClubMember;
  final String? organizationId;
  final String? organizationName;
  final String? clubBadgeUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.onboardingCompleted,
    required this.isClubMember,
    this.organizationId,
    this.organizationName,
    this.clubBadgeUrl,
  });

  /// Create a copy of UserProfile with optional field overrides.
  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    bool? onboardingCompleted,
    bool? isClubMember,
    String? organizationId,
    String? organizationName,
    String? clubBadgeUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      isClubMember: isClubMember ?? this.isClubMember,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      clubBadgeUrl: clubBadgeUrl ?? this.clubBadgeUrl,
    );
  }

  /// Convert UserProfile to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'onboardingCompleted': onboardingCompleted,
      'isClubMember': isClubMember,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'clubBadgeUrl': clubBadgeUrl,
    };
  }

  /// Create UserProfile from JSON.
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      isClubMember: json['isClubMember'] as bool? ?? false,
      organizationId: json['organizationId'] as String?,
      organizationName: json['organizationName'] as String?,
      clubBadgeUrl: json['clubBadgeUrl'] as String?,
    );
  }

  @override
  String toString() =>
      'UserProfile(id: $id, name: $name, email: $email, onboardingCompleted: $onboardingCompleted, isClubMember: $isClubMember, organizationName: $organizationName)';
}
