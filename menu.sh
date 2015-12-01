#!/bin/bash

showMenuCRM() {
	menu=$(dialog                                       \
				--stdout								\
				--title 'Menu'                        	\
				--menu 'Choose What you want to do'  	\
				0 0 0                                   \
				'Realestates' 	'Sync Realestates'		\
				'StockCars'   	'Sync StockCars'		\
				'Leave'  		'Left System'
			)
	echo $menu
}

showCountryStockCars() {
	country=$(dialog                                            \
				--stdout										\
				--title 'Pergunta'                            	\
				--menu 'Which country are you working?'  	    \
				0 0 0                                         	\
				'id'   	'Indonesia'      						\
				'in' 	'India'  								\
				'pt'   	'Portugal' 								\
				'ua'   	'Ukraine'  								
			)
	echo $country
}

showCountryRealstates() {
	country=$(dialog                                            \
				--stdout										\
				--title 'Pergunta'                            	\
				--menu 'Which country are you working?'  	    \
				0 0 0                                         	\
				'id'   'Indonesia'      						\
				'pl'   'Poland'  								\
				'pt'   'Portugal'  								\
				'ua'   'Ukraine'  							
			)
	echo $country
}

showSyncing() {
	stop=$(dialog                                            	\
				--stdout										\
				--title 'System is syncing'                     \
				--msgbox 'Click ok to stop.'  					\
				6 40
			)
}

showScriptNotFound() {
	dialog                                            											\
		--title 'Sorry'                             											\
		--msgbox "The script for this country is not implemented yet.\nFile ['$1'] not found"	\
		6 80
}

next="menu"
while : ; do 
	case "$next" in
		Realestates)
			crm="realestates"
			country=$(showCountryRealstates)
			next="Sync"
		;;
		StockCars)
			crm="stockcars"
			country=$(showCountryStockCars)
			next="Sync"
		;;
		Sync)
			next="menu"
			scriptRun="$(pwd)/list/${crm}_${country}.sh"
			if [ ! -e "$scriptRun" ]; 
			then
				showScriptNotFound "$scriptRun"
			else
				nohup "$scriptRun" >/dev/null 2>&1 &
				pid=$!
				showSyncing
				kill -9 "$pid"
			fi
		;;
		Leave)
			echo "In while crocodile!"
			break
		;;
		*)
			next=$(showMenuCRM)
		;;
	esac
done
sleep 3
