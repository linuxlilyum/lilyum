#/usr/bin/env Python3

import os 
import time

#Alttaki fonksiyonları aklımdaki başka bir yöntem için yazmıştım ama vazgeçtim. 
#Ama yine de lazım olabilir diyerek silmiyorum.

#def dağıtım():
#    lsb_release=os.popen("lsb_release -i").read()
#    dağıtımadı=lsb_release.split()[2].lower()
#    return dağıtımadı

#def qdbus():
#    qdbusqt5=("opensuse",)
#    if dağıtım() in qdbusqt5:
#        return "qdbus-qt5"
#    else:
#        return "qdbus"

def kde():
    masaüstü=(i for i in os.popen("echo $DESKTOP_SESSION").read().split("/") if "plasma" in i)
    return bool(masaüstü)

def calamares():
    calamares_yoklama=(i for i in os.popen("ps -e").readlines() if "calamares" in i)
    return bool(calamares_yoklama)

def kilitengelleyici():
    klasör="/usr/lib64/libexec/"
    if kde():
        dosya="kscreenlocker_greet"
    os.chmod("sudo "+klasör+dosya,644)

def çalış():
    while not calamares():
        time.sleep(60)
    else: 
        kilitengelleyici()
        break       
    
çalış()
    
