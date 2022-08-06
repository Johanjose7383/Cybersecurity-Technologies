
################## 1 ###################

function Gethogging {
    Write-Host "CPU Hogging Processes"
    Write-Host "------------------------"

    Get-Process | Where-Object { $_.CPU -gt 300 }
}
Gethogging

################## 2 ###################

function check_antimalware {

    Write-Host "Antimalware Toolkit staus"
    Write-Host "------------------------"
    Get-MpComputerStatus | select AMServiceEnabled
    
}
check_antimalware

################## 3 ###################


[System.Collections.ArrayList]$approved="Microsoft Corporation","Python Software Foundation"
[System.Collections.ArrayList]$aaprovedprogrm='7Zip', 'ABBYY FineReader', 'Adobe Acrobat Pro', 'Adobe Acrobat Reader', 'Adobe Creative Cloud', 'Adobe DNG Converter 9.6', 'Adobe Photoshop Elements', 'Ansible', 'ArchiveSpace', 'Audacity', 'Audible Manager', 'AutoDesk AutoCAD', 'AutoDesk Fusion 360', 'AutoDesk Slicer for Fusion 360', 'Avid Pro Tools', 'Beyond Compare 2.X', 'Blackboard Collaborate', 'Blender', 'Cadence OrCAD 16.6', 'Capture Perfect', 'Centricity', 'ChemDraw Std 12.0', 'ChemDraw Ultra v.12.0', 'Corel Draw 6X Edu Ed', 'Corel WordPerfect 5X', 'Corel WordPerfect 6X', 'CryptoPrevent', 'CutePDF', 'CyberDuck 6.3.1', 'Davinci Resolve 17', 'Davinci Resolver 12.5.5', 'DHI MIKE SHE', 'Digital Performer', 'Djvu Reader', 'Dragon Naturally Speaking', 'Drop Box', 'Eaglesoft', 'Elastic Stack', 'Eniscan', 'Enscan/EXScan', 'EosETCnomad Mac Software', 'EverNote', 'Exam View', 'Faronics Anti-Virus', 'Faronics Core', 'Faronics Data Igloo', 'Faronics Deep Freeze', 'Faronics Insight', 'FileMaker Pro', 'Team', 'FileZilla', 'Filezilla 3.29', 'Firefox', 'Fitness Trac', 'Web Server', 'FlipBooks 6.6.2', 'Fortres Grand Clean Slate', 'Fortres Grand Fortres 101', 'GeoGebra', 'GeoSketchPad', 'Gimp', 'GIT', 'GNUPGP', 'Google Chrome', 'Google Drive', 'Google Earth Pro', 'Grade Machine', 'Grafana', 'Grammarly Business', 'Graph - Math', 'Greenshot', 'Hitachi Starboard', 'i-learn math toolbox', 'Inspiration', 'IsadoraCore 2.2.2', 'iTunes', 'Freeware', 'JAWS', 'JING', 'Keyboard Pro Deluxe', 'Keynote 7.3.1', 'Kindle', 'Kleopatra', 'LanSchool', 'LifeSize Cloud', 'Live Action English', 'LucidChart', 'MacCaw 1.6.1', 'MariaDB', 'MathType', 'MatLab', 'Maya 2018', 'Mendeley Desktop', 'Mestranova Mnova Suite', 'Microsoft Office suite', 'Microsoft Project', 'Microsoft Visio', 'MobaXterm', 'mRemote', 'Mudbox', 'mySQL', 'Natural Reader 14', 'Nueronmocap', 'Notepad++', 'Novell Cient', 'Novell iPrint client', 'Novell Messenger', 'Novell ZENworks Adaptive Agent', 'Numbers 4.3.1', 'NVDA', 'NV Access', 'Open Broadcast Studio', 'OpenNMS', 'OpenShot', 'Opera 49.0', 'Pages 6.3.1', 'PaperCut', 'Pasco Capstone', 'Pasco Data Studio', 'PDFArchitect', 'PDFCreator, PDFforge', 'Power DVD', 'Pronunciation Power', 'Public Web Browser', 'Putty', 'PuttyNG', 'Quickbooks Pro', 'Revit', 'Rosetta Stone', 'Safari', 'SARS', 'Screencast-O-Matic', 'Skype', 'Snagit', 'TechSmith', 'SNAP Player', 'SoftChalk 11', 'SoftChalk', 'Site License', 'SolidWorks', 'Spartan Essential', 'StarBoard', 'Starry Night', 'Stella 8', 'Stretchware', 'Sublime Text', 'Tableau Desktop', 'Test Gen plug in', 'TextWrangler 5.5.2', 'TI - Connect', 'TI-Smartview', 'Ultimaker-Cura', 'Troikatronix Isadora V2.6.1 - USB Key Edition', 'Vectorworks Spotlight', 'Venier Graphical Analysis', 'Venier Logger Pro', 'Virtual Business', 'VLC 2.2.4', 'Wacom Drivers and Utilities', 'Weather Link', 'WinMerge', 'WinPlot', 'WinRar', 'WinSCP', 'WinZip', 'WireShark', 'Wolfram CDF Player', 'WS FTP Pro', 'XCode', 'Xmarin', 'XnView', 'Zoom Video Conferencing', 'Zoom', 'ZoomText', 'Zotero'


function Check_approved {
    
    $val=Get-CimInstance -Class Win32_Product 
    # Write-Host $val
    try{
        Mkdir c:\Program_report
     }
     catch{
        Write-Host "folder already exist"
     }
    Get-CimInstance -Class Win32_Product | 
    select-object Name,Version,Caption,IdentifyingNumber,Vendor,description,installState | 
       Export-Csv -UseCulture -NoTypeInformation -LiteralPath c:\Program_report\report.csv

       Write-Host "Program report stored in c:\Program_report\report.csv "

    foreach ($items in $val)
    {   
            
    
    
            if($approved -contains $items.Vendor -or $aaprovedprogrm -contains $items.name ){
    
                # Write-Host "===================== Approved Program running ======================="
                # Write-Host "Program: $($items.name)"
                # Write-Host "Version: $($items.name)"
                # Write-Host "Vendor: $($items.Vendor)"
                # Write-Host "======================================================================="
    
            }
            else {
                Write-Host "************************************************************************"
                Write-Host "===================== Unapproved Program Detected ======================="
                Write-Host "Program: $($items.name)"
                
                Write-Host "Vendor: $($items.Vendor)"
                Write-Host "************************************************************************"
            }
    
    
      
    
    }
    
}

Check_approved

function remove_program($item){
    $aaprovedprogrm.Remove($item) 
    Write-Host "List after removed: $($aaprovedprogrm)"
 }
# remove_program("7Zip")




#################################### 4  #######################################

[System.Collections.ArrayList]$servicelist='AxInstSV', 'SensrSvc', 'AeLookupSvc', 'AppHostSvc', 'AppIDSvc', 'Appinfo', 'ALG', 'AppMgmt', 'aspnet_state', 'BITS', 'BFE', 'BDESVC', 'wbengine', 'bthserv', 'PeerDistSvc', 'CertPropSvc', 'NfsClnt', 'KeyIso', 'EventSystem', 'COMSysApp', 'Browser', 'VaultSvc', 'CryptSvc', 'DcomLaunch', 'UxSms', 'Dhcp', 'DPS', 'WdiServiceHost', 'WdiSystemHost', 'defragsvc', 'TrkWks', 'MSDTC', 'Dnscache', 'EFS', 'EapHost', 'Fax', 'fdPHost', 'FDResPub', 'gpsvc', 'hkmsvc', 'HomeGroupListener', 'HomeGroupProvider', 'hidserv', 'IISADMIN', 'IKEEXT', 'CISVC', 'UI0Detect', 'SharedAccess', 'iphlpsvc', 'PolicyAgent', 'KtmRm', 'lltdsvc', 'LPDSVC', 'Mcx2Svc', 'MSMQ', 'MSMQTriggers', 'clr_optimization_v2.0.50727', 'ftpsvc', 'MSiSCSI', 'swprv', 'MMCSS', 'NetMsmqActivator', 'NetPipeActivator', 'NetTcpActivator', 'NetTcpPortSharing', 'Netlogon', 'napagent', 'Netman', 'netprofm', 'NlaSvc', 'nsi', 'CscService', 'WPCSvc', 'PNRPsvc', 'p2psvc', 'p2pimsvc', 'pla', 'PlugPlay', 'IPBusEnum', 'PNRPAutoReg', 'WPDBusEnum', 'Power', 'Spooler', 'wercplsupport', 'PcaSvc', 'ProtectedStorage', 'QWAVE', 'RasAuto', 'RasMan', 'SessionEnv', 'TermService', 'UmRdpService', 'RpcSs', 'RpcLocator', 'RemoteRegistry', 'iprip', 'RemoteAccess', 'RpcEptMapper', 'SeaPort', 'seclogon', 'SstpSvc', 'SamSs', 'wscsvc', 'LanmanServer', 'ShellHWDetection', 'simptcp', 'SCardSvr', 'SCPolicySvc', 'SNMP', 'SNMPTRAP', 'sppsvc', 'sppuinotify', 'SSDPSRV', 'StorSvc', 'SysMain', 'SENS', 'TabletInputService', 'Schedule', 'lmhosts', 'TapiSrv', 'TlntSvr', 'Themes', 'THREADORDER', 'TBS', 'upnphost', 'ProfSvc', 'vds', 'VSS', 'WMSVC', 'WebClient', 'AudioSrv', 'AudioEndpointBuilder', 'SDRSVC', 'WbioSrvc', 'idsvc', 'WcsPlugInService', 'wcncsvc', 'WinDefend', 'wudfsvc', 'WerSvc', 'Wecsvc', 'EventLog', 'MpsSvc', 'FontCache', 'StiSvc', 'msiserver', 'fsssvc', 'Winmgmt', 'ehRecvr', 'ehSched', 'WMPNetworkSvc', 'TrustedInstaller', 'FontCache3.0.0.0', 'WAS', 'WinRM', 'WSearch', 'W32Time', 'wuauserv', 'WinHttpAutoProxySvc', 'dot3svc', 'Wlansvc', 'wmiApSrv', 'LanmanWorkstation', 'W3SVC', 'WwanSvc'

function Get_services {
    
   $val2=Get-Service | Where-Object {$_.Status -eq "Running"}
    foreach ($run in $val2)
    { 

        

        if($servicelist -notcontains $run.Name){
            Write-Host "*************************** Unapproved service *********************************************"
            Write-Host  "Service name "$($run.Name)
            Write-Host  "Display Name "$($run.DisplayName)
            Write-Host "************************************************************************"

        }

      }
}


Get_services

function remove_service($item){
    $servicelist.Remove($item) 
    Write-Host "List after removed: $($servicelist)"
 }
# remove_service("AxInstSV")


################## 5 ###################


function CheckNTP {

    $val=Get-ItemProperty -Path HKLM:\SYSTEM\STATE\DATETIME
    
    Write-Host "NTP Status: $($val.'NetworkTime Enabled')"
    
}
CheckNTP

# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Press any key to exit..."
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}