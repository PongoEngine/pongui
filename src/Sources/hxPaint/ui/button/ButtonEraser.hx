package hxPaint.ui.button;

import jasper.Solver;
import hxPaint.app.Model;

class ButtonEraser extends Button
{
    public var solver :Solver;

    public function new(solver :Solver, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
    }

    override public function onUpdate(model :Model) : Void
    {
        if(model.eraser.isOn) {
            this.isOn = true;
            Main.operation = ERASER;
        }
        else {
            this.isOn = false;
        }
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        solver.addConstraint(this.y == prev.y + prev.height + 40);
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }
}