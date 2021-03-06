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
import hxPaint.Paint;

using hxPaint.layout.LayoutTools;

class HeaderList extends Rectangle
{
    public function new(paint :Paint) : Void
    {
        super(paint);
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.left() == parent.left());
        solver.addConstraint(this.top() == parent.bottom());
        solver.addConstraint(this.width == 180);

        var lastchild = this.children[this.children.length -1];
        solver.addConstraint(this.bottom() == lastchild.bottom());
    }

    public function open() : Void
    {
        for(c in children) {
            cast(c, HeaderListItem).open();
        }
    }

    public function close() : Void
    {
        for(c in children) {
            cast(c, HeaderListItem).close();
        }
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff484848;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff212121;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value,2);
    }
}