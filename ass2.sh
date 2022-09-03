#!/bin/bashpt list

###### 1 ##########
apt list | tee pkg.txt


allpkg=()

while IFS= read -r line; do

    arrIN=(${line//// })
 
    allpkg+=("'$arrIN'")
    
done < pkg.txt






apt list --installed| tee instpkg.txt

instpkg=()




while IFS= read -r ln; do
    arrIN2=(${ln//// })
    instpkg+=("'$arrIN2'")
    
    
done < instpkg.txt


for val1 in ${instpkg[@]}; do
    declare -i flg=0
    
    for val2 in ${allpkg[@]}; do
        
        if [ "$val1" == "$val2" ]; then
            flg=1
        fi
    done
    
    zero=0;

    if [[ $flg -eq $zero ]]; then
    	echo "Unapproved package found $val1";
  	exit;
    fi
   
   
done




ele1=1oom
allpkg= ${allpkg[@]/$ele1}
(IFS=,; printf '[%s]' "${allpkg[*]}")


###### 2 ##########


systemctl --type=service | awk '{print $1}' | tee allservice.txt

alllser=()

while IFS= read -r line; do
 
    alllser+=("'$line'")
    
done < allservice.txt


newservicearray=()
for val1 in ${alllser[@]}; do

	if [[ $val1 == *"service"* ]]; then
  	   newservicearray+=("'$val1'")
        
        fi
        
done







systemctl --type=service --state=running | awk '{print $1}' | tee running.txt



runser=()

while IFS= read -r ln; do
 
    runser+=("'$ln'")
    
done < running.txt

newrunarray=()
for val1 in ${runser[@]}; do

	if [[ $val1 == *"service"* ]]; then
  	   newrunarray+=("'$val1'")
        
        fi
    
    done


(IFS=,; printf '[%s]' "${newrunarray[*]}")


for val1 in ${newrunarray[@]}; do
    
    declare -i flg=0
    
    for val2 in ${newservicearray[@]}; do
        
        if [ "$val1" == "$val2" ]; then
            flg=1
        fi
    done
    
    zero=0;

    if [[ $flg -eq $zero ]]; then
    	echo "Unapproved service found $val1";
  	exit;
    fi
   
   
done


#######  3 ###############

i=0
end=1023
ports=()
while [ $i -le $end ]; do
    ports+=($i)
    i=$(($i+1))
done


ele1=1023
ports=( "${ports[@]/$ele1}" )


i=0
end=1023
ports=()
while [ $i -le $end ]; do
    ports+=("$i")
    i=$(($i+1))
done


ele1=1023
ports=( "${ports[@]/$ele1}" )



ss -lntu | awk '{print $5}' |tee prt.txt


echo "========================="
portsavail=()



while IFS= read -r line; do

    
    
    arrIN=(${line//:/ })
    numval=${arrIN[1]}
    if [[ $numval =~ ^[0-9]+$ ]]
    then
        
        portsavail+=($numval)
    else
        echo ""
    fi
    
    
done < prt.txt

(IFS=,; printf '[%s]' "${portsavail[*]}")




for val1 in ${portsavail[@]}; do
    
    declare -i flg=0
    
    for val2 in ${ports[@]}; do
        
        if [ "$val1" == "$val2" ]; then
            flg=1
        fi
    done
    
    zero=0;

    if [[ $flg -eq $zero ]]; then
    	echo "Unapproved port $val1";
  
    fi
   
   
done


#########  4 ##############


wget 'https://dev.virtualearth.net/REST/v1/Locations/IN/KL/673525/?&include={includeValue}&maxResults=3&key=AuGDjsbtX3HY018iYIrLucjoUA6peA-GdDwvqIH3-V4R_ceWHv6xdhfcH5gAik_v' -O mfile.json

lati=$(jq .resourceSets[0].resources[0].point.coordinates[0] mfile.json)
longi=$(jq .resourceSets[0].resources[0].point.coordinates[1] mfile.json)




mapstr='https://dev.virtualearth.net/REST/V1/Imagery/Map/Road/9.9816,76.2999?zoomLevel=10&key=AuGDjsbtX3HY018iYIrLucjoUA6peA-GdDwvqIH3-V4R_ceWHv6xdhfcH5gAik_v'

wget -O map.jpg $mapstr





######  5 ##################


sudo arp-scan --interface=eth0 --localnet | awk '{print $2}' | tee mac.txt

alllmacs=()

while IFS= read -r line; do
    n=${#line}
    val=15
    if [[ $n -ge $val ]]; then
  	   alllmacs+=("$line")
        
        fi
    
    
done < mac.txt



ele3="00:50:56:c0:00:08"
new_list=()
for item in ${alllmacs[@]}
do
    if [ "$item" != "$ele3" ]
    then
        new_list+=("$item")
    fi
done

(IFS=,; printf '[%s]' "${new_list[*]}")


# available NIC

lshw -class network -short

# NIC Status

nmcli device status 

# arpsweep of 172.16.1.1

sudo arp-scan --interface=eth0 172.16.1.1












