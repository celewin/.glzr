import subprocess

  
# Path to the PowerShell script
script_path = r'C:/users/clewi/.glzr/zebar/scripts/toggleTB.ps1'

# Command to run the PowerShell script
command = ['powershell.exe', '-ExecutionPolicy', 'Bypass', '-File', script_path]
taskbar_state = subprocess.run(command, shell=False, stdout=subprocess.PIPE, text=True)
taskbar_state = taskbar_state.stdout.split("\n")[1]

