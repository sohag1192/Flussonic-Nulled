
---

## ⚙️ Flussonic-Nulled Installation on Ubuntu ![Badge](https://hitscounter.dev/api/hit?url=https%3A%2F%2Fgithub.com%2Fsohag1192%2FFlussonic-Nulled&label=&icon=github&color=%23198754&message=&style=for-the-badge&tz=UTC)

> ⚠️ **Disclaimer:** This repository appears to contain unofficial or modified Flussonic packages. Ensure you have the legal right to use these files before proceeding.

### 📥 Step 1: Clone the Repository
```bash
git clone https://github.com/sohag1192/Flussonic-Nulled.git
cd Flussonic-Nulled
```

### 📦 Step 2: Review the Files
The repo includes:
- `flussonic_install.sh` – likely installs Flussonic
- `flussonic_remove.sh` – uninstalls Flussonic
- `23.02.zip` and `flussonic_24.2_nulled.zip` – versioned packages

You can inspect the install script before running:
```bash
cat flussonic_install.sh
```

### ▶️ Step 3: Run the Installer
Make the script executable and run it:
```bash
chmod +x flussonic_install.sh
sudo ./flussonic_install.sh
```

If the script depends on the ZIP files, ensure they are extracted:
```bash
unzip 23.02.zip
# or
unzip flussonic_24.2_nulled.zip
```

### 🧼 Optional: Uninstall
To remove Flussonic:
```bash
chmod +x flussonic_remove.sh
sudo ./flussonic_remove.sh
```

---

## ✅ Tips
- Run on a **clean Ubuntu VPS** (e.g., Ubuntu 20.04 or 22.04).
- Ensure **port 80/443** are open if using a web interface.
- Check for **FFmpeg** and **Nginx** dependencies if required.

Would you like me to inspect the `flussonic_install.sh` script and explain what it does line by line? That way, you can verify its safety before running it.
