import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/custom_buttonauth.dart';
import '../widgets/custom_buttongoogle.dart';
import '../widgets/custom_forgotpassword.dart';
import '../widgets/custom_question.dart';
import '../widgets/custom_subtitlepage.dart';
import '../widgets/custom_textform.dart';
import '../widgets/custom_title.dart';
import '../widgets/custom_titlepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /* ========= Business Logic ========= */
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  bool isLoading = false;

  void login(String email, String password) async {
    if (formStateKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          isLoading = false;
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please verify your email address to login.")));
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        setState(() {});
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No user found for that email.")));
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Wrong password provided for that user.")));
          // print('Wrong password provided for that user.');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      }
    }
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    }
  }

  void resetPassword(String email) async {
    try {
      if (emailController.text.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You received email for reset password")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "There is no user record corresponding to this identifier")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: [
                Form(
                  key: formStateKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      const CustomTitlePage(title: "Login"),
                      const SizedBox(height: 10),
                      const CustomSubtitlePage(
                          subtitle: "Login To Continue Using The App"),
                      const SizedBox(height: 20),
                      const CustomTitle(text: "Email"),
                      const SizedBox(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Email",
                        mycontroller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const CustomTitle(text: "Password"),
                      const SizedBox(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Password",
                        mycontroller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your password";
                          }
                          return null;
                        },
                      ),
                      CustomForgotPassword(onTap: () {
                        resetPassword(emailController.text);
                      }),
                    ],
                  ),
                ),
                CustomButtonAuth(
                    title: "login",
                    onPressed: () {
                      login(emailController.text, passwordController.text);
                    }),
                const SizedBox(height: 20),
                CustomButtonGoogle(onPressed: () {
                  signInWithGoogle();
                }),
                const SizedBox(height: 20),
                CustomQuestion(
                    question: "Don't Have An Account ? ",
                    answer: "Register",
                    onTap: () {
                      Navigator.of(context).pushNamed("register");
                    }),
              ]),
      ),
    );
  }
}
