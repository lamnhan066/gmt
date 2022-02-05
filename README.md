# GMT

Get current DateTime in GMT from internet (example.com or google.com) and return DateTime in UTC.

This package provides an easy way to get the current DateTime in UTC from the internet. It will get DateTime from the headers of <https://example.com> as primary and <https://google.com> if the primary gives error.

Usage:

``` dart
var now = await GMT.now();
```

If you want to get local DateTime if it gives error then using (default is return `null`):

``` dart
var now = await GMT.now(returnLocalIfError: true); // Default is false
```

You can also set a timeout for it by using:

``` dart
var now = await GMT.now(returnLocalIfError: true, timeout: const Duration(seconds: 5)); // Default is false
```
