import 'package:deliverabl1task_2/screens/main_screen.dart';
import 'package:deliverabl1task_2/services/users.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:deliverabl1task_2/screens/login_register.dart';
import 'package:provider/provider.dart';
import 'package:deliverabl1task_2/external/oauth_lib/src/authorization_code_grant.dart'
    as auth;

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var token = Uri(path: 'https://oauth.fatsecret.com/connect/token');
    var endpoint = Uri(path: 'https://oauth.fatsecret.com/resources');
    String ident = 'ea55506eb43a43c1a1c5a22f3fea8b7f';
    String secre = 'a6c58822b9ca467782cd058675189781';
    Uri redirect = Uri(path: 'https://platform.fatsecret.com/rest/server.api');

    auth.AuthorizationCodeGrant info = auth.AuthorizationCodeGrant(ident, endpoint, token,
      secret: secre,
      basicAuth: true,
      
     // getParameters: (contentType, body) {},
    );

    Uri aux = info.getAuthorizationUrl(redirect);
    AuthUser? user = Provider.of<AuthUser?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const MainScreen() : const AuthorizationPage();
  }
}
