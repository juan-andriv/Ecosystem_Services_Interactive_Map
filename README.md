# Ecosystem_Services_Interactive_Map
An interactive map developed in Shiny to visualize ecosystem services provision

Designed to be easily used with the csv output file of the iTreeEco software.
Developed by the US Forest Services, iTreeEco is a software capable of modelling ecosystem services based on vegetation dasometric data, the kind of data obtained through a vegetation census or surveys.
Available for free: https://www.itreetools.org/tools/i-tree-eco

The data input shall be a .csv file, and comply with the follwoing style:

| lat   | long  | species | height | crown size | canopy area | ecosystem service x1 | ecosystem service x2 | ecosystem service xn |
|-------|-------|---------|--------|-------|--------|----------------------|----------------------|----------------------|
| XXXX | XXXX | Species A | X.X   | X.X    | X.X     | XX.XX            | XX.XX            | XX.XX            |


The expected output is a map associated to a scrolldown menu that allows the user to select which ecosystem service to visualize.
By clicking on each tree, a pop-up should show up detailing basic information of the tree.
The colour of each dot should change depending on the intensity of the ecosystem service provided.

Final output:

![image](https://github.com/juan-andriv/Ecosystem_Services_Interactive_Map/assets/163057641/04c8b417-82a3-4cb6-ab20-765c36777b3d)
