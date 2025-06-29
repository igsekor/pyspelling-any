#!/bin/sh -l

# Default to an empty config file if not specified
SPELLCHECK_CONFIG_FILE="${INPUT_CONFIGFILE}"

# If no config file is provided, fallback to predefined file names
if [ -z "$SPELLCHECK_CONFIG_FILE" ]; then
    if [ -f "./.spellcheck.yml" ]; then
        SPELLCHECK_CONFIG_FILE=".spellcheck.yml"
    elif [ -f "./.spellcheck.yaml" ]; then
        SPELLCHECK_CONFIG_FILE=".spellcheck.yaml"
    elif [ -f "./spellcheck.yml" ]; then
        SPELLCHECK_CONFIG_FILE="spellcheck.yml"
    else
        SPELLCHECK_CONFIG_FILE="spellcheck.yaml"
    fi
fi

echo ""
echo ">>> Tools & Versions"
echo "> python $(python --version)"
echo ""
echo "> pip3 $(pip --version)"
echo ""
echo "> pyspelling $(pip3 show pyspelling)"
echo ""
echo "> pyyaml $(pip3 show pyyaml)"
echo "<<<"
echo ""

echo "Starting..."
echo "Setup languages and spelling tool..."
apt-get install -y $(python /extract-lang.py $SPELLCHECK_CONFIG_FILE)

rm -rf /var/lib/apt/lists/*

echo "Using PySpelling according to configuration from $SPELLCHECK_CONFIG_FILE"

pyspelling --config $SPELLCHECK_CONFIG_FILE

EXITCODE=$?

test $EXITCODE -gt 1 && echo "\033[91mSpelling check action failed, please check diagnostics\033[39m"

test $EXITCODE -eq 1 && echo "\033[91mFiles in repository contain spelling errors\033[39m"

exit $EXITCODE
