# 🦊 OrangeFox Recovery for Xiaomi Redmi Note 10 5G (`camellia`)

[![Build Status](https://img.shields.io/github/actions/workflow/status/cristidclxvi/device_xiaomi_camellia-fox/build.yml?branch=fox_12.1&label=OrangeFox%20Build&style=for-the-badge&color=FF7F00)](https://github.com/rwxrx-rx/fox-device-camellia/actions)
![Android Version](https://img.shields.io/badge/Android-13-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![OrangeFox](https://img.shields.io/badge/OrangeFox-12.1-FF7F00?style=for-the-badge)

---

An unofficial OrangeFox Recovery device tree for the **Xiaomi Redmi Note 10 5G** (`camellia`, MediaTek MT6833), featuring a dedicated fix to get the NVT touchscreen working properly in recovery mode.

---

## 📱 Compatibility & Tested Devices

This tree has been tested and verified on the following setup:

| Device | Model | MIUI Version | Android | Kernel | Touch IC | Panel |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Redmi Note 10 5G** | `M2103K19C` | `V14.0.6.0.TKSMIXM` | 13 | `4.14.186-perf-g82b8a4552e62` | Novatek `NT36672C` (FW 0x12) | Tianma |

> **Note:** This recovery image is highly likely to work on sibling "camellian" devices (Redmi Note 10T 5G, Redmi Note 11 SE, POCO M3 Pro 5G), provided the bootloader is unlocked.

---

## 🛠️ Automated Build (CI/CD)

You no longer need to download the massive Android source tree to build this recovery. This repository uses **GitHub Actions** to automatically compile OrangeFox.

1. Go to the **[Actions](../../actions)** tab in this repository.
2. Select **OrangeFox CI Build** on the left sidebar.
3. Click **Run workflow** -> **Run**.
4. Wait for the build to complete (usually takes ~30-45 minutes).
5. Download your compiled `OrangeFox-camellia.img` from the **Artifacts** section at the bottom of the build summary.

---

## 💻 Manual Local Build

If you prefer to build it locally on your own machine, follow these steps:

```bash
# 1. Setup working directory
mkdir OFRP_12.1 && cd OFRP_12.1

# 2. Sync OrangeFox Source
git clone [https://gitlab.com/OrangeFox/sync.git](https://gitlab.com/OrangeFox/sync.git)
bash sync/orangefox_sync.sh --branch 12.1 --path "$PWD"

# 3. Clone this device tree
git clone -b fox_12.1 [https://github.com/cristidclxvi/device_xiaomi_camellia-fox.git](https://github.com/cristidclxvi/device_xiaomi_camellia-fox.git) device/xiaomi/camellia

# 4. Initialize build environment
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=camellia

# 5. Build
lunch twrp_camellia-eng
mka adbd bootimage recoveryimage
