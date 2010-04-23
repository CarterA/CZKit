#!/bin/bash
# Written on 04/20/10 by Carter Allen
# Copyright Opt-6 Products, LLC, 2010

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Allowed Arguments
# -i --input Path to the input directory. If omitted, ./ is used.
# -o --output Path to the output directory. If omitted, ./ is used.
# -p --optipng Path to an optipng binary
# -c --compression-level  An integer (1 to 7) describing the amount of
						# compression to apply to PNGs via optipng. 1 
						# is fastest, with the lowest compression ratio. 
						# 7 is the slowest, with the highest compression ratio.
						# Default is 7.
# -s --sips Path to the sips utility. Shouldn't ever need to be used.
# -v --verbose Print status messages to the console.

# Script

# Set Defaults for Variables
INPUT_DIRECTORY="./";
OUTPUT_DIRECTORY="./";
OPTIPNG="./optipng";
COMPRESSION_LEVEL="7";
SIPS="sips";
VERBOSE=false;

# Convert Long Options to Short Options
# Source:  http://kirk.webfinish.com/2009/10/
		#  bash-shell-script-to-use-getopts-with-gnu-style-long-positional-parameters/
for arg
do
    delim=""
    case "$arg" in
		--input) args="${args}-i ";;
		--output) args="${args}-o ";;
		--optipng) args="${args}-p ";;
		--compression-level) args="${args}-c ";;
		--sips) args="${args}-s ";;
		--verbose) args="${args}-v ";;
       #pass through anything else
       *) [[ "${arg:0:1}" == "-" ]] || delim="\""
           args="${args}${delim}${arg}${delim} ";;
    esac
done
eval set -- $args

# Set Variables to Arguments
while getopts ":i:o:p:c:s:v" option 2>/dev/null
do
    case $option in
		i) INPUT_DIRECTORY=${OPTARG[@]};;
		o) OUTPUT_DIRECTORY=${OPTARG[@]};;
		p) OPTIPNG=${OPTARG[@]};;
		c) COMPRESSION_LEVEL=${OPTARG[@]};;
		s) SIPS=${OPTARG[@]};;
		v) VERBOSE=true;;
        *) echo $OPTARG is an unrecognized option;;
    esac
done

# Run the Conversion!
cd $INPUT_DIRECTORY;
for PSD_FILE in *.psd
do
	PNG_FILE=${PSD_FILE%.psd}'.png';
	if ($VERBOSE == true) then
		echo "Converting ""$PSD_FILE""...";
		$SIPS -s format png "$PSD_FILE" --out "$PNG_FILE" > /dev/null;
	else
		$SIPS -s format png "$PSD_FILE" --out "$PNG_FILE" > /dev/null;
	fi
	if ($VERBOSE == true) then 
		echo "Optimizing ""$PNG_FILE""...";
	fi
	$OPTIPNG -o $COMPRESSION_LEVEL -q "$PNG_FILE";
done