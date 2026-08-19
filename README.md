# ThingsBoard & Keycloak 26.6.4 Integration Deployment

This repository contains a complete DevOps solution for deploying a customized **Keycloak 26.6.4** identity provider integrated with **ThingsBoard**, featuring custom themes, multi-factor authentication (Email/SMS), and a custom OAuth2 Mapper microservice.

The entire stack is containerized via Docker, orchestrated by **Kubernetes**, and fully automated via a **Jenkins CI/CD pipeline**.

---

## 📦 Tech Stack & Architecture

| Component | Technology |
| :--- | :--- |
| **Identity Provider** | Keycloak 26.6.4 (Quarkus) |
| **IoT Platform** | ThingsBoard 4.2.0 |
| **Custom Mapper** | Spring Boot Microservice (Port 10010) |
| **SMS Gateway** | Node.js Microservice (Port 10020) |
| **Container Runtime** | Docker / containerd |
| **Orchestration** | Kubernetes (`kubeadm`) |
| **CI/CD** | Jenkins (Pipeline script from SCM) |
| **Proxy & SSL** | HAProxy |

---

## 🚀 Key Features

*   **Custom Authentication UI:** Includes a fully branded `U TECH Technologies` login theme for Keycloak.
*   **Multi-Factor Authentication (MFA):** Supports Email OTP and SMS OTP (via `dialog-sms-proxy` integrating with external SMS APIs).
*   **Auto-Import Realm:** Automatically imports a pre-configured `thingsboard-realm.json` on startup, setting up the OIDC client and test users.
*   **Custom OAuth2 Mapper:** A dedicated microservice that handles custom user claim mapping (e.g., routing specific users to the Customer Portal).
*   **Fully Automated CI/CD:** A `Jenkinsfile` builds both the Keycloak image and the Mapper image, imports them into containerd, and updates the Kubernetes deployment on every push to the `main` branch.
*   **Cloud-Native:** Designed for deployment on a single-node Kubernetes cluster (tested on GCP VM).

---

## 📁 Project Structure

```text
.
├── custom-theme/                # Keycloak custom theme files
├── dialog-sms-proxy/            # Node.js SMS Proxy microservice
├── Jenkinsfile                  # CI/CD pipeline definition
├── Dockerfile                   # Builds the main Keycloak server image
├── Dockerfile.mapper            # Builds the Custom OAuth2 Mapper image
├── keycloak-postgres.yaml       # Kubernetes Deployment for Keycloak PostgreSQL DB
├── keycloak.yaml                # Kubernetes Deployment for Keycloak
├── sms-proxy.yaml               # Kubernetes Deployment for the SMS proxy
├── thingsboard-realm.json       # Pre-configured Keycloak realm export
├── oauth2-mapper-1.0.0-boot.jar # Custom OAuth2 Mapper Java binary
├── sms-otp-authenticator-266.jar# SMS 2FA authenticator Java plugin
└── email-authenticator-mesutpiskin.jar # Email 2FA authenticator Java plugin
