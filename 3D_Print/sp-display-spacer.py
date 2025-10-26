from build123d import *
from ocp_vscode import *

with BuildPart() as p:
    Box(5.5, 5.5, 5.5)
    with BuildSketch(p.faces().filter_by(Axis.Z).last):
        Circle(3.5/2)
    extrude(amount=1.6)

show(p)

export_step(p.part, 'sp-display-spacer.step')
