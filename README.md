# AD CS Bridge API

A lightweight REST API bridge for Microsoft Active Directory Certificate Services (AD CS), enabling external certificate requests and automation.  
This project is being developed and tested on **AWS EC2 Windows Server 2025** with **AD DS** and **AD CS** (Web Enrollment role) installed.

This project demonstrates how to bridge external applications to Microsoft Active Directory Certificate Services (AD CS) over REST.  
It is designed for scenarios where certificates must be requested externally using service accounts.

## Current State (8/17/2025)

The included PowerShell script is the **first tested step** in building this API.  
It authenticates with a service account, submits a CSR to AD CS, retrieves the issued certificate, and saves it to file.  
This is a foundation step — more functionality will be added.

## Requirements

### 1. Windows Server Setup
- Windows Server 2022 or 2025 on AWS EC2.
- Active Directory Domain Services (AD DS) installed and configured.
- Active Directory Certificate Services (AD CS) installed with the **Web Enrollment role** enabled.

### 2. Service Account
- A dedicated service account (e.g., `svc-adcs`) with:
  - **Enroll** permission on the target certificate template (e.g., `TLS/SSL`).
  - **Read** and **Request Certificates** permissions on the Certification Authority.
  - Membership in a delegated security group for certificate enrollment (recommended).

### 3. Networking
- Public DNS record pointing to the EC2 instance.
- Port **443 (HTTPS)** open to external clients.
- Valid SSL certificate bound in IIS for the AD CS Web Enrollment site.

### 4. Client Requirements
- **PowerShell 5.1+** on the client machine.
- Script execution policy that allows running the provided script.
- The provided script must be run with valid service account credentials.
