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

package hxPaint.element.header;

import jasper.Solver;
import jasper.Strength;
import hxPaint.Paint;

using hxPaint.layout.LayoutTools;

class SubHeaderListItem extends Rectangle
{
    public function new(paint :Paint, title :String) : Void
    {
        super(paint);

        _title = title;
        _height = kha.Assets.fonts.Roboto_Black.height(18);
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.top() == parent.top());
        solver.addConstraint(this.left() == parent.right());
        solver.addConstraint(this.height == parent.height);
        solver.addEditVariable(this.width, Strength.STRONG);
        close();
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff484848;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        
        framebuffer.g2.color = 0xffffffff;
        var centerY = y.m_value - _height/2 + height.m_value/2;
        framebuffer.g2.drawString(_title, x.m_value + 20, centerY);
        
        framebuffer.g2.color = 0xff212121;
        framebuffer.g2.drawLine(x.m_value, y.m_value, x.m_value + width.m_value, y.m_value,1);
    }

    public function open() : Void
    {
        this.paint.suggest(this.width, OPEN_WIDTH);
    }

    public function close() : Void
    {
        this.paint.suggest(this.width, 0);
    }

    private static inline var OPEN_WIDTH = 100;
    private var _title :String;
    private var _width :Float;
    private var _height :Float;
}