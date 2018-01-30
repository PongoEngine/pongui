/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package;

import kha.System;
import cosmo.Cosmo;

class Main 
{
    public static function main() : Void
    {
        System.init({title: "hxPaint", width: 1366, height: 768}, function() {
            var cosmo = new Cosmo();

            cosmo.window
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER)
                    .appendChild(cosmo.createElement(VERTICAL_DIVIDER))
                    .appendChild(cosmo.createElement(VERTICAL_DIVIDER)))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(VERTICAL_DIVIDER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER))
                .appendChild(cosmo.createElement(CONTAINER));

            cosmo.runLayout();

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(0xffffffff);
                cosmo.render(framebuffer);
                framebuffer.g2.end();
            });
        });
    }

    

    
}