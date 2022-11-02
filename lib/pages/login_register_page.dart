import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/pages/start_page.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // testing
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  // testing end

  Future<void> createUserWithEmailAndPassword() async{
    try{
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  
  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  

  Widget _title() {
    return const Text('Welcome to reTHRIFT');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmmm? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: 
        isLogin? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(
        isLogin ? 'Login' : 'Register'
      ),
      );
  }

  Widget _loginOrRegisterButton(){
    return ElevatedButton( //  TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: Colors.blueGrey
      // ),
      child: Text(
        isLogin? 'Register instead' : 'Login instead'
      ),
      
    );
  }

  Widget _orText() {
    return const Text(
      "or ",
      // style: TextStyle(fontStyle: FontStyle.italic)

    );
  }

  Widget _continueAsGuest() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StartPage()));
      },
      child:
        const Text(
          "continue as Guest",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _submitButton(),
                const SizedBox(
                  width: 10, // <-- SEE HERE
                ),
                _loginOrRegisterButton(),
              ],
            ),
            // _submitButton(),
            // _loginOrRegisterButton(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _orText(),
                
                _continueAsGuest(),
            ],
            ),
            
          ],
        )
      )
    );
  }
}