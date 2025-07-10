#!/bin/bash

./bump.py
git add -u
git commit -m update
git push
