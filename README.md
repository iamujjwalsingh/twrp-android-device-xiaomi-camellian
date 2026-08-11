# TWRP Device Tree for Xiaomi Redmi Note 10 5G (camellia)

![TWRP Build](https://img.shields.io/github/actions/workflow/status/rwxrx-rx/twrp-android-device-xiaomi-camellia/build.yaml?branch=main&label=Build%20Status&style=for-the-badge&color=1F883D)
![Android Version](https://img.shields.io/badge/Android-12.1-3DDC84?style=for-the-badge&logo=android&logoColor=white)

---

This repository contains the official-standard **Team Win Recovery Project (TWRP)** device tree for the **Xiaomi Redmi Note 10 5G** (codename `camellia`/`camellian`).

## 📱 Compatibility

This tree is designed for the MediaTek MT6833 platform.

| Device | Model | ROM | Android | Kernel | Touch IC | Panel |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Poco M3 Pro 5G** (`camellia`/`camellian`) | `M2103K19C` | Evolution X | 16 | `4.14.357-openela-rc1-flyme` | Novatek `NT36672C` (FW 0x12) | Tianma |

> **Note:** This recovery image is highly likely to work on sibling "camellian" devices (Redmi Note 10T 5G, Redmi Note 11 SE, Redmi Note 10 5G), provided the bootloader is unlocked.



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
git clone [https://github.com/rwxrx-rx/twrp-android-device-xiaomi-camellia.git](https://github.com/rwxrx-rx/twrp-android-device-xiaomi-camellia.git) -b android-12.1 device/xiaomi/camellia

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
