import 'package:dio/dio.dart';
import '../../configs/injector/init_dependencies.dart';
import '../../main.dart';
import '../network/api.dart';
import '../secrets/secure_storage.dart';
import '../utils/show_snackbar.dart';
import 'connection_checker.dart';
import 'network_response_model.dart';

// Define the HTTP method enum
enum HttpMethod { GET, POST, PUT, DELETE, PATCH }

// NetworkRequest class to handle API calls
class NetworkRequest {
  static Dio _dio = getDio();
  static CancelToken cancelToken = CancelToken(); // Create a global cancel token

  // Initialize Dio with certificate validation bypassed
  static Dio getDio() {
    _dio = Dio();

    // Use IOHttpClientAdapter for overriding HttpClient behavior
    // _dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     HttpClient client = HttpClient();
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) =>
    //     true; // Bypass SSL validation
    //     return client;
    //   },
    // );
    return _dio;
  }

  // Static method to send HTTP requests
  static Future<NetworkResponseModel> sendHTTPRequest(
      String url, {
        required HttpMethod method,
        Map<String, dynamic>? payload,
        Map<String, dynamic>? queryParams,
      }) async {

    await _isInternetConnected();

    // Set headers with Bearer token
    final token = await SecureStore.getToken();
    final options = Options(
      headers: {
        'Authorization': token != null ? 'Bearer $token' : null,
        'Content-Type': 'application/json',
      },
    );

    _dio.options.validateStatus = (status) {
      return true; // Accept all status codes
    };

      Response response;

      // Perform the request based on the HTTP method
      switch (method) {
        case HttpMethod.GET:
          response = await _dio.get(url, queryParameters: queryParams, options: options, cancelToken: cancelToken);
          break;
        case HttpMethod.POST:
          response = await _dio.post(url, data: payload, options: options, cancelToken: cancelToken);
          break;
        case HttpMethod.PUT:
          response = await _dio.put(url, data: payload, options: options, cancelToken: cancelToken);
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(url, data: payload, options: options, cancelToken: cancelToken);
          break;
        case HttpMethod.PATCH:
          response = await _dio.patch(url, data: payload, options: options, cancelToken: cancelToken);
          break;
        }

    _printRequestOptions(response.requestOptions);

    try {
      print("Response: ${response.data.toString()}");
      final NetworkResponseModel networkResponse = NetworkResponseModel.fromJson(response.data);
      if ((networkResponse.responseCode == 1002 || networkResponse.responseCode == 1003) && (globalNavigatorKey.currentContext != null)) {
        cancelToken.cancel();
        // serviceLocator<SideMenuVM>().navToLogin(globalNavigatorKey.currentContext!);
        _showToastOnFailure(message: 'Session Expired. Please login again');
      }
      _showToastOnFailure(networkResponse: networkResponse);
      if (networkResponse.responseCode != null && networkResponse.responseCode != 2000) throw "${networkResponse.message}";
      return networkResponse;
    } catch (e) {
      print("NetworkResponse 6");
      _showToastOnFailure(message: response.data['message'].toString());
      throw response.data['message'].toString(); // errorMessage, response.data['message'].toString();
    }
  }

  // New function to send HTTP requests with FormData
  static Future<NetworkResponseModel> sendHTTPRequestWithFormData(
      String url, {
        required HttpMethod method,
        required FormData payload,
        Map<String, dynamic>? queryParams,
        bool isLoginRequest = false,
      }) async {

    await _isInternetConnected();

    // Set headers with Bearer token
    final token = await SecureStore.getToken();
    final options = Options(
      headers: {
        'Authorization': token != null ? 'Bearer $token' : null,
        'Content-Type': 'application/json',
      },
    );
    print("URL: $url");
    print(payload.toString());
    print("token: $token");

    // Configure Dio to allow all status codes to be valid
    _dio.options.validateStatus = (status) {
      return true; // Accept all status codes
    };

      Response response;

      // Perform the request based on the HTTP method
      switch (method) {
        case HttpMethod.POST:
          response = await _dio.post(url, data: payload, queryParameters: queryParams, options: options, cancelToken: cancelToken);
          break;
        case HttpMethod.PUT:
          response = await _dio.put(url, data: payload, queryParameters: queryParams, options: options, cancelToken: cancelToken);
          break;
        default:
          _showToastOnFailure(message: 'Method not supported for FormData');
          throw UnsupportedError('Method not supported for FormData');
      }

    _printRequestOptions(response.requestOptions);
    try {
      print("Response: ${response.data.toString()}");
      final NetworkResponseModel networkResponse = NetworkResponseModel.fromJson(response.data);
      if ((networkResponse.responseCode == 1002 || networkResponse.responseCode == 1003) && (globalNavigatorKey.currentContext != null)) {
        cancelToken.cancel();
        // serviceLocator<SideMenuVM>().navToLogin(globalNavigatorKey.currentContext!);
        _showToastOnFailure(message: 'Session Expired. Please login again');
      }
      _showToastOnFailure(networkResponse: networkResponse);
      if (networkResponse.responseCode != null && networkResponse.responseCode != 2000) throw "${networkResponse.message}";
      return networkResponse;
    } catch (e) {
      _showToastOnFailure(message: response.data.toString() + e.toString());
      throw response.data.toString() + e.toString(); // errorMessage, response.data['message'].toString();
    }
  }

  static void _printRequestOptions(RequestOptions options) {
    print('Method: ${options.method}');
    print('URL: ${options.uri}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    print('Query Parameters: ${options.queryParameters}');
  }

  static Future<void> _isInternetConnected() async {
    if (await getIt<ConnectionChecker>().isConnected) return;
    _showToastOnFailure(message: 'No Internet! Please check you Internet Connection...');
    throw 'No Internet! Please check you Internet Connection...';
  }

  static void _showToastOnFailure({NetworkResponseModel? networkResponse, String? message}) {
    if (message != null) {
      showSnackBar(message);
      return;
    }
    if (networkResponse?.responseCode != 2000) {
      showSnackBar(networkResponse?.message ?? '');
    }
  }
}

/*

// Helper method to handle responses
  static NetworkResponse _handleResponse(
      String url,
      Response response,
      ) {
    // Check for successful HTTP response
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      // Check if the response body contains an error or failure condition
      if (response.data is Map<String, dynamic> && response.data['error'] != null) {
        print("NetworkResponse 1");
        throw response.data['error'];  // Error message from the server response
      }

      // Handle login-specific cases
      if (url == API.login) {
        var jsonResponse = response.data;
        try {
          if (jsonResponse != null) {
            print("NetworkResponse 2");
            final res = NetworkResponse.fromJson(response.data);
            final user = User.fromJson(res.data);
            return res;
          }
        } catch (e) {
          // Handle parsing failure gracefully
          print("NetworkResponse 3");
          throw response.data['message']; //'Failed to parse login response: ${e.toString()}';
        }
      }

      // If everything is okay, parse and return the successful response
      print("NetworkResponse 4 ${response.data.toString()}");
      print(response.data.runtimeType);
      return NetworkResponse.fromJson(response.data);
    } else {
      // Handle non-2xx status codes (server-side errors)
      print("NetworkResponse 5");
      throw response.data["message"]; // response.statusMessage;
    }
  }

  // Function to handle Dio exceptions
  static String _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate. Please check your SSL certificate.';
      case DioExceptionType.badResponse:
        return 'Server responded with an error: ${e.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'Request to the server was cancelled.';
      case DioExceptionType.unknown:
        return 'No internet connection or server is down.'; // response.data.toString(); //
      default:
        return e.toString();
    }
  }

 */