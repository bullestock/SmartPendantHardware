from build123d import *
from ocp_vscode import *

with BuildPart() as p:
    Box(5.5, 5.5, 5.5)
    with BuildSketch(p.faces().filter_by(Axis.Z).last):
        Circle(3.5/2)
    extrude(amount=1.6)

show(p)

export_step(p.part, 'sp-display-spacer-1.step')

with BuildPart() as p:
    Box(5.5, 5.5, 5.5)
    with BuildSketch(p.faces().filter_by(Axis.Z).last):
        Circle(3.5/2)
    extrude(amount=1.6)
    with BuildSketch(p.faces().filter_by(Axis.Z).first):
        with Locations((0, 3)):
            Rectangle(6, 3)
    extrude(amount=-6, mode=Mode.SUBTRACT)

show(p)

export_step(p.part, 'sp-display-spacer-2.step')
