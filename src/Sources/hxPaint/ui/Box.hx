package hxPaint.ui;

import jasper.Variable;
import hxPaint.app.Model;

class Box
{
    public var parent (default, null) :Box = null;
    public var firstChild (default, null) :Box = null;
    public var next (default, null) :Box = null;
    public var prev (default, null) :Box = null;

    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;

    public var boundsWidth :Variable;
    public var boundsHeight :Variable;

    public function new() : Void
    {
        x = new Variable();
        y = new Variable();
        width = new Variable();
        height = new Variable();

        boundsWidth = new Variable();
        boundsHeight = new Variable();
    }

    public function onAdded() : Void
    {
    }

    public function onUpdate(model :Model) : Void
    {
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
    }

    public function onUp(x :Int, y :Int) : Void
    {
    }

    public function onDown(x :Int, y :Int) : Void
    {
    }

    public function onMove(x :Int, y :Int) : Void
    {
    }

    public function onSolved() : Void
    {
    }

    public function addChild (child :Box) :Box
    {
        child.parent = this;

        var tail = null, p = firstChild;
        while (p != null) {
            tail = p;
            p = p.next;
        }
        if (tail != null) {
            tail.next = child;
            child.prev = tail;
        } else {
            firstChild = child;
        }

        child.onAdded();

        return this;
    }

    public static function render (box :Box, framebuffer :kha.Framebuffer)
    {
        box.draw(framebuffer);

        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            render(p, framebuffer);
            p = next;
        }
    }

    public static function update(box :Box, model :Model)
    {
        box.onUpdate(model);
        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            update(p, model);
            p = next;
        }
    }

    public static function solve(box :Box)
    {
        box.onSolved();
        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            solve(p);
            p = next;
        }
    }

    public static function hitTest (box :Box, x :Int, y :Int, type :HitType)
    {
        var minX = box.x.m_value;
        var maxX = box.width.m_value + minX;
        var minY = box.y.m_value;
        var maxY = box.height.m_value + minY;
        if(
            minX <= x && maxX >= x &&
            minY <= y && maxY >= y
        ) {
            switch type {
                case DOWN: box.onDown(x,y);
                case UP: box.onUp(x,y);
                case MOVE: box.onMove(x,y);
            }
            var p = box.firstChild;
            while (p != null) {
                var next = p.next;
                hitTest(p, x, y, type);
                p = next;
            }
        }
    }
}

@:enum
abstract HitType(Int)
{
    var DOWN = 0;
    var UP = 1;
    var MOVE = 2;
}