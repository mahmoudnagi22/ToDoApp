import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets_manager.dart';
import 'package:to_do_app/core/constant_manager.dart';
import 'package:to_do_app/core/reusable_components/custom_text_form_field.dart';
import 'package:to_do_app/core/routes_manager.dart';
import 'package:to_do_app/core/strings_manager.dart';
import 'package:to_do_app/core/utils/dialog_utils.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004182),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Image.asset(AssetsManager.routLogoPng),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context)!.email,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildEmailFiled(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context)!.password,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    buildPasswordFiled(),

                    SizedBox(height: 12),
                    loginBottom(),
                    registerBottom(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget buildEmailFiled() =>CustomTextFormField(
  hintText: AppLocalizations.of(context)!.enter_your_email,
  validatot: (input) {
    if (input == null || input.trim().isEmpty) {
      return AppLocalizations.of(context)!.enter_yor_password;
    }
    if (input.length < 6) {
      return 'Invalid input';
    }
  },
  controller: emailController,
);

Widget buildPasswordFiled() => CustomTextFormField(
  hintText: AppLocalizations.of(context)!.enter_yor_password,
  validatot: (input) {
    if (input == null || input.trim().isEmpty) {
      return AppLocalizations.of(context)!.enter_yor_password;
    }
    if (input.length < 6) {
      return 'Short password ';
    }
  },
  controller: passwordController,
  isScure: true,
);

Widget loginBottom() => Padding(
  padding: const EdgeInsets.only(top: 10),
  child: MaterialButton(
    padding: EdgeInsets.symmetric(vertical: 18),
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    onPressed: () {
signIp(context);
    },
    child: Text(AppLocalizations.of(context)!.sign_in,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Color(0xFF004182),
        )),
  ),
);

Widget registerBottom() =>  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      AppLocalizations.of(context)!.dont_have_account,
      style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.normal),
    ),
    TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
      },
      child: Text(
        AppLocalizations.of(context)!.sign_up,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline),
      ),
    ),
  ],
);

  void signIp(context) async {
    try {
      DialogUtils.showLoadingDialog(context, message: "Loading...");
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.user = await   getUserFromFireStore(credential.user!.uid);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          content: "User Logged-In now",
          posActionTitle: "ok", posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
          });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);
      String? message;
      if (authError.code == AppConstant.invalidCredential) {
        message = AppConstant.wrongSignInMessage;
      }
      DialogUtils.showMessageDialog(context,
          titel: "Errommmr", content: message, posActionTitle: "ok");
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          titel: "Error", content: e.toString(), posActionTitle: "ok");
    }
  }

  Future<UserDM> getUserFromFireStore(String uid)async{
    CollectionReference collectionReference =FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDoc =  collectionReference.doc(uid);
    DocumentSnapshot documentSnapshot = await userDoc.get();
    var json = documentSnapshot.data() as Map<String , dynamic>;
    return UserDM.fromFireStor(json);
  }
}
