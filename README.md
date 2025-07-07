# 🚆 Train CleanLines Inspection Digital Form App

A professional Flutter application for inspecting and managing railway coach cleanliness reports — designed to work both **online and offline** with PDF summaries and API integrations.

---

## 🌟 Features

- ✅ **Hive Database Integration**  
  Save inspection form data locally without internet — perfect for offline usage.

- 📤 **HTTPBin & Webhook API Integration**  
  Send your inspection data as JSON payloads to mock servers (`httpbin.org`) for testing or integration.

- 🧾 **PDF Summary Generation**  
  View and download/save a **clean, well-structured PDF** summary of all cleanliness parameters (score & remark) per coach.

- 📶 **Offline First Functionality**  
  Automatically stores data locally in case of accidental app close or no internet.

- 📋 **Parameter-wise Coach Tracking**  
  Tracks cleanliness parameters (urine, dustbin, mirror, etc.) for each coach separately.

- 🧠 **Provider State Management**  
  Lightweight and reactive state management using `provider`.

---

## 🛠 Tech Stack

| Tech         | Usage                                    |
|--------------|------------------------------------------|
| Flutter      | Frontend mobile & web app                |
| Hive         | Local NoSQL database (offline storage)   |
| Provider     | State management                         |
| http         | API communication  
| connectivity_plus | To check internet connectivity      |
| dart_pdf     | Dynamic PDF generation                   |
| printing     | PDF preview and print                    |


