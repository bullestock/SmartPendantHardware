from build123d import *
from ocp_vscode import *

with BuildPart() as p:
    Cylinder(3.5, 6)
    with BuildSketch(p.faces().filter_by(Axis.Z).last):
        Circle(3.3/2)
    extrude(amount=-10, mode=Mode.SUBTRACT)

show(p)

export_step(p.part, 'sp-pcb-spacer.step')
