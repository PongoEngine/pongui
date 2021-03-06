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

import jasper.Strength;
import jasper.Solver;
import hxPaint.Paint;

class Window extends Rectangle
{
    public function new(paint :Paint, width :Int, height :Int) : Void
    {
        super(paint);
        _initialWidth = width;
        _initialHeight = height;
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.x == 0);
        solver.addConstraint(this.y == 0);
        solver.addEditVariable(this.width, Strength.STRONG);
        solver.addEditVariable(this.height, Strength.STRONG);
        solver.suggestValue(this.width, _initialWidth);
        solver.suggestValue(this.height, _initialHeight);
    }

    public function resize(width :Int, height :Int) : Void
    {
        this.paint.suggest(this.width, width);
        this.paint.suggest(this.height, height);
    }

    private var _initialWidth :Int;
    private var _initialHeight :Int;
}