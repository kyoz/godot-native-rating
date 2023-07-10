<h1 align="center">
  <br>
  <img src="./icon.png" alt="Godot Native Rating" width=512>
  <br>
  Godot Native Rating
  <br>
</h1>

<h4 align="center">Godot plugin to request Native Rating on Android/iOS. Support Godot 3 & 4</a>.</h4>

<p align="center">
  <a href="https://github.com/kyoz/godot-native-rating/releases">
    <img src="https://img.shields.io/github/v/tag/kyoz/godot-native-rating?label=Version&style=flat-square">
  </a>
  <span>&nbsp</span>
  <a href="https://github.com/kyoz/godot-native-rating/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/kyoz/godot-native-rating/release.yml?label=Build&style=flat-square&color=00ad06">
  </a>
  <span>&nbsp</span>
  <a href="https://github.com/kyoz/godot-native-rating/releases">
    <img src="https://img.shields.io/github/downloads/kyoz/godot-native-rating/total?style=flat-square&label=Downloads&color=de3f00">
  </a>
  <span>&nbsp</span>
  <img src="https://img.shields.io/github/stars/kyoz/godot-native-rating?style=flat-square&color=c99e00">
  <span>&nbsp</span>
  <img src="https://img.shields.io/github/license/kyoz/godot-native-rating?style=flat-square&color=fc7b03">
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#api">API</a> •
  <a href="#notes">Notes</a> •
  <a href="#contribute">Contribute</a> •
  <a href="https://github.com/kyoz/godot-native-rating/releases">Downloads</a> 
</p>

# About

This plugin help request native rating for mobile app (Android/iOS).

Was build using automation scripts combine with CI/CD to help faster the release progress and well as release hotfix which save some of our times.

Support Godot 3 & 4.

# Installation

## Android

Download the [android plugin](https://github.com/kyoz/godot-native-rating/releases) (match your Godot version), extract them to `your_project/android/plugins`

Enable `Rating` plugin in your android export preset

*Note*: You must [use custom build](https://docs.godotengine.org/en/stable/tutorials/export/android_custom_build.html) for Android to use plugins.

## iOS

Download the [ios plugin](https://github.com/kyoz/godot-native-rating/releases) (match your Godot version), extract them to `ios/plugins`

Enable `Rating` plugin in your ios export preset

# Usage

You will need to add an `autoload` script to use this plugin more easily.

Download [autoload file](./autoload) to your game (Choose correct Godot version). Add it to your project `autoload` list.

Then you can easily use it anywhere with:

```gdscript
Rating.init()
Rating.show()

# Godot 3
Rating.connect("on_completed", self, "_on_completed")

# Godot 4
Rating.on_completed.connect(_on_completed)
```

Why have to call `init()`. Well, if you don't want to call init, you can change `init()` to `_ready()` on the `autoload` file. But for my experience when using a lots of plugin, init all plugins on `_ready()` is not a good idea. So i let you choose whenever you init the plugin. When showing a loading scene...etc...

For more detail, see [examples](./example/)

# API

## Methods

```gdscript
void show() # Request and show rating popup
```

## Signals

```gdscript
signal on_error(error_code) # request rating fail, return error_code
signal on_completed() # request and show rating completed
```

## Error Codes

> `ERROR_GOOGLE_PLAY_UNAVAILABLE`

Android only. Happen when there's no Google Play Services on the user phone. Rarely happen. Cause normally, they will install your app through Google Play.

> `ERROR_NO_ACTIVE_SCENE`

iOS only. Happen when the plugin can't find active scene. Make sure you calling `show()` method when the app are runing in foreground.

> `ERROR_UNKNOWN`

Is rarely happen too. On Android, it may happen if the user are in China Mainland, cause they are not allow native rating here. It could also happen if the user install your app from other store but not on Google Play.

# Notes

Testing on iOS is pretty simple, but when testing on Android, you have to publish your app to Google Play Console, at least public it to [Internal Testing](https://play.google.com/console/about/internal-testing/) or else the rating popup will not show.

When calling `show()` method. If you get `on_completed` signal. It's mean the request is complete. There is no need to do anything except some storage caching to not showing it again.

*WARNNING*:

- Do not spaming `show()` method. You better call it after users has completed some levels or after users comeback to your game a few times. And most importantly, after showing, whenever you get `on_completed` or `on_error`. Do not try to show it again, or else your app/game may get reject when Google/Apple review it.

- This plugin is enough for users to rating/review your app. Just call `show()` and done. Do not show Toast or Dialog to tell user rate 5 star for you. They'll reject your game when review.

# Contribute

I want to help contribute to Godot community so i create these plugins. I'v prepared almost everything to help the development and release progress faster and easier.

Only one command and you'll build, release this plugin. Read [DEVELOP.md](./DEVELOP.md) for more information.

If you found bug of the plugin, please open issues.

If you have time to fix bugs or improve the plugins. Please open PR, it's always welcome.

# License

MIT © [Kyoz](mailto:banminkyoz@gmail.com)