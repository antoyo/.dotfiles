import subprocess
from subprocess import check_output

def get_pass(account):
    return check_output("gopass show -f mail/" + account, shell=True, stderr=subprocess.STDOUT).splitlines()[0].decode("utf-8")
