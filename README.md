# NoIGBetaNag

Kills the Instagram TestFlight beta update popup ("It's time to update Instagram Beta").

## What it does

Hooks three Instagram classes to prevent the TestFlight update nag from appearing:

- `IGTestFlightNagController` — returns nil on init
- `IGTestFlightUpdateNagController` — returns nil on init, blocks start
- `IGTestFlightCheckForUpdatesBackgroundJob` — completes immediately without checking

## Building

Requires [Theos](https://theos.dev) with an iOS 16.5+ SDK.

```bash
make clean && make
```

Output: `.theos/obj/debug/NoIGBetaNag.dylib`

## Usage

Inject the dylib into a decrypted Instagram IPA alongside CydiaSubstrate. The Makefile automatically fixes the CydiaSubstrate load path for sideloading (`@executable_path/Frameworks/`).

## Notes

- The Makefile uses `install_name_tool` from the Theos Linux toolchain to rewrite the CydiaSubstrate path for sideloaded apps
- If building on macOS, replace the `after-` rule path with just `install_name_tool`
