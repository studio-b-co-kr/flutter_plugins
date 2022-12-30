This package is a wrapper of dio


How to use.

1. Implement ApiService<T>
  ```dart
  class GoogleApiService extends ApiService<GoogleData> {
      GoogleApiService()
          : super(
              request: DioRequest(
                builder: DioBuilder.json(
                  baseUrl: 'https://www.googleapis.com',
                ),
              ),
            );

      get() async {
        return requestGet(path: '/books/v1/volumes', queries: {'q': '{http}'});
      }

      @override
      GoogleData? fromJson(json) {
        return GoogleData.fromJson(json);
      }

      @override
      HttpError onError(HttpError error) {
        // TODO: customize error data.
        return super.onError(error);
      }
  }

  class GoogleData extends IDto {
      // TODO add properties.
      GoogleData();

      static GoogleData? fromJson(json) {
        return GoogleData();
      }
  }
  ```
  
2. Use the api.
  ```dart
  var res = await GoogleApiService().get();
  if(res is HttpError) {
    // TODO Handle error case
    return;
  }
  
  // TODO handle success case;
  ```
  return;
