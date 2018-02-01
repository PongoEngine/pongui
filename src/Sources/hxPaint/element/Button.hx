/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package hxPaint.element;

import jasper.Solver;
import hxPaint.Paint;

using hxPaint.layout.LayoutTools;

class Button extends Rectangle
{
    public function new(paint :Paint) : Void
    {
        super(paint);
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.left() == parent.left() + 5);
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == this.width);

        if(prevSibling == null) {
            solver.addConstraint(this.top() == parent.top() + 5);
        }
        else {
            solver.addConstraint(this.top() == prevSibling.bottom() + 5);
        }
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff212121;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);

        if(_isOn) {
            framebuffer.g2.color = 0xffb2dfdb;
            framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value, 2);
        }
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        if(_isOn) {
            turnOff();
        }
        else {
            turnOn();
        }

        turnOffOthers();
    }

    public function turnOn() : Void
    {
        _isOn = true;
    }

    public function turnOff() : Void
    {
        _isOn = false;
    }

    private function turnOffOthers() : Void
    {
        var buttons :Array<Button> = this.paint.window.getAll(Button);
        for(button in buttons) {
            if(button != this) {
                button.turnOff();
            }
        }
    }

    private var _isOn :Bool;
}