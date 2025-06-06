class URL {
  static const String authBaseUrl = 'http://10.0.2.2:8080/api/auth';
  static const String loginUrl = '$authBaseUrl/login';
  static const String registerUrl = '$authBaseUrl/register';
  static const String refreshUrl = '$authBaseUrl/refresh';
  static const String verifyUrl = '$authBaseUrl/verify';

  static const String nodeBaseUrl = 'http://10.0.2.2:8080/api/nodes';
  static const String getNodeUrl = nodeBaseUrl;
  static const String getNodeByIdUrl = '$nodeBaseUrl/';
  static const String createNodeUrl = nodeBaseUrl;
  static const String updateNodeUrl = '$nodeBaseUrl/';

  static const String invitationBaseUrl = 'http://10.0.2.2:8080/api/invitations';
  static const String createInvitationUrl = invitationBaseUrl;
  static const String useInvitationUrl = '$invitationBaseUrl/';

  static const String spaceBaseUrl = "https://space-member.onrender.com";
  static const String spaceUrl = '${spaceBaseUrl}/api/spaces';
  static const String spaceNodeUrl = '${spaceBaseUrl}/api/nodes';
  static const String spaceMemberUrl = '${spaceBaseUrl}/api/spaces';
  static const String spaceDiscussionUrl = '${spaceBaseUrl}/api/discussions';
  static const String spaceMessageUrl = '${spaceBaseUrl}/api/messages';
  static const String spaceEventUrl = '${spaceBaseUrl}/api/events';
  static const String spaceMediaUrl = '${spaceBaseUrl}/api/medias';
}