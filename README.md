# WARTHOG

## Introduction

This repository is a V-REP simulation of the ClearPath Robotics Warthdog robot. This robot is an **U**nmanned **G**round **V**ehicle (**UGV**)  robot which is amphibious. It's a large all-terrain unmanned ground vehicle capable of traveling on land and in water. Both documentation and additionnal informations are available at [ClearPath Robotics Warthdog](https://clearpathrobotics.com/warthog-unmanned-ground-vehicle-robot/).

## :barber: Tracker :barber:
Here is a tracker for each task we have to do.

| Task                   |Responsible | Progression      |
| -----------------------|:----------:|:----------------:|
| Dimensions CAO         |Jules       |:heavy_check_mark:|
| Dynamic Modelization   |Quentin     |:heavy_check_mark:|
| Joint Configuration    |Gwendal     |:heavy_check_mark:|
| Mesh Importing         |Jacques     |:x:               |
| Lua/ROS interface      |Paul-Antoine|:heavy_check_mark:|              |
| Test on damaged terrain|            |:x:               |


## CAO

The CAO is available in the [/docs/cao/](https://github.com/gwendalp/WARTHOG/tree/master/docs/cao). It was found on the official Warthog github repository. We assemble it on Autodesk Inventor the CAO in order to get the dimensions of the robot. Let's have a look at the CAO :

<p align="center">
    <img src="https://raw.githubusercontent.com/gwendalp/WARTHOG/master/docs/images/cao.png" width="300">
</p>

Here are the mesh object we will use in the mesh importing section :

<p align="center">
    <img src="https://raw.githubusercontent.com/gwendalp/WARTHOG/master/docs/images/mesh.png" width="300">
</p>

## Dynamic Modelization

Because the processing of too complex shapes can be very difficult, we have to modelize the robot with box and cylinder in order to process dynamic and collision of the robot. Here is the final dynamic modelization :

<p align="center">
    <img src="https://raw.githubusercontent.com/gwendalp/WARTHOG/master/docs/images/dynamic_modelization.png" width="300">
</p>

## Joint Configuration

We now have to configure joint on our robot. There is one revolute joint for each of the four wheel, and one revolute joint between each of the two buggy and the main chassis. So we have six revolute joint to configure. Then we need to motorized each wheel's joint and to let free the others. Finally, we added springs between the two buggys and the main chassis in order to bring the chassis back upright. 

## Authors

* **Jules Berhault** - 
* **Quentin Brateau** -  [Teusner](https://github.com/Teusner) :sunglasses:
* **Paul-Antoine Le Tolguennec** - 
* **Gwendal Priser** - [gwendalp](https://github.com/gwendalp) :ocean:

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details


