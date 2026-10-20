#!/bin/sh
# Create tools/python/venv from the vendored wheels (no network needed for Python 3.11 on x86-64
# Linux; on other versions pip falls back to downloading).  Use it as tools/python/venv/bin/python.
set -e
cd "$(dirname "$0")"
python3 -m venv venv
venv/bin/pip install --quiet --find-links wheels -r requirements.txt
echo "ready: $(pwd)/venv/bin/python"
