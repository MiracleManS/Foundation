# Tools

These tools simplify the setup and site creating processes.

## Building when not using Visual Studio

```ps
.\build.ps1;
```

## Developer Machine Setup

To setup a local development machine execute the following script in an admin PowerShell console.

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; .\setup-dev-machine.ps1;
```

## IIS Site Creation

To create a local IIS Site use the following script to run all related scripts, but they can also be ran independently. Requires admin Powershell console.

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; .\setup-iis-site.ps1
```

## Machine Level Execution Policy

To enable a more permissive execution policy execute the following in an admin PowerShell console:

```ps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
```

<https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Security/Set-ExecutionPolicy?view=powershell-5.1&redirectedfrom=MSDN>