#!/bin/bash
python ./keyboard_stl_generator.py -i ./layout_files/takiyu_left.json -r -p ./layout_files/takiyu_param_left.json
python ./keyboard_stl_generator.py -i ./layout_files/takiyu_right.json -r -p ./layout_files/takiyu_param_right.json
