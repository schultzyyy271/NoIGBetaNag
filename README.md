# NoIGBetaNag

Kills the Instagram TestFlight beta update popup ("It's time to update Instagram Beta") **and** the recurring "Introducing Instants" walkthrough popup that appears every time you open the DMs tab.

Useful when sideloading decrypted Instagram IPAs sourced from TestFlight builds.

## What it hooks

### TestFlight Beta Nag

| Class | Method | Action |
|---|---|---|
| `IGTestFlightNagController` | `init` | Returns nil |
| `IGTestFlightUpdateNagController` | `init`, `start` | Returns nil / no-op |
| `IGTestFlightCheckForUpdatesBackgroundJob` | `performWithCompletion:` | Completes immediately |
| `IGCoreRootTestFlightNagPlugin` | `start`, `didBecomeActive` | No-op |
| `TestFlightUpdateNudgeViewController` | `viewDidLoad`, `viewWillAppear:` | No-op |
| `IGTestFlightBuildGate` | `shouldGate` | Returns NO |

### "Introducing Instants" DM Popup

| Class | Method | Action |
|---|---|---|
| `IGQuickSnapNuxStore` | `hasSeenWalkthroughNux` | Returns YES |
| `IGQuickSnapNuxStore` | `hasSeenNux` | Returns YES |
| `IGQuickSnapNuxStore` | `hasSeenDirectDialogNux` | Returns YES |

Instagram checks `IGQuickSnapNuxStore` before showing the "Introducing Instants" walkthrough. On sideloaded builds the seen-state doesn't persist, so the popup reappears every time you open DMs. These hooks always report the walkthrough as already seen, so Instagram skips it. Instants functionality is unaffected.

### Catch-all

`UIViewController` `presentViewController:animated:completion:` — blocks any VC with `TestFlight` or `UpdateNudge` in the class name.

## Requirements

- [Theos](https://theos.dev) with iOS 16.5+ SDK
- CydiaSubstrate (included in most sideload injection tools)

## Building

```bash
make clean && make
```

Output: `.theos/obj/debug/NoIGBetaNag.dylib`

The Makefile automatically rewrites the CydiaSubstrate load path to `@executable_path/Frameworks/` for sideloaded apps. Works on both Linux (Theos toolchain) and macOS.

## Injecting

Add `NoIGBetaNag.dylib` to the Instagram IPA's `Frameworks/` directory alongside `CydiaSubstrate.framework` and inject an `LC_LOAD_DYLIB` load command pointing to `@executable_path/Frameworks/NoIGBetaNag.dylib`.
