#!/bin/bash
baseOutDir=$1
if [ -n "$baseOutDir" ]; then
	if [ ! -d "$baseOutDir" ]; then
		echo "Making base output directory $baseOutDir"
		mkdir "$baseOutDir"
	fi
fi

build_dir () {
	srcDir=$1
	dstDir=$2
	if [ -n "$baseOutDir" ]; then
		dstDir="$baseOutDir/$dstDir"
	fi

	params=( "$@" )
	rest=( "${params[@]:2}" )

	if [ ! -d "$dstDir" ]; then
		echo "Making output directory $dstDir"
		mkdir -p "$dstDir"
	else
		rm "$dstDir"/*.txt
	fi

	for f in "$srcDir"/*.txt
	do
		filename=`basename $f`
		outName="$dstDir/$filename"
		echo "Building $f to $outName with params ${rest[@]}"
		php "$f" ${rest[*]} > "$outName"
		if [ $? -ne 0 ]; then
			rm "$outName"
		fi
	done
}

build_dir "Source/SuperMario3DWorld" "Quality/SuperMario3DWorld_1080p" 1920 1080
build_dir "Source/SuperMario3DWorld" "Quality/SuperMario3DWorld_1080pUW" 2560 1080
build_dir "Source/SuperMario3DWorld" "Quality/SuperMario3DWorld_1440p" 2560 1440
build_dir "Source/SuperMario3DWorld" "Quality/SuperMario3DWorld_1800p" 3200 1800
build_dir "Source/SuperMario3DWorld" "Quality/SuperMario3DWorld_2160p" 3840 2160

