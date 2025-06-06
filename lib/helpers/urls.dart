class URL {
  static const String authBaseUrl = 'http://localhost:8002/api/auth';
  static const String loginUrl = '$authBaseUrl/login';
  static const String registerUrl = '$authBaseUrl/register';
  static const String refreshUrl = '$authBaseUrl/refresh';
  static const String verifyUrl = '$authBaseUrl/verify';

  static const String nodeBaseUrl = 'http://localhost:8002/api/nodes';
  static const String getNodeUrl = nodeBaseUrl;
  static const String getNodeByIdUrl = '$nodeBaseUrl/';
  static const String createNodeUrl = nodeBaseUrl;
  static const String updateNodeUrl = '$nodeBaseUrl/';

  static const String invitationBaseUrl = 'http://localhost:8002/api/invitations';
  static const String createInvitationUrl = invitationBaseUrl;
  static const String useInvitationUrl = '$invitationBaseUrl/';


}