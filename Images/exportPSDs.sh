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

# Configuration
OPTIPNG='./optipng'; # The path to an optipng binary.

# Script
DIRECTORY='';
if [ $# -eq 0 ]
then
  DIRECTORY=`dirname $0`;
fi
PSD_FILES=*.psd;
for PSD_FILE in $PSD_FILES
do
	PNG_FILE=${PSD_FILE%.psd};
	PNG_FILE=$PNG_FILE'.png';
	sips -s format png "$PSD_FILE" --out "$PNG_FILE" > /dev/null;
	$OPTIPNG -o 7 -q "$PNG_FILE";
done