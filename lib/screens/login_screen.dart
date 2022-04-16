import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpapers/drawer_screen.dart';
import 'package:wallpapers/screens/register_screen.dart';
import 'package:wallpapers/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
 
 static const String path_id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  String _email = "";
  String _password = "";

  final _auth = FirebaseAuth.instance;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to Wallpaper',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const SizedBox(
                height: 32,
              ),
              // PrimaryButton(
              //   buttonColor: primaryBlue,
              //   textValue: 'Login',
              //   textColor: Colors.white,
              // ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(24.0),
                    color: const Color(0xff2972ff),
                    child: MaterialButton(
                      textColor: Colors.white,
                      minWidth: 300,
                      height: 56.0,
                      onPressed: () async {
                        setState(() {
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: _email, password: _password);
                          if (user != null) {
                            Navigator.pushNamed(context, DrawerScreen.path_id);
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                        });
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xff2972ff),
                  child: MaterialButton(
                    textColor: Colors.white,
                    minWidth: 300,
                    height: 56,
                    //როდესაც ბათონზე დააჭერს მომხმარებელი გამოიტან
                    //google-ის ლოგინის ფანჯარას რომლითაც
                    //მომხმარებელს შეეძლება დალოგინდეს
                    onPressed: (){
                      signInWithGoogle().then((value) {
                        print(value.user!.uid);
                        Navigator.pushNamed(context, LoginScreen.path_id);
                      });
                    },
                    child: const Text('Login With Google'),
                  ),
                ),
                ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  //აქ goole-დან ვლოგინდებით,გავდივართ აუთენტიპიკაციას
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;
//credential-ით ვეუბნებით,რომ კლიენტს აქვს რესურსზე წვდომის უფლება
//ამ რესურსის მფლობელის idToken-ით მაგალითად
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}