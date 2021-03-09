# remedi_base module

## It has below features.

### 1. provides base http api service & dio wrapper.
### 2. Application configs.
### 3. provides Application ID
### 4. AppContainer.

# Getting Started

#1.  How to use?
 
### A. AppConfig.
 - AppConfig provides application info such as version, build number, build flavor and etc.
 - run AppConfig.init() before runApp();
 - run setFlavorConfig on each entrypoint file(main-dev.dart or main-prod.dart) for product flavor(dev, prod).
 - pass AppContainer() to runApp().

    void main() async {
        WidgetsFlutterBinding.ensureInitialized();

        AppConfig.setFlavorConfig(
            baseUrl: "https://google.com",
            baseWebUrl: "https://naver.com",
            isRelease: kReleaseMode,
            endpoint: "dev",
            enablePrintLog: kReleaseMode,
        );

        // First time, do init()
        await AppConfig.init();
        
        // optional.
        AppConfig.log();
        
        runApp(AppContainer(
                app: MaterialApp(
                home: MyApp(),
            ),
        ));
    }



### B. http Api & others.
    
#### B-1. Http request
 - There are 4 Base Dio wrapper classes for post, get, patch, delete request.

#### B-2. Application unique ID
 - can get application unique id by "AppRepository.appId"

    
    class MyApp extends StatefulWidget {
    @override
        _MyAppState createState() => _MyAppState();
    }
    
    class _MyAppState extends State<MyApp> {
        String _platformVersion = 'Unknown';
    
        @override
        void initState() {
            super.initState();
                initPlatformState();
        }
        
        Future<void> initPlatformState() async {
            String platformVersion;

            platformVersion = await AppRepository.instance.appId;

            if (!mounted) return;

            setState(() {
              _platformVersion = platformVersion;
            });
        }
        
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
                home: Scaffold(
                    appBar: AppBar(
                        title: const Text('Plugin example app'),
                    ),
                    body: FutureBuilder(
                        future: GoogleApiService().request(),
                        builder: (context, snapshot) {
                            String htmlString = 'about:blank';
                            if (snapshot.hasData) {
                                htmlString = snapshot.data;
                            }
                            return ListView(
                                children: [Text(htmlString)],
                            );
                        }),
                ),
            );
        }
    }
        
    class GoogleApiService extends DioGetApiService<String> {
        GoogleApiService({IClientFactory clientFactory})
        : super(clientFactory = DioFactory.noneAuth(AppConfig.baseUrl));
            
        @override
        String get path => "";
        
        @override
        String jsonTo(dynamic json) {
            return json;
        }
    }
            
    class GoogleApiDto extends IDto {
        final String html;
        
        GoogleApiDto({this.html});
        
        @override
        Map<String, dynamic> toJson() {
            return {"data": html};
        }
    }
