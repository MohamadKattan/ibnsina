import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnsina/bloc_auth/auth_event.dart';
import 'package:ibnsina/repos/auth_service.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc <AuthEvent,AuthStates>{
  AuthService _authService;
  AuthBloc(AuthStates initialState,this._authService) : super(initialState);

  @override
  Stream<AuthStates> mapEventToState(AuthEvent event) async*{
    if(event is CreateNewAccount){
      yield Loading();
      try{
      // await  _authService.createUserWithEmailAndPassword(email, password)
      }catch(ex){
        yield ErrorState(
         msg: ex.toString(),
        );
      }
    }else if (event is SignInByAccount ){
      yield Loading();
      try{
      // await  _authService.startSignInWithEmailAndPassword(email, password)
      }catch(ex){
        yield ErrorState(
          msg: ex.toString(),
        );
      }
    }
  }
}