import subprocess
import uvicorn
from fastapi import FastAPI

global locked
locked = False

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/taskbar")
def read_taskbar():
  
  # Path to the PowerShell script
  script_path = r'C:/users/clewi/.glzr/zebar/scripts/toggleTB.ps1'

  # Command to run the PowerShell script
  command = ['powershell.exe', '-ExecutionPolicy', 'Bypass', '-File', script_path]
  taskbar_state = subprocess.run(command, shell=False, stdout=subprocess.PIPE, text=True)
  taskbar_state = taskbar_state.stdout.split("\n")[1]
  print(taskbar_state)
  if taskbar_state == "0":
    return True
  else:
     return False
  
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
