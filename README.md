# TWRP Device Tree for Xiaomi Redmi Note 10 5G (camellia)

![TWRP Build](https://img.shields.io/github/actions/workflow/status/rwxrx-rx/twrp-android-device-xiaomi-camellia/build.yaml?branch=main&label=Build%20Status&style=for-the-badge&color=1F883D)
![Android Version](https://img.shields.io/badge/Android-12.1-3DDC84?style=for-the-badge&logo=android&logoColor=white)

---

This repository contains the official-standard **Team Win Recovery Project (TWRP)** device tree for the **Xiaomi Redmi Note 10 5G** (codename `camellia`/`camellian`).

## 📱 Compatibility & Tested Devices

| Features | Specifications |
| :--- | :--- |
| **Device** | Xiaomi Redmi Note 10 5G / POCO M3 Pro 5G |
| **Codename** | `camellia` |
| **SoC** | MediaTek MT6833 Dimensity 700 (7 nm) |
| **CPU** | Octa-core (2x2.2 GHz Cortex-A76 & 6x2.0 GHz Cortex-A55) |
| **GPU** | Mali-G57 MC2 |
| **Display** | 6.5" IPS LCD, 90Hz (1080 x 2400 pixels) |
| **Memory** | 4GB / 6GB / 8GB RAM |
| **Storage** | 64GB / 128GB / 256GB (UFS 2.2) |
| **Battery** | 5000 mAh (18W Fast Charging) |
| **Touch IC** | Novatek `NT36672C` |
| **Panel** | Tianma |

> **Note:** This recovery image is highly likely to work on sibling "camellian" devices (Redmi Note 10T 5G, Redmi Note 11 SE, POCO M3 Pro 5G), provided the bootloader is unlocked.

---

## 🐛 NVT Touchscreen Wake Fix Explained

On `camellia` devices equipped with Novatek (NVT) touch panels, a common bug occurs where the **touchscreen stops responding after the screen turns off** (via timeout or power button) and turns back on in recovery.

* **The Cause:** When the screen blanks, the NVT driver drops into a `wakeup-gesture` suspend mode. In a normal system boot, waking the device fires the `fb_notifier`, which calls `nvt_ts_resume` and kicks the driver back to normal touch reporting. However, in recovery environments, screen dimming turns off the backlight directly without updating the framebuffer (`/sys/class/graphics/fb0/blank`). Because the framebuffer status never changes to `1` (blank), the NVT driver remains stuck in gesture mode and no touch events reach userspace.
* **The Solution:** This tree utilizes a custom background daemon (`nvt_touch_wake_watch.sh`) that continuously monitors the screen's backlight brightness node (`/sys/class/leds/lcd-backlight/brightness`). Whenever the script detects the screen waking up (brightness changing from `0` to `> 0`), it rapidly writes `4` then `0` to `fb0/blank` to manually trigger the framebuffer toggle, successfully forcing the NVT driver to resume normal multi-touch reporting on every wake.
* **⚡ Responsiveness Optimization:** To eliminate any noticeable delay, the background daemon is optimized with aggressive polling intervals:
  * **Polling Interval:** Set to `0.1s` for near-instant screen wake detection.
  * **Framebuffer Toggle Delay:** Minimized to `0.05s` to speed up the `nvt_ts_resume` hook.
  *(Note: These services are initialized from the `on boot` trigger in `init.touchwake.rc` to bypass SELinux `vendor_init` property read denials).*

---

## 🛠️ Build using GitHub Actions (CI)

You can build this recovery automatically using the built-in GitHub Actions workflow.

1. Navigate to the **[Actions](../../actions)** tab.
2. Select **TWRP Build** from the left menu.
3. Click **Run workflow** -> **Run**.
4. Once completed, your build will be available as an Artifact or Release.

## 💻 Manual Local Build

To build the recovery locally, follow these steps:

```bash
# 1. Prepare Workspace
mkdir twrp-workspace && cd twrp-workspace

# 2. Sync TWRP Manifest
repo init --depth=1 -u [https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git](https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git) -b twrp-12.1
repo sync -j$(nproc --all) --force-sync

# 3. Clone this device tree
git clone [https://github.com/rwxrx-rx/twrp-android-device-xiaomi-camellia.git](https://github.com/rwxrx-rx/twrp-android-device-xiaomi-camellia.git) -b main device/xiaomi/camellia

# 4. Build
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_camellia-eng
make clean
make recoveryimage -j$(nproc --all)

```
## 🤝 Credits & Acknowledgments

A huge thank you to the following teams, developers, and contributors for their work, code, and support:

* **[TeamWin (TWRP)](https://github.com/TeamWin)** — For the foundational recovery source.
* **[OrangeFox Recovery Project](https://gitlab.com/OrangeFox)** — For the amazing recovery platform and source code.
* **[that1](https://github.com/that1)** — For contributions and support.
* **[cd-Crypton](https://github.com/cd-Crypton)** — For development tools and base work.
* **[azwhikaru](https://github.com/azwhikaru)** — For contributions and assistance.
* **[cristidclxvi](https://github.com/cristidclxvi/device_xiaomi_camellia-fox)** — For the NVT touchscreen panel fixes in recovery.
* **All Open-Source Contributors** — For every repository, helper script, and feedback utilized in bringing this project together.
