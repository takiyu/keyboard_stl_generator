- [Keyboard Case and Plate STL Generator With Automatic Model Segmentation](#keyboard-case-and-plate-stl-generator-with-automatic-model-segmentation)
  - [How it Works](#how-it-works)
  - [Setup](#setup)
    - [Requirements](#requirements)
    - [Usage](#usage)
    - [Parameters](#parameters)
  - [Example Output](#example-output)
    - [Output Format](#output-format)
    - [Small Layout Test](#small-layout-test)
    - [Full Size ANSI](#full-size-ansi)
  - [Printed Part](#printed-part)
  - [Acknowledgements](#acknowledgements)

# Keyboard Case and Plate STL Generator With Automatic Model Segmentation
This is meant to generate a scad and or stl file from a [keyboard-layout-editor](http://www.keyboard-layout-editor.com/) layout file. 

Additionally the model can be automatically segmented so that the parts will fit within the build area of your 3d printer


## How it Works
The program takes a keyboard-layout-editor json file as one of the inputs along with an optional parameter json file to customize other parts of the resulting model

The program can then genarate a number of different items. The entire case can be generated as a single model or the case can be broken up so that parts will fit within the build size of your 3d printer. The build size is one of the values that can be places in the optional parameters file.


## Setup
### Requirements

- **Python**: Python is required to run the program. This was built using Python 3.8.10 but I expect newer versions should work fine

- **[SolidPython](https**://github.com/SolidCode/SolidPython)**: This program relies on SolidPython to generate the actual OpenSCAD script. To install SolidPython you can most likely use the command bellow

  ```
  pip install solidpython
  ```
- **[OpenSCAD](https://openscad.org/)**: In order to render STL files you will have to have OpenSCAD installed and the OpenSCAD executable must be on your path. OpenSCAD downloads can be found here https://openscad.org/downloads.html

### Usage
- Here is an examle of the program cli usage
  ![keyboard_stl_generator.py usage](/images/usage.png)

- Basic usage
  
  ```
  python keybaord_stl_generator.py -i layout_filename.json
  ```

  This will generate the entire case as one peice. IT will generate top, bottom, plate, and all scad files

- **-f option**: This option defines the number of faces that will be used when rendering a circle. I suggest using at least 32

- **-a option**: This will generate models for all of the separate model sections based on the 3d printer build plate size

- **-e option**: This generates a potentially useful exploded view where all sectons are in one model but the are separated tso they can be seen mroe easily

- **-s option**: This is used to generate just the model for a specific section

### Parameters
- This is an example of a simple parameters file [parameters.json](/parameters.json)
- Here is a list of the possible paramters and what they do
  - 3d Printer Relate Paramters
    - **x_build_size**: X build plate size in mm
    - **y_build_size**: Y build plate size in mm
    - **kerf**: kerf to allow for expansion of material usefuly to give switch holes a bit more space to fit better
  - Plate Only parameters
    - **plate_supports**: Generate support ridges that help to strengthen the plate true or false
    - **plate_thickness**: How thick the plate should be. This will affect how well switched hold into the plate in mm
    - **support_bar_height**: How far down from the top of the plate the support bars should be in mm
    - **support_bar_width**: How wide the support bars should be in mm
  - Plate and Body Parameters
    - **top_margin**: amount of extra material that should be added to top of plate in mm
    - **bottom_margin**: amount of extra material that should be added to bottom of plate in mm
    - **left_margin**: amount of extra material that should be added to left of plate in mm
    - **right_margin**: amount of extra material that should be added to right of plate in mm
    - **case_height**: the height of the case. When tilt is used this will be height of the lowest part of the case in mm
    - **plate_wall_thickness**: How thick the walls of the case should be in mm
    - **plate_corner_radius**: The radius to be used in rounding corners of the case in mm
    - **bottom_cover_thickness**: The thickness of the base palte of the case in mm
    - **tilt**: The number of degrees the case should be tilted forward
  - Mounting Screw Parameters
    - **screw_count**: The number of scre holes to generate. If a cable hole is added and a screw hole would interfere with it the screw hole is not created
    - **screw_diameter**: The diameter of the scres to be used in mm
    - **screw_edge_inset**: How far in off the edge of the plate should the center of the scre hole be.
  - Cable Hole Parameters
    - **cable_hole**: Generate a hole in the back of the case for a cable. true or false
    - **hole_width**: The width of the screw hole in mm
    - **hole_height**: The height of the screw hole in mm
    - **cable_hole_down_offset**: How far down from the bottom of the plate thickness should the screw hole be placed.

## Example Output
### Output Format
- The program exports 4 different files for each model it is set to generate
  - **top**: the top part of a complete case. meant to be screwed to the bottom to make a complete case
  - **bottom**: the bottom of the case with screw posts to connect it to the top of the case
  - **plate**: the plate only eith no case walls. The palte still includes the mounting holes
  - **all**: This is just a render of the entire case as one peice. Not really meant for printing just for reference
- The files will be exported into a folder within the same folder where the layout json file is. The folder will have the name of the layout file without the .json extension
- There will be separate scad and stl folders in the export folder


### Small Layout Test
- This shows testing done using a msall layout and changing the printer build plate settings to force it to split the design up.

  This is an image of the layout design on keyboard-layout-editor

  ![small_test_layout.png](/images/small_test_layout/small_test_layout.png)

- if just passing in the layput fle with the "-i" option the entire case will be generated. An example of the top of the case of that model is shown bellow

  ![small_test_top.png](/images/small_test_layout/small_test_top.png)

- using the "-a" option it will generate files for 2 different models that make up the entire layout. The images bellow show the separate section top case models

  ![small_test_top_0.png](/images/small_test_layout/small_test_top_0.png)

  ![small_test_top_1.png](/images/small_test_layout/small_test_top_1.png)


- using the "-e" file will generate an exploded view of the case where all the sections are shown but they are offset to be viewed more easily. See the iamge bellow

  ![small_test_exploded_top.png](/images/small_test_layout/small_test_exploded_top.png)


### Full Size ANSI
- Bellow is and exploded view of the generated model for a full size keyboard

  ![small_test_exploded_top.png](/images/full_size/full_size_exploded_top.png)


## Printed Part
Here are some pictures of that raw parts from the printer and the assembled case

- Topside of Top
  ![top_topside.jpg](/images/small_test_layout/top_topside.jpg)

- Underside of Top
  ![top_underside.jpg](/images/small_test_layout/top_underside.jpg)

- Top edge on view
  ![top_edge.jpg](/images/small_test_layout/top_edge.jpg)

- Focus on stabilizer cutout
  ![top_stab_cutout.jpg](/images/small_test_layout/top_stab_cutout.jpg)

- Bottom
  ![bottom.jpg](/images/small_test_layout/bottom.jpg)

- Bottom edge on view
  ![bottom_edge.jpg](/images/small_test_layout/bottom_edge.jpg)

- Assembeled Front
  ![assembled_front.jpg](/images/small_test_layout/assembled_front.jpg)

- Assembeled Side
  ![assembled_side.jpg](/images/small_test_layout/assembled_side.jpg)

- Assembeled Tilt 
  ![assembled_tile.jpg](/images/small_test_layout/assembled_tilt.jpg)


## Acknowledgements
Shout out to Will Stevens https://github.com/swill for his plate generator that provided inspiration and very useful measurements. The swillkb plate and case generator is here http://builder.swillkb.com/
