import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calliverse/Constants/int_extensions.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../Components/common.dart';
import '../Constants/app_config.dart';
import '../utils/app_constants.dart';

Map<String, String> buildHeaderTokens() {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
  };

  // if (userStore.isLoggedIn || getBoolAsync(IS_SOCIAL)) {
  /// Token add krna
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer token');
  // }
  log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$mBaseUrl$endPoint');

  log('URL: ${url.toString()}');

  return url;
}

// Future<Response> buildHttpResponse(String endPoint, {HttpMethod method = HttpMethod.GET, Map? request,bool?isChooseSimpleHeader}) async {
//   if (await isNetworkAvailable()) {
//     var headers = isChooseSimpleHeader != null && isChooseSimpleHeader == true? {
//       'Content-Type': 'application/json'
//     }: buildHeaderTokens();
//     // var headers2 = {
//     //   'Content-Type': 'application/json'
//     // };
//     Uri url = buildBaseUrl(endPoint);
//
//     Response response;
//
//     if (method == HttpMethod.POST) {
//       log('Request: $request');
//       response = await http.post(url, body: jsonEncode(request), headers: headers);
//     }
//     else if (method == HttpMethod.PATCH) {
//       log('Request: $request');
//       response = await http.patch(url, body: jsonEncode(request), headers: headers);
//     } else if (method == HttpMethod.DELETE) {
//       response = await delete(url, headers: headers);
//     } else if (method == HttpMethod.PUT) {
//       response = await put(url, body: jsonEncode(request), headers:  headers);
//     }else {
//       response = await get(url, headers: headers);
//     }
//
//     log('Responsess ($method): ${response.statusCode} ${jsonDecode(response.body)}');
//
//     return response;
//   } else {
//     throw "errorInternetNotAvailable";
//   }
// }
////My Code
Future<http.Response> buildHttpResponse(
    String endPoint, {
      HttpMethod method = HttpMethod.GET,
      Map<String, dynamic>? request,
      bool? isChooseSimpleHeader,
      Map<String, String>? fields,
      File? file,
    }) async {
  if (await isNetworkAvailable()) {
    var headers = isChooseSimpleHeader == true
        ? {
      'Content-Type': 'application/json',
    }
        : buildHeaderTokens();

    Uri url = buildBaseUrl(endPoint);
    http.Response response;

    if (method == HttpMethod.POST) {
      log('Request: $request');
      response = await http.post(url, body: jsonEncode(request), headers: headers);
    } else
    //   if (method == HttpMethod.PATCH) {
    //   log('Multipart PATCH Request');
    //   headers.remove('Content-Type'); // Do not set Content-Type manually for multipart
    //   var multipartRequest = http.MultipartRequest('PATCH', url);
    //   multipartRequest.headers.addAll(headers);
    //
    //   if (fields != null) {
    //     multipartRequest.fields.addAll(fields);
    //   }
    //
    //   http.StreamedResponse streamedResponse = await multipartRequest.send();
    //
    //   String responseBody = await streamedResponse.stream.transform(utf8.decoder).join();
    //   response = http.Response(responseBody, streamedResponse.statusCode);
    // }
    if (method == HttpMethod.PATCH) {
      headers.remove('Content-Type'); // Avoid setting it manually for multipart
      var multipartRequest = http.MultipartRequest('PATCH', url);
      multipartRequest.headers.addAll(headers);

      if (fields != null) {
        multipartRequest.fields.addAll(fields);
      }

      // Add the file, if it exists
      if (file != null) {
        multipartRequest.files.add(
            await http.MultipartFile.fromPath(
              'profileImage',
              file.path,
              contentType: MediaType('image', 'jpeg'), // or 'image/png' if appropriate
            )
        );
      }

      http.StreamedResponse streamedResponse = await multipartRequest.send();
      String responseBody = await streamedResponse.stream.transform(utf8.decoder).join();

      // Construct the response with UTF-8 encoding
      response = http.Response.bytes(
        utf8.encode(responseBody),
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
      );
    }


    else if (method == HttpMethod.DELETE) {
      response = await http.delete(url, headers: headers);
    } else if (method == HttpMethod.PUT) {
      response = await http.put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await http.get(url, headers: headers);
    }

    log('Response ($method): ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw "errorInternetNotAvailable";
  }
}

// Future<http.Response> buildHttpResponse(
//     String endPoint, {
//       HttpMethod method = HttpMethod.GET,
//       Map<String, dynamic>? request,
//       bool? isChooseSimpleHeader,
//       Map<String, String>? fields,
//       File? file,
//     }) async {
//   if (await isNetworkAvailable()) {
//     var headers = isChooseSimpleHeader == true
//         ? {
//       'Content-Type': 'application/json',
//     }
//         : buildHeaderTokens();
//
//     Uri url = buildBaseUrl(endPoint);
//     http.Response response;
//
//     if (method == HttpMethod.POST) {
//       log('Request: $request');
//       response = await http.post(url, body: jsonEncode(request), headers: headers);
//     } else if (method == HttpMethod.PATCH) {
//       // Handling multipart PATCH
//       log('Multipart PATCH Request');
//       print("object 88 ${fields} == ${file?.path}");
//       var multipartRequest = http.MultipartRequest('PATCH', url);
//       // Ensure Content-Type is not manually set for multipart
//       headers.remove('Content-Type');
//       multipartRequest.headers.clear();
//       multipartRequest.headers.addAll(headers);
//
//       // Add fields
//       if (fields != null) {
//         multipartRequest.fields.addAll(fields);
//       }
//       log('Headers: ${multipartRequest.headers}');
//       log('Fields: ${multipartRequest.fields}');
//       log('Files: ${multipartRequest.files}');
//       log('file: ${file?.path}');
//
//       // Add file
//       // if (file != null && file.existsSync()) {
//       //   multipartRequest.files.add(
//       //     await http.MultipartFile.fromPath('profileImage', file.path),
//       //   );
//       // } else {
//       //   log('File does not exist or is not accessible: ${file?.path}');
//       //   throw Exception('File does not exist.');
//       // }
//
//       http.StreamedResponse streamedResponse = await multipartRequest.send();
//
//       // Convert streamed response to a standard response
//       String responseBody = await streamedResponse.stream.bytesToString();
//       response = http.Response(responseBody, streamedResponse.statusCode);
//     } else if (method == HttpMethod.DELETE) {
//       response = await http.delete(url, headers: headers);
//     } else if (method == HttpMethod.PUT) {
//       response = await http.put(url, body: jsonEncode(request), headers: headers);
//     } else {
//       response = await http.get(url, headers: headers);
//     }
//
//     log('Response ($method): ${response.statusCode} ${response.body}');
//
//     return response;
//   } else {
//     throw "errorInternetNotAvailable";
//   }
// }

@deprecated
Future<Response> getRequest(String endPoint) async => buildHttpResponse(endPoint);

@deprecated
Future<Response> postRequest(String endPoint, Map<String,dynamic> request) async => buildHttpResponse(endPoint, request: request, method: HttpMethod.POST);

Future handleResponse(Response response) async {
  if (!await isNetworkAvailable()) {
    throw "Internet Not Available";
  }

  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    var string = await (isJsonValid(response.body));
    print("jsonDecode(response.body)" + string.toString());
    if (string!.isNotEmpty) {
      print("exceptionThrow -> $string");
      throw string;
    } else {
      print("exceptionThrowStringEmpty -> $string");
      throw 'Please try again later.';
    }
  }
}

//region Common
enum HttpMethod { GET, POST, DELETE, PUT, PATCH }

class TokenException implements Exception {
  final String message;

  const TokenException([this.message = ""]);

  String toString() => "FormatException: $message";
}
//endregion

Future<String?> isJsonValid(json) async {
  try {
    var f = jsonDecode(json) as Map<String, dynamic>;
    return f['message'];
  } catch (e) {
    log(e.toString());
    return "";
  }
}

Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  log(url);
  return MultipartRequest('POST', Uri.parse(url));
}

Future<void> sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  http.Response response = await http.Response.fromStream(await multiPartRequest.send());
  print("Result: ${response.body}");

  if (response.statusCode.isSuccessful()) {
    onSuccess?.call(response.body);
  } else {
    onError?.call("Something Went Wrong");
  }
}
