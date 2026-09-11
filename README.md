# librewolf

Portable LibreWolf theming — **Betterfox `152`** + **qutefox-minimal** (compact one-liners + autohide toolbars) — restore your LibreWolf *exactly* every time or push updates.

- **`user.js`** → Betterfox + `toolkit.legacyUserProfileCustomizations.stylesheets=true` + prefs
- **`chrome/userChrome.css`** → qutefox-minimal: JetBrains Mono tabs/urlbar, 26px tabs, square buttons, autohide bookmarks + toolbars (500ms)
- **`chrome/userContent.css`** → dark `about:home` / `about:newtab` / `about:blank` / `about:privatebrowsing` (`#1a1b26`)
- Extensions kept separate (install via LibreWolf, listed below)

## Profile source

Captured from `AppData\Roaming\LibreWolf\Profiles\main` (`profiles.ini: main`)

```ini
# profiles.ini.example
[Profile0]
Name=main
Path=Profiles/main
```

## Install / Restore (Windows)

```powershell
# 1) Clone
git clone git@github.com:0124212/librewolf.git $env:USERPROFILE\librewolf
# 2) Apply (copies chrome + user.js into current LibreWolf profile)
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\librewolf\install.ps1"
# or manually:
Copy-Item "$env:USERPROFILE\librewolf\chrome\*" "$env:APPDATA\LibreWolf\Profiles\main\chrome\" -Recurse -Force
Copy-Item "$env:USERPROFILE\librewolf\user.js" "$env:APPDATA\LibreWolf\Profiles\main\" -Force
# 3) Restart LibreWolf (about:config already has toolkit.legacyUserProfileCustomizations.stylesheets=true)
```

`install.ps1` auto-finds `Profiles/main` via `profiles.ini` and backs up existing `user.js`/`chrome` to `*.bak-*`.

## Update

Edit files here, commit + push, then pull on next machine:

```powershell
# on machine A
code $env:USERPROFILE\librewolf\chrome\userChrome.css
git -C $env:USERPROFILE\librewolf commit -am "tweak gruvbox accent"
git -C $env:USERPROFILE\librewolf push
# on machine B
git -C $env:USERPROFILE\librewolf pull; powershell $env:USERPROFILE\librewolf\install.ps1; taskkill /IM librewolf.exe /F; start librewolf
```

## What's tracked

- `user.js` — Betterfox overrides
- `chrome/*.css` — qutefox-minimal + dark newtab (~13k total)
- `profiles.ini.example` — reference

## What's NOT tracked (intentionally)

- `prefs.js` (generated), `cookies.sqlite`, `logins.json`, `places.sqlite`, `storage/`, `cache/` — personal / cache

## Extensions in profile `main`

- `uBlock0@raymondhill.net` — uBlock Origin
- `addon@darkreader.org` — Dark Reader
- `{446900e4-71c2-419f-a6a7-df9c091e268b}` — Bitwarden
- `7esoorv3@alefvanoon.anonaddy.me` — LibRedirect
- `web-clipper@usememos.com` — Memos
- `en-US-Extended@averymiller.org` — Dictionary
- Theme addons: `LibreWolf Dark v1A`, `Dark space`

Install extensions manually after profile restore.

## qutefox-minimal quick edit

Top of `chrome/userChrome.css` (`:root`): tab/urlbar font, `--urlbar-height-setting: 22px`, `--tab-min-height: 26px`, square buttons, tight paddings. Bookmarks + toolbars autohide via the bundled snippet (`--uc-autohide-toolbox-delay: 500ms`, `--uc-toolbox-rotation: 82deg`) — raise the delay if the bar hides too eagerly.

## Betterfox

`user.js:15` is Betterfox `152` (`yokoffing/Betterfox`). Top of file = FASTFOX/SECUREFOX/PESKYFOX. Personal overrides at `// START: MY OVERRIDES` (`222`). Keep `toolkit.legacyUserProfileCustomizations.stylesheets=true` enabled.
