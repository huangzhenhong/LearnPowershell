# Management with Windows PowerShell Remoting
Michael Bender

This repository includes resources for the course Management with Windows PowerShell Remoting on Pluralsight.com.
Every attempt has been made to ensure errors and ommissions are not present. However, those happen from time to time. If you have an issue with any of the resources, file an issue with the repo on GitHub or reach out on the discussion board on Pluralsight.com

Updates for theses files will be posted on the course repository on Github at [https://github.com/themichaelbender/pscontent-mbender](https://github.com/themichaelbender/pscontent-mbender)

## Requirements
- 1 (or more) Windows Clients. Preferably Windows Server if you plan to build a domain environment.
- Local install of VS Code w/ PowerShell Extension
- Time to kick the tires


## How to use the demo files.

[Demo files for **PowerShell Remoting Basics**](./m2/)

[Demo files for **Windows PowerShell Remoting Options**](./m3)

[Demo files for **Beyond Basic Remoting**](./m4)

- Start by copying the exercise files from Pluralsight.com or Github to **Client01** (the main client). Exercise files will require unzipping.
- In each of the folder, labeled **M2** to **M4**, there will be the following items:
    - Demo files for each demo in the module.
        - These are PowerShell scripts but are not designed to be run as a script. Open them **Client01** (the main client) in VS Code, and run each command line by line just like in the videos.
    - A PDF with all of the slides for the module.
- [Install VS Code](https://code.visualstudio.com/download) on **Client01** for best experience and open the folder containing the demo files in VS Code.

## Video Demo Environment

**These instructions are as is. If you run into issues, my recommendation is to build the environment through the GUI, or use `Localhost` for the target machine in commands.**

The demo environment used in the course utilizes 3 Windows Server 2022 virtual machines. However, the majority of the course can be completed with a single machine using `Localhost` for the target system. I highly recommend going the single system route using `Localhost` as the target computer unless you have the means to build a demo environment.

If you'd like to build the environment, you'll need 3 virtual machines running Windows Server 2022. You can download an [evaluation copy](https://www.microsoft.com/evalcenter/download-windows-server-2022) from Microsoft. Make sure to choose the installation with the Desktop unless you want to configure everything from the command line.

I've created a set of installation scripts for each system located in [Lab_Environment](./Lab_Environment) They should allow you to configure each system similar to the lab environment.
In order to build the environment, you will need:
- A desktop virtualization platform of your choosing w/ a network configure with NAT and Internet access for all VMs.
- 3 VMs running Windows Server 2022 installed and logged in.
- A copy of each script on the respective machines.
- Run the commands in each file in the following order:
    - [DC01](./Lab_Environment/RUN_ON_DC01_Setup_DC01.md) - This is an Active Directory Domain Controller for psdemo.local
    - [Client01](./Lab_Environment/RUN_ON_CLIENT01_setup_client01.md) - This is a domain-joined client in psdemo.local
    - [Server01](./Lab_Environment/RUN_ON_SERVER01_setup_server01.md)- This is a workgroup server on the same network

Thanks for watching the course!



