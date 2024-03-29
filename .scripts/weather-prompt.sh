#!/usr/bin/env bash

###############################################################################
#                                                                             #
# AnsiWeather 1.00 (c) by Frederic Cambus 2014                                #
# https://github.com/fcambus/ansiweather                                      #
#                                                                             #
# Created: 2013/08/29                                                         #
# Last Updated: 2014/01/24                                                    #
#                                                                             #
# AnsiWeather is released under the BSD 3-Clause license.                     #
# See LICENSE file for details.                                               #
#                                                                             #
###############################################################################



###[ Configuration options ]###################################################

LC_NUMERIC=C

config_file=~/.ansiweatherrc

function get_config {
	ret=""
	if [ -f $config_file ]
	then
		ret=$(grep "^$1:" $config_file | awk -F: '{print $2}')
	fi

	if [ "X$ret" = "X" ]
	then
		return 1
	else
		echo $ret
	fi
}

fetch_cmd=$(get_config "fetch_cmd" || echo "curl -s")



###[ Check if jq is installed ]###############################################

jqpath="`which jq`"
if [ "$jqpath" == "" ]
then
	echo -e "\njq binary is not found, please download it from http://stedolan.github.io/jq/ and put it in your PATH"
	exit 255
fi



###[ Auto-Location Logic ]####################################################

geo_locate_api="http://www.telize.com/geoip" #geo location service

function auto_locate {
	ret=""

	geo_data=$($fetch_cmd $geo_locate_api)

	city=$(echo $geo_data | jq -r '.city')

	country=$(echo $geo_data | jq -r '.country_code')

	ret=$city,$country

	if [ "$ret" == "," ]
	then
		return 1
	else
		echo $ret
	fi
}

# Location : example "Moscow,RU"
location=$(get_config "location" || auto_locate || echo "Moscow,RU")

# System of Units : "metric" or "imperial"
units=$(get_config "units" || echo "metric")

# Display symbols : "true" or "false" (requires an Unicode capable display)
symbols=$(get_config "symbols" || echo true)

# Show forecast : How many days, example "5". "0" is standard output
forecast=$(get_config "forecast" || echo 0)

# Show daylight : "true" or "false"
daylight=$(get_config "daylight" || echo false)

# Or get config options from command line flags
while getopts l:u:s:f:Fd: option
do
	case "${option}"
	in
		l) location=${OPTARG};;
		u) units=${OPTARG};;
		s) symbols=${OPTARG};;
		f) forecast=${OPTARG};;
		F) forecast="5";;
		d) daylight=${OPTARG};;
	esac
done



#### [ Colors and characters ]#################################################

background_t=$(get_config "background_t" || echo "\033[44m")
background_w=$(get_config "background_w" || echo "\033[44m")
background_h=$(get_config "background_h" || echo "\033[44m")
background_p=$(get_config "background_p" || echo "\033[44m")
text=$(get_config "text" || echo "\033[36;1m")
data_l=$(get_config "data_l" || echo "\033[33;1m")
data_d=$(get_config "data_d" || echo "\033[33;1m")
delimiter_t=$(get_config "delimiter_t" || echo "\033[35m=>")
delimiter_w=$(get_config "delimiter_w" || echo "\033[35m=>")
delimiter_h=$(get_config "delimiter_h" || echo "\033[35m=>")
delimiter_p=$(get_config "delimiter_p" || echo "\033[35m=>")

dashes=$(get_config "dashes" || echo "\033[34m-")



###[ Text Labels ]#############################################################

greeting_text=$(get_config "greeting_text" || echo "Current weather in")
wind_text=$(get_config "wind_text" || echo "Wind")
humidity_text=$(get_config "humidity_text" || echo "Humidity")
pressure_text=$(get_config "pressure_text" || echo "Pressure")
sunrise_text=$(get_config "sunrise_text" || echo "Sunrise")
sunset_text=$(get_config "sunset_text" || echo "Sunset")


###[ Unicode Symbols for icons ]###############################################

sun=$(get_config "sun" || echo "\033[33;1m\xe2\x98\x80")
moon=$(get_config "moon" || echo "\033[36m\xe2\x98\xbd")
clouds=$(get_config "clouds" || echo "\033[37;1m\xe2\x98\x81")
rain=$(get_config "rain" || echo "\xe2\x98\x94")
fog=$(get_config "fog" || echo "\033[37;1m\xe2\x96\x92")
mist=$(get_config "mist" || echo "\033[34m\xe2\x96\x91")
haze=$(get_config "haze" || echo "\033[33m\xe2\x96\x91")
snow=$(get_config "snow" || echo "\033[37;1m\xe2\x9d\x84")
thunderstorm=$(get_config "thunderstorm" || echo "\xe2\x9a\xa1")



###[ Fetch Weather data ]######################################################

api_cmd=$([[ $forecast != 0 ]] && echo "forecast/daily" || echo "weather")
weather=$($fetch_cmd "http://api.openweathermap.org/data/2.5/$api_cmd?q=$location&units=$units")

if [ -z "$weather" ]
then
	echo "ERROR : Cannot fetch weather data"
	exit
fi

status_code=$(echo $weather | jq -r '.cod')

if [ $status_code != 200 ]
then
	echo "ERROR : Cannot fetch weather data for the given location"
	exit
fi



###[ Process Weather data ]####################################################

function epoch_to_date {
	if date -j -r $1 +"%a %b %d" > /dev/null 2>&1; then
		# BSD
		ret=$(date -j -r $1 +"%a %b %d")
	else
		# GNU
		ret=$(date -d @$1 +"%a %b %d")
	fi
	echo $ret
}

if [ $forecast != 0 ]
then
	city=$(echo $weather | jq -r '.city.name')
	flength=$(echo $weather | jq '.list | length')
	forecast=$([[ $forecast -gt $flength ]] && echo $flength || echo $forecast)
	days=()
	dates=()
	lows=()
	highs=()
	humidity=()
	pressure=()
	sky=()
	for i in $(seq 0 $(($forecast-1)))
	do
		days+=("$(echo $weather | jq ".list[$i]")")
		dates+=("$(epoch_to_date $(echo ${days[$i]} | jq -r '.dt'))")
		lows+=("$(printf "%0.0f" $(echo ${days[$i]} | jq -r '.temp.min'))")
		highs+=("$(printf "%0.0f" $(echo ${days[$i]} | jq -r '.temp.max'))")
		humidity+=("$(echo ${days[$i]} | jq -r '.humidity')")
		pressure+=("$(echo ${days[$i]} | jq -r '.pressure')")
		sky+=("$(echo ${days[$i]} | jq -r '.weather[0].main')")
	done
else
	city=$(echo $weather | jq -r '.name')
	temperature=$(printf '%.0f' $(echo $weather | jq '.main.temp'))
	humidity=$(echo $weather | jq '.main.humidity')
	pressure=$(echo $weather | jq '.main.pressure')
	sky=$(echo $weather | jq -r '.weather[0].main')
	sunrise=$(echo $weather | jq '.sys.sunrise')
	sunset=$(echo $weather | jq '.sys.sunset')
	wind=$(echo $weather | jq '.wind.speed')
	azimuth=$(echo $weather | jq '.wind.deg')
fi



###[ Process Wind data ]#######################################################

declare -a directions
directions=(N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW)

if [ $forecast = 0 ]
then
	direction=${directions[$(echo "($azimuth + 11.25)/22.5 % 16" | bc)] }
fi



###[ Process Sunrise and Sunset data ]#########################################

function epoch_to_time {
	if date -j -r $1 +"%r" > /dev/null 2>&1; then
		# BSD
		ret=$(date -j -r $1 +"%b %d %r")
	else
		# GNU
		ret=$(date -d @$1 +"%b %d %r")
	fi
	echo $ret
}

if [ $forecast = 0 ]
then
	if [ -n "$sunrise" ]
	then
		sunrise_time=$(epoch_to_time $sunrise)
	fi

	if [ -n "$sunset" ]
	then
		sunset_time=$(epoch_to_time $sunset)
	fi
fi



###[ Set the period ]##########################################################

now=$(date +%s)

if [ $forecast != 0 ]
then
	period="none"
else
	if [ -z "$sunset" ] || [ -z "$sunrise" ]
	then
		period="day"
	elif [ $now -ge $sunset ] || [ $now -le $sunrise ]
	then
		period="night"
	else
		period="day"
	fi
fi



###[ Set the scale ]###########################################################

case $units in
	metric)
		scale="°C"
		speed_unit="m/s"
		pressure_unit="hPa"
		pressure=$(printf '%.0f' $pressure)
		;;
	imperial)
		scale="°F"
		speed_unit="mph"
		pressure_unit="inHg"
		pressure=$(printf '%.2f' $(echo "$pressure*0.0295" | bc))
		;;
esac



###[ Set icons ]###############################################################

function get_icon {
	case $1 in
		Clear)
			if [ $period = "night" ]
			then
				echo "$moon "
			else
				echo "$sun  "
			fi
			;;
		Clouds)
			echo "$clouds  "
			;;
		Rain)
			echo "$rain  "
			;;
		Fog)
			echo "$fog "
			;;
		Mist)
			echo "$mist "
			;;
		Haze)
			echo "$haze "
			;;
		Snow)
			echo "$snow "
			;;
		Thunderstorm)
			echo "$thunderstorm  "
			;;
	esac
}



###[ Display current Weather ]#################################################

if [ $forecast != 0 ]
then
	output="$background$text $city forecast $text$delimiter "
	for i in $(seq 0 $(($forecast-1)))
	do
		icon=""
		if [ $symbols = true ]
		then
			icon="$(get_icon ${sky[$i]})"
		fi
		output="$output$text${dates[$i]}: $data${highs[$i]}$text/$data${lows[$i]} $scale $icon"
		if [ $i -lt $(($forecast-1)) ]
		then
			output="$output$dashes "
		fi
	done
	output="$output"
	echo -e "$output"
else
	if [ $symbols = true ]
	then
		icon="$(get_icon $sky)"
	fi
	output="$delimiter_t$background_t$data_l$temperature$scale $icon $delimiter_w$background_w$data_l$wind$speed_unit $direction $delimiter_h$background_h$data_l$humidity%% 💧 $delimiter_p$background_p$data_l$pressure$pressure_unit ±"

	if [ $daylight = true ]
	then
		output="$output $dashes$text $sunrise_text $delimiter$data $sunrise_time $dashes$text $sunset_text $delimiter$data $sunset_time"
	fi

	output="$output \033[0m"

	echo -e "$output"
fi