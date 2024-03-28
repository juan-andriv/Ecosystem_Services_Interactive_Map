# Ecosystem_Services_Interactive_Map
An interactive map developed in Shiny to visualize ecosystem services provision

Designed to be easily used with the csv output file of the iTreeEco software.
Developed by the US Forest Services, iTreeEco is a software capable of modelling ecosystem services based on vegetation dasometric data, the kind of data obtained through a vegetation census or surveys.
Available for free: https://www.itreetools.org/tools/i-tree-eco

The data input shall be a .csv file, and comply with the follwoing style:

| lat   | long  | species | height | crown size | canopy area | ecosystem service x1 | ecosystem service x2 | ecosystem service xn |
|-------|-------|---------|--------|-------|--------|----------------------|----------------------|----------------------|
| XXXX | XXXX | Species A | X.X   | X.X    | X.X     | XX.XX            | XX.XX            | XX.XX            |


The expected output is:
* Main output is a map associated to a scroll-down menu that allows the user to select which ecosystem service to visualize.
* The colour of each dot change depending on the intensity of the ecosystem service provided (scale used goes from green for lower intensities to red for higher intensities)
* By clicking on each dot on the map, a pop-up appears providing some basic information about the tree.
* Additionally, the violin + boxplot diagram to the right is linked to the visualized data, and provides insights into the data distribution.


Example of final output.
![Example image](https://github.com/juan-andriv/Ecosystem_Services_Interactive_Map/assets/163057641/ddf3c9c5-e958-4246-8319-f0df6bf7177a)
