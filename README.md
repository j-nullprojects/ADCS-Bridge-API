# ADCS-Bridge-API
REST API for Microsoft's Active Directory Certificate Services

This project demonstrates how to bridge external applications to Microsoft Active Directory Certificate Services (AD CS) over REST.  
It is designed for scenarios where certificates must be requested externally using service accounts.

## Quick Setup Intro

On AWS, launch a Windows Server 2025 EC2 instance. Install Active Directory Domain Services (AD DS) and configure Active Directory Certificate Services (AD CS) with a Web Enrollment role. Ensure the CA is accessible externally over HTTPS.

## Current State (8/17/2025)

The included PowerShell script is the **first tested step** in building this API.  
It authenticates with a service account, submits a CSR to AD CS, retrieves the issued certificate, and saves it to file.  
This is a foundation step — more functionality will be added.
