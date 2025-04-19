## 🚀 Getting Started with Docker for HPC Research

Unfortuantely, due to low staffing, this will be a self-guided workshop. 

This repository contains materials to help you get started with Docker, including some advanced topics like multi-platform builds. Whether you're new to containers or looking to sharpen your skills, this workshop is designed to give you practical, hands-on experience.

### 📚 Workshop Materials:
All materials are available here: https://containers-at-tacc.readthedocs.io/en/latest/index.html

### Why Docker?
Docker is a powerful and user-friendly container tool that simplifies the process of building, sharing, and running applications in a portable and reproducible way. It has a vast public repository of container images ([**Docker Hub**](https://hub.docker.com/)), excellent community support, and robust features for customizing containers to fit your needs.

Although Docker is not available on Hyak HPC clusters—because it requires root privileges to run—we fully support container-based workflows. Instead, we use Apptainer (formerly Singularity), which allows users to run containers securely without elevated permissions.

Docker and Apptainer complement each other well: you can build custom containers with Docker on your local machine or in the cloud, then run them seamlessly on the cluster using Apptainer. This makes Docker a great tool for developing and testing your software before scaling up on HPC resources.