# GMT

Get current datetime in GMT from internet (example.com, google.com or your own urls) and return DateTime in UTC.

This package provides an easy way to get the current DateTime in UTC from the internet. It will get DateTime from the headers of the URLs. On web platform, the package will use headers from current URL to avoid CORS error.

You can also use this package to check if there is real internet connection.

Usage:

``` dart
var now = await GMT.now();
```

You can create your own list of URLs and timout of each URL:

``` dart
var now = GMT.now(
    urls: ['https://www.your-server.com'],
    timeoutOfEach: const Duration(seconds: 1),
    );
```

If you want to get local DateTime if it gives error or timeout then using (default is return `null`):

``` dart
var now = await GMT.now(returnLocalIfError: true); // Default is false
```

You can also set a timeout for this whole function by using:

``` dart
var now = await GMT.now(timeout: const Duration(seconds: 5));
```

Default URLs:

* 1.1.1.1
* 1.0.0.1
* 8.8.8.8
* 8.8.4.4
* example.com
