# 💾 Backup Lab

## Linux Backup Automation with rsync

> [!IMPORTANT]
> ### 📦 Legacy Portfolio Project
>
> This repository documents one of the first major infrastructure engineering projects I completed while developing my home lab.
>
> Rather than deleting or replacing it, I have intentionally preserved it as part of my **Legacy Project Archive** to document my growth as an infrastructure and cybersecurity engineer.
>
> The engineering concepts, troubleshooting experience, and documentation practices developed during this project directly influenced the design and organization of my current engineering portfolio.
>
> My current engineering efforts are focused on:
>
> - 🛡️ Cyber Operations Center Engineering Program *(Flagship Project)*
> - 🏗️ Project Atlas — Infrastructure Engineering
> - 📡 [NET-WATCH](https://github.com/scott-renny/netwatch)
> - 🪖 [Project Hermes](https://github.com/scott-renny/project-hermes)
> - 🐺 [Project Cerberus](https://github.com/scott-renny/project-cerberus-build)
> - ⚔️ [Project Ares](https://github.com/scott-renny/project_ares)
> - ☀️ [Project Apollo](https://github.com/scott-renny/project-apollo)
>
> Repository links will be added as these projects are completed.

---

![Status](https://img.shields.io/badge/Status-Legacy_Project-6f42c1)
![Platform](https://img.shields.io/badge/Platform-Ubuntu-E95420)
![Language](https://img.shields.io/badge/Language-Bash-4EAA25)
![Portfolio](https://img.shields.io/badge/Portfolio-Historical_Project-blue)

---

# Project Overview

The **Backup Lab** was created to explore Linux system administration and build a reliable backup solution using open-source technologies.

What began as a simple backup automation exercise evolved into a multi-phase infrastructure project covering storage configuration, automated backups, network file sharing, encrypted backup repositories, restore validation, monitoring, and incident documentation.

Today, this repository serves as a historical snapshot of my engineering progression and the foundation upon which many of my current infrastructure projects have been built.

---

# Project Objectives

- Learn Linux system administration
- Configure persistent storage
- Automate backups using rsync
- Schedule recurring jobs with Cron
- Configure Samba network shares
- Implement encrypted backups with Restic
- Verify backup restoration procedures
- Integrate monitoring using Wazuh
- Practice documentation and incident reporting

---

# Technologies Used

- Ubuntu Linux
- Bash
- rsync
- Cron
- Samba
- Restic
- Wazuh
- SSH

---

# Skills Demonstrated

- Linux Administration
- Infrastructure Engineering
- Bash Scripting
- Backup Automation
- Disaster Recovery
- Encryption
- Network File Sharing
- Security Monitoring
- Incident Response
- Technical Documentation
- Troubleshooting

---

# Repository Structure

```text
backup-lab/
│
├── docs/
│   ├── PHASE1-mount-hdd.md
│   ├── PHASE2-rsync-cron.md
│   ├── PHASE3-samba-share.md
│   ├── PHASE4-restic-encryption.md
│   ├── PHASE5-verify-restore.md
│   ├── PHASE6-wazuh-integration.md
│   ├── INCIDENT-REPORT.md
│   └── smb.conf.snippet
│
├── screenshots/
│
├── backup_rsync.sh
├── setup.sh
└── README.md
```

---

# Implementation Phases

This project is documented through six implementation phases.

1. HDD Mount & Storage Configuration
2. rsync Backup Automation & Cron Scheduling
3. Samba Network Share Configuration
4. Restic Encrypted Backups
5. Backup Verification & Restore Testing
6. Wazuh Monitoring & Security Integration

Each phase includes implementation notes, screenshots, troubleshooting steps, incident response documentation, and lessons learned.

---

# Features

- Automated Linux backups
- Incremental synchronization using rsync
- Scheduled Cron jobs
- Samba network file sharing
- Encrypted Restic backups
- Snapshot retention policies
- Backup verification
- Wazuh monitoring integration
- Comprehensive project documentation
- Incident Response documentation

---

# Documentation

The **docs/** directory contains detailed documentation for every implementation phase.

Each phase includes:

- Objectives
- Configuration steps
- Commands used
- Screenshots
- Troubleshooting
- Incident Response documentation
- Lessons learned

---

# Screenshots

Screenshots documenting each phase of the project are available in the **screenshots/** directory.

---

# Learning Outcomes

This project provided practical experience with:

- Linux infrastructure
- Backup automation
- Disaster recovery
- Encryption
- Monitoring and alerting
- Infrastructure troubleshooting
- Incident documentation
- Technical documentation

More importantly, it established many of the engineering and documentation practices that continue throughout my current portfolio.

---

# Why This Project Is Part of My Legacy Portfolio

This repository successfully achieved its original learning objectives and became the foundation for more advanced infrastructure and cybersecurity projects.

Rather than deleting earlier work, I intentionally preserve projects like this to demonstrate continuous learning and the evolution of my engineering practices.

My Legacy Project Archive exists to show not only what I can build today, but also how my approach to planning, implementation, documentation, and problem solving has matured over time.

---

# Current Engineering Focus

My active engineering work now centers on:

- 🛡️ Cyber Operations Center Engineering Program *(Flagship Project)*
- 🏗️ Project Atlas
- 📡 [NET-WATCH](https://github.com/scott-renny/netwatch)
- 🪖 [Project Hermes](https://github.com/scott-renny/project-hermes)
- 🐺 [Project Cerberus](https://github.com/scott-renny/project-cerberus-build)
- ⚔️ [Project Ares](https://github.com/scott-renny/project_ares)
- ☀️ [Project Apollo](https://github.com/scott-renny/project-apollo)

These projects represent my current engineering standards, documentation practices, and long-term portfolio direction.

---

# License

This project is released under the MIT License.

---

# Author

## Scott Renny

**Security+ Certified • Cybersecurity and Infrastructure Engineering**

*"Building enterprise infrastructure one project at a time while continuously learning, improving, and documenting the journey."*
