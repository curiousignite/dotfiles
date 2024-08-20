import platform
import subprocess
import sys


def main():
    os_name = platform.system()
    if os_name == "Windows":
        p = subprocess.Popen(
            ["pwsh.exe", "setup\\.build_win.ps1"],
            stdout=sys.stdout,
        )
        p.communicate()
    elif os_name == "Linux":
        subprocess.call(["setup/.build_lin.sh"])
    else:
        print(f"{os_name} is not implemented...")


if __name__ == "__main__":
    main()
