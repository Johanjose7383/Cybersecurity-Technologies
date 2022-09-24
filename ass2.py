import wget
import os

# ########## 1 ########

def getmap():
        url = 'https://dev.virtualearth.net/REST/V1/Imagery/Map/Road/9.9816,76.2999?zoomLevel=10&key=AuGDjsbtX3HY018iYIrLucjoUA6peA-GdDwvqIH3-V4R_ceWHv6xdhfcH5gAik_v'
        imgfile = wget.download(url)

getmap()
################# 2###############
# list all ftp servers

def listftp():
        os.system("sudo apt-cache search ftp | grep -i server| awk '{print $1}' |tee ftps.txt")


        my_file = open("ftps.txt", "r")
        

        data = my_file.read()

        ftp_mainlist = data.split("\n")
        
        my_file.close()

        # list running ftp services
        os.system("sleep 1 |telnet localhost ftp | awk '{print $0}' |tee running.txt")

        my_file = open("running.txt", "r")
        data = my_file.read()
        import re

        # find server details

        result = re.findall('\(.*?\)', data)
        for i in result:
                i=i.replace("(","").replace(")","")
                flist=i.split(" ")
                ftpval=flist[0].lower()
                ftpver=flist[1]
                if (ftpval not in ftp_mainlist):
                        print("Unapproved ftp server found!!! "+ftpval)
                if(ftpver=="2.3.4" and ftpval=="vsftpd"):
                        print("vsftpd 2.3.4 server found!!!")
listftp()
#####  3  ###########################


# setup http server using "python3 -m htttp.server 8069" command in a seperate shell
  
def apache2ctl():

        os.system("netstat -plnt")
        os.system("sudo apache2ctl status")

apache2ctl()
