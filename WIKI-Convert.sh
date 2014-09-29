#!/bin/bash
# change from Wiki to HTML
# Maybe one day I'll be happy about this script and stop adding to it.
clear
echo "Before continuing please make sure that there is only one CSV file in
this directory. Please also make sure that there are only two fields on the CSV:
%PRODUCTID and zoovy:prod_desc, in that order. Remember to have a backup of
your file before running this script in the event this really screws up.
Press CTRL+C to cancel the script, press Enter to continue."
read
clear
mkdir archive
cp *.csv archive/
mv *.csv html.csv
# remove titles from all cells
# comment out below line if keeping titles and changing to p and h1
sed -i 's/\"==.*/\"/g' html.csv
# count how many times we need to run loops below
titles=$(grep -o '==' html.csv | wc -l)
featureswt=$(grep -o '=' html.csv | wc -l)
features=$(( $featureswt - ($titles * 2)))
bullets=$(grep -o '*' html.csv | wc -l)
count=0
n=1
left=0
# Check for even amount of single and double Equals. Alert if odd.
if [ $(($titles % 2)) -eq 0 ]
	then
		echo "Even, continue."
	else
		echo "Odd amount of double equals. Should be even. Check for errors when complete."
		echo "Press any key to continue."
		read
fi

if [ $(($features % 2)) -eq 0 ]
	then
		echo "Even, continue."
	else
		echo "Odd amount of single equals. Should be even. Check for errors when complete."
		echo "Press any key to continue."
		read
fi

# Replace single and double quotes.
while [ $count -lt $titles ];
do
	if [ "$n" == 1 ]; then
		sed -i '0,/==/s//<p><h1>/' html.csv
		n=$(( $n + 1 ))
	fi
	
	if [ "$n" == 2 ]; then
		sed -i '0,/==/s//<\/h1><\/p>/' html.csv
		n=$(( $n - 1 ))
	fi
count=$(( $count + 2 ))
left=$(( $titles - $count ))
clear
printf "Converting $titles Double Equals. \n"
printf "$left Double Equals Left. \n"
printf "$features Single Equals Left. \n"
printf "$bullets Bullets Left. \n"
done

count=0
n=1
features=$(grep -o '=' html.csv | wc -l)
while [ $count -lt $features ];
do
	if [ "$n" == 1 ]; then
		sed -i '0,/= /s//<p><h2>/' html.csv
		n=$(( $n + 1 ))
	fi
	if [ "$n" == 2 ]; then
		sed -i '0,/ =/s//<\/h2><\/p>/' html.csv
		n=$(( $n - 1 ))
	fi
	count=$(( $count + 2 ))
	lfeatures=$(( $features - $count ))
	clear
	printf "Converting $features Single Equals \n"
	printf "0 Double Equals left \n"
	printf "$lfeatures Single Equals Left \n"
	printf "$bullets Bullets Left \n"
done
clear
printf "Converting $bullets Bullets. \n"
printf "0 Double Equals left \n"
printf "0 Single Equals Left \n"
printf "$bullets Bullets Left - I cant (don't want to) count these, sorry. \n"

# replace * with <li> and append </li> to all lines that now have <li>
# there is probably a faster/less ugly way of doing this, but it works
sed -i 's/*/<li>/g' html.csv
echo "20% of Bullets Converted"
sed -i '/<li>/s/$/imnogoodatsed/' html.csv
echo "40% of Bullets Converted"
sed -i 's/\"imnogoodatsed/<\/li>\"/g' html.csv
echo "60% of Bullets Converted"
sed -i 's/imnogoodatsed/<\/li>/g' html.csv
echo "80% of Bullets Converted"
sed -i "s/\"<\/li>/<\/li>\"/g" html.csv
echo "100 % of Bullets Converted. Dotting I's and Crossing T's."
# cleanup
tr -d '\b\r' < html.csv > newhtml.csv
mv newhtml.csv html.csv
sed -i "s/\"<\/li>/<\/li>\"/g" html.csv
# Alert user
printf '@ECHO OFF\necho msgbox "HTML Converstion Complete. Please input new file name." > tmp.vbs\nwscript tmp.vbs\ndel tmp.vbs' > alert.bat
chmod 775 alert.bat
./alert.bat
rm alert.bat
# rename new csv to user input
printf "Wiki to HTML conversion complete. \n"
echo "Please enter the new file name. (No spaces please)"
read fname
mv html.csv $fname.csv
clear
echo "Hopefully I didn't screw up too badly. Please remember to completely review the file before uploading."
