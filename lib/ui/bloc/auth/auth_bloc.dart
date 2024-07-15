import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
//import 'package:trust_location/trust_location.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/*
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      
    });
  }
}
*/

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //final objEnvironmentProd = EnvironmentProd();
  //final storage = const FlutterSecureStorage();

  //String _licenseKey = '';
  String _pin = '';

/*
  final AuthRepository authRepository;
  final UserPreferences userPreferences;
  */

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SubmitLicenseKey>(_onSubmitLicenseKey);
    on<SubmitPin>(_onSubmitPin);
    on<ConfirmPin>(_onConfirmPin);
    on<SubmitUsername>(_onSubmitUsername);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    
    /*
    final isLicenseSet = await userPreferences.isLicenseSet();
    
    final isUsernameSet = await userPreferences.isUsernameSet();
    //String tieneToken = await storageAuthBloc.read(key: environmentAuthBloc.tokenApp) ?? '';

    if (isLicenseSet && isUsernameSet) { //&& tieneToken.isNotEmpty) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
    */

    var connectivityResult = await (Connectivity().checkConnectivity());
    
    if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
      emit(AuthNoInternet());
    }
    else {
      emit(AuthAuthenticated());
      /*
      bool isMockLocation = true;
      
      TrustLocation.onChange.listen((values) {

        isMockLocation = values.isMockLocation ?? false;

        if(isMockLocation){
          emit(AuthGpsFake());
        } else {
          emit(AuthAuthenticated());
        }

      }
      
       
      
      );
      */
    }
    
  }

  void _onSubmitLicenseKey(
      SubmitLicenseKey event, Emitter<AuthState> emit) async {
    try {
      /*
      final isValidLicenseKey =
          await authRepository.validateLicenseKey(event.licenseKey);
      if (isValidLicenseKey) {
        _licenseKey = event.licenseKey;
        await userPreferences.setLicense(_licenseKey);
        emit(ValidLicenseKey());
      } else {
        emit(InvalidLicenseKey());
      }
      */
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSubmitPin(SubmitPin event, Emitter<AuthState> emit) async {
    if (event.pin.length == 4) {
      _pin = event.pin;
      emit(PinCompleted());
    } else {
      emit(PinSubmitted());
    }
  }

  void _onConfirmPin(ConfirmPin event, Emitter<AuthState> emit) async {
    if (event.pin != _pin) {
      emit(InvalidPin());
    } else {
      //await userPreferences.setPin(_pin);
      //await storage.write(key: objEnvironmentProd.pin, value: _pin);
      emit(ValidPin());
    }
  }

  void _onSubmitUsername(SubmitUsername event, Emitter<AuthState> emit) async {
    try {
      /*
      final User registeredUser =
          await authRepository.registerUser(event.username, _licenseKey, _pin);

      await userPreferences.setUserId(registeredUser.id);
      await userPreferences.setUsername(registeredUser.name);
      */

      //await storageAuthBloc.write(key: environmentAuthBloc.tokenApp, value: registeredUser.token);

      emit(AuthRegistered());
    } catch (e) {
      emit(AuthError("Ocurrió un error durante el registro"));
    }
  }
}
